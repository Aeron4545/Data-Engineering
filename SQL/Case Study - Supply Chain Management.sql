-- Case Study - Supply Chain Management

--a) Find the Shape of the FMCG Table. 
--Question: How would you determine the total number of rows and columns in the FMCG dataset?

select count(*) as Row_Count from fmcg;

select count(*) as Column_Count from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='fmcg';

--b) Evaluate the Impact of Warehouse Age on Performance. 
--Question: How does the age of a warehouse impact its operational performance, 
--specifically in terms of storage issues reported in the last years?

select (YEAR(GETDATE()) - wh_est_year) as WarehouseAge, avg(storage_issue_reported_l3m) as AVG_Storage_Issue from fmcg where wh_est_year is not Null
group by (YEAR(GETDATE()) - wh_est_year) ORDER BY WarehouseAge asc;

--Studying the query response we can say there is positive coorelation or 
--Direct relation between WarehouseAge and AVG_Storage_Issue

-- c) Analyze the Relationship Between Flood-Proof Status and Transport Issues. 
--Question: Is there a significant relationship between flood-proof status and the number of transport issues reported in the last year?

select flood_proof,sum(transport_issue_l1y) as total_transport_issue
from fmcg
group by flood_proof;

--Insight: More transportation issues have been found, for non flood proof warehouses.

--d) Evaluate the Impact of Government Certification on Warehouse Performance. 
--Question: How does having a government certification impact the performance of warehouses, particularly in terms of breakdowns and storage issues?

select approved_wh_govt_certificate,avg(storage_issue_reported_l3m) as avg_breakdonwn,avg(wh_breakdown_l3m) as avg_breakdown
from fmcg
GROUP BY approved_wh_govt_certificate;

--Insight: Comparing values of approved _govt_certificate and sum of 
--breakdown and avg of storage issues no relation found among all

--e) Determine the Optimal Distance from Hub for Warehouses:
--Question: What is the optimal distance from the hub for warehouses to minimize transport issues, based on the data provided?

select avg(dist_from_hub), transport_issue_l1y from fmcg group by transport_issue_l1y
order by transport_issue_l1y;

--Insight: optimum distance from hub must be less than equal to 162 for 
--no transportation issue

--f) Identify the Zones with the Most Operational Challenges.
--Question: Which zones face the most operational challenges, considering factors like transport issues, 
--storage problems, and breakdowns?

select 
	zone,
	sum(transport_issue_l1y) as transport_issue,
	sum(storage_issue_reported_l3m) as storage_issue,
	sum(wh_breakdown_l3m) as breakdown_issue,
    (sum(transport_issue_l1y)+sum(storage_issue_reported_l3m)+sum(wh_breakdown_l3m)) as total_operation_issue
from fmcg
group by zone
order by total_operation_issue

--Insight: 


--Examine the Effectiveness of Warehouse Distribution Strategy. 
--Question: How effective is the current distribution strategy in each zone, 
--based on the number of distributors connected to warehouses and their respective product weights?

select 
	Ware_house_ID, 
	(YEAR(GETDATE())-wh_est_year) as warehouse_age,
	wh_breakdown_l3m,
CASE 
	WHEN wh_breakdown_l3m >= 5 THEN 'High_Risk'
	WHEN wh_breakdown_l3m >= 3 THEN 'Medium_Risk'
	ELSE 'Low_Risk'
END AS Risk_Level
from fmcg WHERE (YEAR(GETDATE())-wh_est_year)>15 ORDER BY wh_breakdown_l3m DESC;

-- h) Examine the Effectiveness of Warehouse Distribution Strategy. 
--Question: How effective is the current distribution strategy in each zone, 
--based on the number of distributors connected to warehouses and their respective product weights?

select zone,sum(distributor_num) as a,sum(product_wg_ton) as b, sum(product_wg_ton)/sum(distributor_num) as c
from fmcg
group by zone
order by c;

--Insight: Current distribution plan is best in east zone and worst in south and west


--Correlation Between Worker Numbers and Warehouse Issues. 
--Question: Is there a correlation between the number of workers in a warehouse and 
--the number of storage or breakdown issues reported?

select
	workers_num,
	avg(wh_breakdown_l3m),
	avg(storage_issue_reported_l3m)
