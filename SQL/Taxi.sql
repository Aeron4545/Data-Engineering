DECLARE @Databasename VARCHAR(128)= 'green_taxi_DB';

IF NOT EXISTS(select 1 FROM sys.databases where name=@Databasename)
BEGIN
     DECLARE @SQL NVARCHAR(MAX)='CREATE DATABASE ' + QUOTENAME(@Databasename)
	 EXEC sp_executesql @SQL;
END

USE green_taxi_DB;

-- Create the table with the specified columns
CREATE TABLE trips (
    VendorID INT,
    lpep_pickup_datetime varchar(50),
    lpep_dropoff_datetime varchar(50),
    store_and_fwd_flag CHAR(1), -- Single character flag (e.g., 'Y' or 'N')
    RatecodeID INT,
    PULocationID INT,
    DOLocationID INT,
    passenger_count INT,
    trip_distance FLOAT, -- Float for decimal values
    fare_amount DECIMAL(10, 2), -- DECIMAL type with 2 decimal places for currency
    extra DECIMAL(10, 2),
    mta_tax DECIMAL(10, 2),
    tip_amount DECIMAL(10, 2),
    tolls_amount DECIMAL(10, 2),
    ehail_fee DECIMAL(10, 2),
    improvement_surcharge DECIMAL(10, 2),
    total_amount DECIMAL(10, 2),
    payment_type INT, -- Integer type for payment type
    trip_type INT, -- Integer type for trip type
    congestion_surcharge DECIMAL(10, 2)
);


BULK INSERT trips FROM 'D:/2021_Green_Taxi_Trip_Data.csv'
WITH
(
	FIELDTERMINATOR=',', --'|',';','\t','' , also remember the ascii value of all these
	ROWTERMINATOR='0x0a' ,  -- Carriage and New Line Character - '\r\n','\n',
	                     --'' ,also remember the ascii value of all these i.e '\0x0A' (line feed)
	FIRSTROW=2    --skip the header from the records
);

select * from trips;

--13) Rank the Pickup Locations by Average Trip Distance and Average Total Amount.

select
	PULocationID,
	avg(trip_distance) as avg_trip_distance,
	avg(total_amount) as avg_trip_distance,
	DENSE_RANK() OVER(ORDER BY avg(trip_distance) desc,avg(total_amount) desc) as Rank
from trips
group by PULocationID

--14) Find the Relationship Between Trip Distance & Fare Amount

select
	trip_distance,
	avg(fare_amount)
from trips 
where fare_amount>0
group by trip_distance
order by trip_distance

--Insight: No relation between trip_distance and fare_amount

--15) Identify Trips with Outlier Fare Amounts within Each Pickup Location

select * from 
(select PULocationID,fare_amount, NTILE(4) OVER(PARTITION BY PULocationID ORDER BY fare_amount) as quartile
from trips) as c where quartile=1 or quartile=4

select 
	PULocationID, fare_amount
from
(select
	PULocationID, fare_amount,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY fare_amount) OVER(PARTITION BY PULocationID) as Q1,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY fare_amount) OVER(PARTITION BY PULocationID) as Q2,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY fare_amount) OVER(PARTITION BY PULocationID) as Q3,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY fare_amount) OVER(PARTITION BY PULocationID)-
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY fare_amount) OVER(PARTITION BY PULocationID) as IQR
	from trips) as quartiles
	where fare_amount<Q1-1.5*IQR or fare_amount>Q3+1.5*IQR

--16) Categorize Trips Based on Distance Travelled


select trip_distance,
CASE 
WHEN trip_distance>Median THEN 'High'
WHEN trip_distance<Median THEN 'Low'
END AS Category
from (SELECT PULocationID,trip_distance,PERCENTILE_CONT(0.5) 
	       WITHIN GROUP (ORDER BY trip_distance) OVER() AS Median
    FROM trips) as c

--17) Top 5 Busiest Pickup Locations, Drop Locations with Fare less than median total fare

select Top(5) PULocationID,count(PULocationID) Busiest
from
    (SELECT PULocationID,fare_amount,PERCENTILE_CONT(0.5) 
	       WITHIN GROUP (ORDER BY fare_amount) OVER() AS Median
    FROM trips) as c
where fare_amount<Median
group by PULocationID
order by count(PULocationID) desc



--18) Distribution of Payment Types

select payment_type,count(payment_type)
from trips
where payment_type>0
group by payment_type

--19) Trips with Congestion Surcharge Applied and Its Percentage Count.
select CS_Applied,(count(*)*100)/(select count(*) from trips where congestion_surcharge is not null) as per
from (select
	CASE 
	WHEN congestion_surcharge=0 THEN 'No'
	WHEN congestion_surcharge>0 or congestion_surcharge<0 THEN 'Yes'
	END AS CS_Applied
from trips
where congestion_surcharge is not null) as c
group by CS_Applied

select congestion_surcharge

SELECT COUNT(*) AS CongestionCount,(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM trips)) AS Percentage
FROM trips
WHERE congestion_surcharge IS NOT NULL;


--20) Top 10 Longest Trip by Distance and Its summary about total amount.

select TOP(10) trip_distance,avg(total_amount) as avg_total_fare
from trips
group by trip_distance
order by trip_distance desc

--21) Trips with a Tip Greater than 20% of the Fare

select  PULocationID,DOLocationID,tip_amount,total_amount
from trips
where tip_amount>((20/100)*total_amount)

--22) Average Trip Duration by Rate Code

select ratecodeid as Rate_Code,avg(duration) as AVG_Duration
from
(select 
	RATECODEID,
	lpep_pickup_datetime,
	lpep_dropoff_datetime,DATEDIFF(MINUTE,lpep_pickup_datetime,lpep_dropoff_datetime) as duration 
from trips) as c
where RatecodeID>0
group by RatecodeID


--23) Total Trips per Hour of the Day


select 
    lpep_pickup_datetime,
	DATEPART(HOUR,lpep_pickup_datetime)
from trips

select 
	DATEPART(HOUR,lpep_pickup_datetime) as Day_Hour,
	count(*) as trip_count
from trips
group by 
	DATEPART(HOUR,lpep_pickup_datetime)


--24) Show the Distribution about Busiest Time in a Day.

select 
	DATEPART(HOUR,lpep_pickup_datetime) as Day_Hour,
	count(*) as trip_count
from trips
group by 
	DATEPART(HOUR,lpep_pickup_datetime)
order by 
	trip_count desc

