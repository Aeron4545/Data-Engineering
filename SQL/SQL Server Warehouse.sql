DECLARE @Databasename VARCHAR(128)= 'warehouseDB';

IF NOT EXISTS(select 1 FROM sys.databases where name=@Databasename)
BEGIN
     DECLARE @SQL NVARCHAR(MAX)='CREATE DATABASE ' + QUOTENAME(@Databasename)
	 EXEC sp_executesql @SQL;
END

USE warehouseDB;

CREATE TABLE [dbo].fmcg (
    Ware_house_ID VARCHAR(20) PRIMARY KEY,
    WH_Manager_ID VARCHAR(20),
    Location_type VARCHAR(10),
    WH_capacity_size VARCHAR(10),
    zone VARCHAR(10),
    WH_regional_zone VARCHAR(20),
    num_refill_req_l3m INT,
    transport_issue_l1y INT,
    Competitor_in_mkt INT,
    retail_shop_num INT,
    wh_owner_type VARCHAR(20),
    distributor_num INT,
    flood_impacted int,
    flood_proof int,
    electric_supply int,
    dist_from_hub INT,
    workers_num INT,
    wh_est_year INT,
    storage_issue_reported_l3m INT,
    temp_reg_mach VARCHAR(10),
    approved_wh_govt_certificate VARCHAR(20),
    wh_breakdown_l3m INT,
    govt_check_l3m INT,
    product_wg_ton INT
);

BULK INSERT fmcg FROM 'D:/FMCG_data.csv'
WITH
(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2    --skip the header from the records
);


select * from fmcg;

  -- 1.Show number of records

  select count(*) as Number_Of_Records from fmcg;

  --2.  Write a query to Find WareHouse with Maximum capacity of storage(top five)

  select Top(5) Ware_house_ID,product_wg_ton from fmcg ORDER BY product_wg_ton desc;

  --3.  Write a query to Find WareHouse with Minimum capacity of storage(bottom five)

  select Top(5) Ware_house_ID,product_wg_ton from fmcg ORDER BY product_wg_ton asc;

  --4. Find Total Number of WH Regional Zone Count of Each Category.

  select WH_regional_zone as Zone,count(WH_regional_zone) as Count from fmcg group by WH_regional_zone order by Count desc;

  --5. Find average minimum,maximum,median value of distance from HUB for
  ---warehouse with minimum capacity 10000 and location type urban


WITH Warehouse AS (
    SELECT dist_from_hub,PERCENTILE_CONT(0.5) 
	       WITHIN GROUP (ORDER BY dist_from_hub) OVER() AS Median
    FROM fmcg
    WHERE product_wg_ton > 10000 AND location_type = 'Urban'
)

SELECT max(Median) as Median,max(dist_from_hub) as Max,min(dist_from_hub) as Min, abs(avg(dist_from_hub)) as Average FROM Warehouse;


--breaking it down

  SELECT dist_from_hub,PERCENTILE_CONT(0.5) 
	       WITHIN GROUP (ORDER BY dist_from_hub) OVER() AS Median
    FROM fmcg
    WHERE product_wg_ton > 10000 AND location_type = 'Urban'   -- from this the necessary values are calculated
 
 --6. Window Function - mainly helps to rank the data
 -- In sql server window function performs calculations across set of table rows. Unlike
 -- aggregate function which returns a single value for group of rows.
 --window functions return a value for each row in result set.

 select * from fmcg;

 --ranking the warehouses by the product_wg_ton while being grouped by competitor in market
 select Ware_house_ID, Location_type,zone,wh_owner_type, product_wg_ton,Competitor_in_mkt,
 RANK() OVER(PARTITION BY Competitor_in_mkt ORDER BY product_wg_ton DESC)
 AS WH_RANK FROM FMCG;

 --ranking the warehouses by the retail_shop_num while being grouped by approved_wh_govt_certificate
select Ware_house_ID, Location_type,zone,wh_owner_type, retail_shop_num,approved_wh_govt_certificate,
 RANK() OVER(PARTITION BY approved_wh_govt_certificate ORDER BY retail_shop_num DESC)
 AS WH_RANK FROM FMCG

  --ranking the warehouses by the workers_num while being grouped by WH_regional_zone
  --same value for same category returns same rank
 select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
    RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC) AS WH_RANK 
FROM 
	FMCG;

  --using dense rank to solve the previous issue of same rank
 select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC) AS WH_RANK 
FROM 
	FMCG;


 --Show Top 5 Rank 
 --using CTE with

 with regional_table AS (select Ware_house_ID, Location_type,zone,wh_owner_type, WH_regional_zone,workers_num,
 DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
 AS WH_RANK FROM FMCG) 
 select * from regional_table where WH_RANK<=5;

 --using nested/sub query
 select * from (select Ware_house_ID, Location_type,zone,wh_owner_type, WH_regional_zone,workers_num,
 DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
 AS WH_RANK FROM FMCG) as c WHERE WH_RANK<=5;

 --Show first 5 Rows

 select Top(5) Ware_house_ID, Location_type,zone,wh_owner_type, WH_regional_zone,workers_num,
 DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
 AS WH_RANK FROM FMCG

 -- Lag & Lead

select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	LAG(product_wg_ton,1) OVER(PARTITION BY zone ORDER BY workers_num DESC) AS WH_RANK 
FROM 
	FMCG


select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	LAG(product_wg_ton,2) OVER(PARTITION BY zone ORDER BY workers_num DESC) AS WH_RANK 
FROM 
	FMCG;


select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	LEAD(product_wg_ton,1) OVER(PARTITION BY zone ORDER BY workers_num DESC) AS WH_RANK 
FROM 
	FMCG


--Distribute Each Row into Percentiles.
select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	NTILE(4) OVER(ORDER BY product_wg_ton DESC) AS Quartiles
FROM 
	FMCG


--Distribute Each Row into Percentiles.
select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	NTILE(5)OVER(ORDER BY product_wg_ton DESC) AS Five_Percentiles
FROM 
	FMCG



select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	PERCENT_RANK() OVER(ORDER BY product_wg_ton DESC) AS Percentiles
FROM 
	FMCG

--show all records where number of workers comes in range (0th-40th Percentile)





--Find the difference between current value of product weight ton and compare it with previous
--2 values Lag(2) and rank overall records as per differences


select *, DENSE_RANK() OVER(ORDER BY diff desc) from (select *,previous-product_wg_ton as diff from (select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	LAG(product_wg_ton,2) OVER(ORDER BY product_wg_ton desc) AS previous 
FROM 
	FMCG) as c where previous>0) as d


--alternate method
select *,previous-product_wg_ton as diff, DENSE_RANK() OVER(GROUP BY previous-product_wg_ton ) from (select 
	Ware_house_ID, 
	Location_type,
	zone,
	wh_owner_type, 
	WH_regional_zone,
	workers_num,
	product_wg_ton,
	LAG(product_wg_ton,2) OVER(ORDER BY product_wg_ton desc) AS previous 
FROM 
	FMCG) as c where previous>0CG)