from
	fmcg
group by workers_num
order by workers_num

--No relation

-- j) Assess the Zone-wise Distribution of Flood Impacted Warehouses.
--Question: Which zones are most affected by flood impacts, and how does this affect their overall operational stability?

select
	zone,count(*) as Total_Warehouse,
	sum(flood_impacted) AS flood_impacted_warehouse,
	sum(flood_impacted)*100/count(*) AS flood_impacted_percentage
from fmcg
group by zone
order by flood_impacted_percentage desc;

--Insight: Analyzing all zones flood impacted warehouse percentage can be concluded that North Zone warehouse highy affected by flood


-- k) Calculate the Cumulative Sum of Total Working Years for Each Zone. 
--Question: How can you calculate the cumulative sum of total working years for each zone?

select zone,sum(YEAR(GETDATE()) - wh_est_year) OVER(ORDER BY zone ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_age
from fmcg;

--to understand the above code
select 
	zone, 
	YEAR(GETDATE()) - wh_est_year
from fmcg
order by zone;


-- l) Calculate the Cumulative Sum of Total Working Years for Each Warehouse Govt. Rating. 
--Question: Write a query to calculate the cumulative sum of total workers for each warehouse govt. rating?

select approved_wh_govt_certificate,workers_num,sum(workers_num) OVER(ORDER BY approved_wh_govt_certificate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_workers_num
from fmcg;

--if we need cumulative for each zone
select 
	approved_wh_govt_certificate,
	workers_num,
	sum(workers_num) 
	OVER(PARTITION BY approved_wh_govt_certificate ORDER BY approved_wh_govt_certificate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_workers_num
from fmcg;

--m) Rank Warehouses Based on Distance from the Hub. 
--Question: How would you rank warehouses based on their distance from the hub?

select Ware_house_ID,dist_from_hub,DENSE_RANK() OVER(ORDER BY dist_from_hub asc) as Rank from fmcg;


--n) Calculate the Running avg of Product Weight in Tons for Each Zone:
--Question: How can you calculate the running avg/cumulative avg/moving avg of product weight in tons for each zone?

select 
	zone,
	product_wg_ton,
	avg(product_wg_ton) 
	OVER(ORDER BY zone ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as Running_AVG
from fmcg;

--o) Rank Warehouses Based on Total Number of Breakdown Incidents. 
--Question: How can you rank warehouses based on the total number of breakdown incidents in the last 3 months?

select Ware_house_ID, wh_breakdown_l3m, DENSE_RANK() OVER(ORDER BY wh_breakdown_l3m) from fmcg;

--p) Determine the Relation Between Transport Issues and Flood Impact.
--Question: Is there any significant relationship between the number of transport issues and flood impact status of warehouses?

select flood_impacted as flood_impact,sum(transport_issue_l1y) as transport_issue_count from fmcg group by flood_impacted;

--q) Calculate the Running Total of Product Weight in Tons for Each Zone.
--Question: How can you calculate the running total of product weight in tons for each zone?

--r) Rank Warehouses by Product Weight within Each Zone:
--Question: How do you rank warehouses based on the product weight they handle within each zone, allowing ties?

select 
	zone,
	Ware_house_ID,
	product_wg_ton,
	DENSE_RANK() OVER(PARTITION BY ZONE ORDER BY product_wg_ton desc) as Rank
FROM fmcg;

--s) Determine the Most Efficient Warehouses Using DENSE_RANK. 
--Question: How can you use DENSE_RANK to find the most efficient warehouses in terms of breakdown incidents within each zone?

select 
	Ware_house_ID,
	transport_issue_l1y,
	storage_issue_reported_l3m,
	wh_breakdown_l3m,
	dist_from_hub,
	DENSE_RANK() OVER( order by transport_issue_l1y,storage_issue_reported_l3m, wh_breakdown_l3m,dist_from_hub)
from fmcg


-- t) Calculate the Difference in Storage Issues Using LAG.
--Question: How can you use LAG to calculate the difference in storage issues 
--reported between consecutive warehouses within each zone?

select
	Ware_house_ID,
	zone,
	storage_issue_reported_l3m,
	LAG(storage_issue_reported_l3m,1,0) OVER(PARTITION BY zone ORDER BY Ware_house_ID) as previous_storage_issue,
	storage_issue_reported_l3m-LAG(storage_issue_reported_l3m,1) OVER(PARTITION BY zone ORDER BY Ware_house_ID) as Difference_in_lag
from
	fmcg

--Compare Current and Next Warehouse's Distance Using LEAD:
--Question: How can you compare the distance from the 
--hub of the current warehouse to the next one using LEAD?

select
	Ware_house_ID,
	zone,
	dist_from_hub,
	LEAD(dist_from_hub,1,0) OVER(PARTITION BY zone ORDER BY Ware_house_ID) as previous_storage_issue,
	dist_from_hub-LEAD(dist_from_hub,1,0) OVER(PARTITION BY zone ORDER BY Ware_house_ID) as difference_in_lead
from
	fmcg

--u) Calculate Cumulative Total of Product Weight by Zone
--Question: How can you calculate the cumulative total of product weight handled by warehouses within each zone?

--Done already

--v) Categorize Warehouses by Product Weight. 
--Question: How can you categorize warehouses as 'Low', 'Medium', or 'High' based on the amount of product weight they handle?

select
	min(product_wg_ton),
	max(product_wg_ton),
	avg(product_wg_ton)
from
fmcg

select 
	Ware_house_ID,
	product_wg_ton,
	CASE 
		WHEN product_wg_ton<=2065 THEN 'Low'
		WHEN product_wg_ton<55151 THEN 'Medium'
		ELSE 'High'
	END as Weight_category
from
	fmcg
order by product_wg_ton

select
	Ware_house_ID,
	product_wg_ton,
CASE
	WHEN Tile=3 then 'High'
	WHEN Tile=2 then 'Medium'
	ELSE 'Low'
END AS Category 
from
	(select 
		Ware_house_ID, 
		product_wg_ton,
		ntile(3) over(ORDER BY product_wg_ton) as Tile
	 from 
		fmcg) as TileCTE
	ORDER BY Ware_house_ID;


--w) Determine Risk Levels Based on Storage Issues.
--Question: How can you determine the risk level of each warehouse 
--based on the number of storage issues reported in the last 3 months?

--x) Create a Stored Procedure to Fetch High-Risk Warehouses:
--Question: How would you create a stored procedure that 
--returns all warehouses classified as 'High Risk' based on the number of breakdowns and storage issues?


--Creating stored procedure
create procedure HighRiskWarehouse
as
begin
	(select 
		Ware_house_ID,
		transport_issue_l1y,
		storage_issue_reported_l3m,
		wh_breakdown_l3m
	from 
		fmcg
	where 
		transport_issue_l1y>0 and storage_issue_reported_l3m>10 or wh_breakdown_l3m>5);
END;

--Execute stored procedure

exec HighRiskWarehouse;

--y) Create a Stored Procedure to Calculate Warehouse Efficiency:
--Question: How would you create a stored procedure to calculate and 
--return the efficiency of each warehouse based on its product weight and number of distributors?

create procedure Efficiency
as
begin
select *,
CASE
	WHEN effect=2 THEN 'Efficient' 
	ELSE 'Less Efficient'
END as efficiency
from(select
	Ware_house_ID,
	distributor_num,
	product_wg_ton,
	product_wg_ton/distributor_num as effectivenes,
	ntile(2) OVER(ORDER BY product_wg_ton/distributor_num asc) as effect
	from
		fmcg) as effectiveness_rank
END;

--z) Create a View for Warehouse Overview:
--Question: How can you create a view that shows an overview of warehouses, 
--including their location, product weight, and flood-proof status?


create view Overview as
select 
	Ware_house_ID,
	Location_type,
	product_wg_ton,
	flood_proof
from 
	fmcg

--Above sql show how to create a view (Temporary table).
--View is declared using table or tables or a SQL Query. It will not store any records in it.


--aa) Create a View for High-Capacity Warehouses. Question: How would you 
--create a view to display only those warehouses with a product weight greater than 100 tons?

create view 
	High_Capacity_Warehouses 
AS
	select 
		Ware_house_ID,
		product_wg_ton
	from 
		fmcg
	where
		product_wg_ton>100;

 


