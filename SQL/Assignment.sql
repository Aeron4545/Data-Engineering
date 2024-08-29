DECLARE @Databasename VARCHAR(128)= 'employeeDB';

IF NOT EXISTS(select 1 FROM sys.databases where name=@Databasename)
BEGIN
     DECLARE @SQL NVARCHAR(MAX)='CREATE DATABASE ' + QUOTENAME(@Databasename)
	 EXEC sp_executesql @SQL;
END

USE employeeDB;

CREATE TABLE EmployeeData (
    Attrition VARCHAR(10),  -- Example: 'Yes'
    Business_Travel VARCHAR(20),  -- Example: 'Travel_Rarely'
    CF_age_band VARCHAR(20),  -- Example: '35 - 44'
    CF_attrition_label VARCHAR(20),  -- Example: 'Ex-Employees'
    Department VARCHAR(50),  -- Example: 'Sales'
    Education_Field VARCHAR(50),  -- Example: 'Life Sciences'
    emp_no VARCHAR(20),  -- Example: 'STAFF-1'
    Employee_Number INT,  -- Example: 1 (use INT or appropriate type for employee number)
    Gender VARCHAR(10),  -- Example: 'Female'
    Job_Role VARCHAR(50),  -- Example: 'Sales Executive'
    Marital_Status VARCHAR(10),  -- Example: 'Single'
    Over_Time VARCHAR(10),  -- Example: 'Yes'
    Over18 VARCHAR(3),  -- Example: 'Y'
    Training_Times_Last_Year INT,  -- Example: 0
    Age INT,  -- Example: 41
    CF_current_Employee VARCHAR(10),  -- Example: '0'
    Daily_Rate INT,  -- Example: 1102
    Distance_From_Home INT,  -- Example: 1
    Education VARCHAR(50),  -- Example: 'Associates Degree'
    Employee_Count INT,  -- Example: 1
    Environment_Satisfaction INT,  -- Example: 2 (scale 1-4)
    Hourly_Rate INT,  -- Example: 94
    Job_Involvement INT,  -- Example: 3 (scale 1-4)
    Job_Level INT,  -- Example: 2
    Job_Satisfaction INT,  -- Example: 4 (scale 1-4)
    Monthly_Income INT,  -- Example: 5993
    Monthly_Rate INT,  -- Example: 19479
    Num_Companies_Worked INT,  -- Example: 8
    Percent_Salary_Hike DECIMAL(5, 2),  -- Example: 11.00 (if this is a percentage, adjust the precision)
    Performance_Rating INT,  -- Example: 3 (scale 1-5)
    Relationship_Satisfaction INT,  -- Example: 1 (scale 1-4)
    Standard_Hours INT,  -- Example: 80
    Stock_Option_Level INT,  -- Example: 0
    Total_Working_Years INT,  -- Example: 8
    Work_Life_Balance INT,  -- Example: 1 (scale 1-4)
    Years_At_Company INT,  -- Example: 6
    Years_In_Current_Role INT,  -- Example: 4
    Years_Since_Last_Promotion INT,  -- Example: 0
    Years_With_Curr_Manager INT  -- Example: 5
);



BULK INSERT emp FROM 'D:/HR_Employee.csv'
WITH
(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2    --skip the header from the records
);


--a) Return the shape of the table

select count(*) from emp as row_count;

select count(*) as Column_Count from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='emp';


--b) Calculate the cumulative sum of total working years for each department

select Department,Employee_Number,
	Total_Working_Years, 
	SUM(Total_Working_Years) 
	OVER(partition by Department order by Total_Working_Years rows between unbounded preceding and current row) as cum_sum
from 
emp

--c) Which gender have higher strength as workforce in each department

select *,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY work_force_count desc) as rank
from (
select Department,Gender,count(*) as work_force_count
from emp 
group by gender,Department) as c

--Insight: the male gender has higher workforce in every department

--d) Create a new column AGE_BAND and Show Distribution of Employee's Age band group
--(Below 25, 25-34, 35-44, 45-55. ABOVE 55).



select AGE_BAND,count(AGE_BAND) as age_band_distribution from
(select Age,
CASE
	WHEN Age<25 THEN 'Below 25'
	WHEN Age<=34 THEN '25-34'
	WHEN Age<=44 THEN '35-44'
	WHEN Age<=55 THEN '45-55'
	WHEN Age>55 THEN 'Above 55'
END AS AGE_BAND
FROM emp) as dist
group by AGE_BAND

--e) Compare all marital status of employee and find the most frequent marital status

select Marital_Status,count(*)
from emp
group by Marital_Status

select TOP(1) Marital_Status,count(*) as Most_Frequent
from emp
group by Marital_Status
ORDER BY count(*) desc

--Insight: Most frequent marrital status is "Married"

--f) Show the Job Role with Highest Attrition Rate (Percentage)
select top(1) Job_Role, (CAST(yes_attrition AS float)/emp_count)*100 as percentage_attrition
from
(select Job_Role,count(*) as emp_count,
	sum(CASE WHEN Attrition='No' THEN 1 ELSE 0 END) as no_attrition,
	sum(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) as yes_attrition
from emp
group by Job_Role) as Attrition_Rate
order by percentage_attrition desc

--g) Show distribution of Employee's Promotion, Find the maximum chances of employee
--getting promoted.

select Years_Since_Last_Promotion,
count(*)  as count_promotion_year,  (CAST(count(*) as float)/(select count(*) from emp where Years_Since_Last_Promotion is not null))*100 as percent_promotion from emp
group by Years_Since_Last_Promotion
order by Years_Since_Last_Promotion


select 
	Job_Role,  
	Performance_Rating, 
	Years_In_Current_Role,
	Years_At_Company, 
	Job_Involvement, 
	Training_Times_Last_Year
from emp
group by 
	Job_Role,
	Performance_Rating, 
	Years_In_Current_Role,
	Years_At_Company, 
	Job_Involvement, 
	Training_Times_Last_Year
order by 
	Performance_Rating desc, 
	Years_In_Current_Role desc,
	Years_At_Company desc, 
	Job_Involvement desc, 
	Training_Times_Last_Year desc

--Insight: Research director has highest chance of promotion
--Higher the performance rating, years in current role, 
--job involvement and trainining time greater will be the chance of promotion


--h) Show the cumulative sum of total working years for each department.

select Department,Employee_Number,
	Total_Working_Years, 
	SUM(Total_Working_Years) 
	OVER(partition by Department order by Total_Working_Years rows between unbounded preceding and current row) as cum_sum
from 
emp


--i) Find the rank of employees within each department based on their monthly income

select 
	Department,
	employee_number,
	Monthly_Income,
	DENSE_RANK() OVER(partition by Department order by Monthly_Income desc)
from emp

--j) Calculate the running total of 'Total Working Years' for each employee within each
--department and age band.

select Department,CF_Age_Band,Employee_Number,
	Total_Working_Years, 
	SUM(Total_Working_Years) 
	OVER(partition by Department,CF_Age_Band order by Total_Working_Years rows between unbounded preceding and current row) as cum_sum
from 
emp


--k) Foreach employee who left, calculate the number of years they worked before leaving and
--compare it with the average years worked by employees in the same department.

select *,
CASE	
	WHEN Years_At_Company>Avg_Emp_Years_At_Company THEN 'More' ELSE 'Less' END AS Comparison
from
(select 
		e.employee_number, e.Department, e.Years_At_Company,
		a.Avg_Emp_Years_At_Company
from emp e
join
	(select		
		Department, avg(Years_At_Company) as avg_Emp_Years_At_Company
		from emp
		group by Department) as a
on a.Department=e.Department
where Attrition='Yes') as d



--l) Rank the departments by the average monthly income of employees who have left.

select Department,avg_monthly_income,RANK() OVER(order by avg_monthly_income desc) as Rank
from
(select 
	Department,
	avg(Monthly_Income) as avg_monthly_income
from emp
where Attrition='Yes'
group by Department) as Rank


--m) Find the if there is any relation between Attrition Rate and Marital Status of Employee.

select Marital_Status,
	SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/count(*) as attrition_yes_percentage,
	SUM(CASE WHEN Attrition='No' THEN 1 ELSE 0 END)*100.0/count(*) as attrition_no_percentage
from emp
group by Marital_Status
order by attrition_yes_percentage desc

--Insight: Attrition yes percentage is highest among singles

--n) Show the Department with Highest Attrition Rate (Percentage)

select top(1) Department,
	SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) *100.0/count(*) as attrition_yes_percentage
from emp
group by Department
order by attrition_yes_percentage desc


--o) Calculate the moving average of monthly income over the past 3 employees for each job
--role.

select 
	employee_number,
	Job_Role, 
	Monthly_income,
	avg(Monthly_Income) Over(partition by Job_Role order by Monthly_Income ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as Moving_avg_income
from emp

--p) Identify employees with outliers in monthly income within each job role. [ Condition :
--Monthly_Income < Q1 - (Q3 - Q1) * 1.5 OR Monthly_Income > Q3 + (Q3 - Q1) ]

select 
	Job_Role,Q1,Q3,IQR, Monthly_Income,Q1-1.5*IQR,Q3+1.5*IQR
from
(select
	Job_Role, Monthly_Income,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Monthly_Income) OVER(PARTITION BY Job_Role) as Q1,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Monthly_Income) OVER(PARTITION BY Job_Role) as Q2,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Monthly_Income) OVER(PARTITION BY Job_Role) as Q3,
	(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Monthly_Income) OVER(PARTITION BY Job_Role))-
	(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Monthly_Income) OVER(PARTITION BY Job_Role)) as IQR
	from emp) as quartiles
	where Monthly_Income<Q1-1.5*IQR or Monthly_Income>Q3+1.5*IQR


--q) Gender distribution within each job role, show each job role with its gender domination.
--[Male_Domination or Female_Domination]

select 
	*,
	CASE WHEN Male_Count>Female_Count THEN 'Male_Domination' ELSE 'Female_Domination' END AS Dominant
from
(select 
	Job_Role,
	SUM(CASE WHEN gender='Male' THEN 1 ELSE 0 END) as Male_Count,
	SUM(CASE WHEN gender='Female' THEN 1 ELSE 0 END) as Female_Count
from emp
group by Job_Role) as domin

--r) Percent rank of employees based on training times last year

select employee_number,Training_Times_Last_Year,
	PERCENT_RANK() OVER(ORDER BY Training_Times_Last_Year) as Emp_Percent_Rank
from emp
order by Training_Times_Last_Year desc

--s) Divide employees into 5 groups based on training times last year [Use NTILE ()]

select employee_number,Training_Times_Last_Year,
	NTILE(5) OVER(ORDER BY Training_Times_Last_Year) as ntile_group
from emp



--t) Categorize employees based on training times last year as - Frequent Trainee, Moderate
--Trainee, Infrequent Trainee.

select 
	*,
	CASE WHEN gp=1 THEN  'Frequent Trainee'
	WHEN gp=2 THEN  'Moderate Trainee'
	WHEN gp=3 THEN  'Infrequent Trainee'
	END AS Frequency_Category
from
(select employee_number,
	Training_Times_Last_Year, 
	NTILE(3) OVER(ORDER BY Training_Times_Last_Year desc) as gp
from emp) as frequency


--u) Categorize employees as 'High', 'Medium', or 'Low' performers based on their performance
--rating, using a CASE WHEN statement.

select 
	employee_number,
	CASE 
		WHEN Performance_Rating>3 THEN 'High'
		WHEN Performance_Rating=3 THEN 'Medium'
		WHEN Performance_Rating<3 THEN 'Low'
	END AS Performance_Category
from emp


--v) Use a CASE WHEN statement to categorize employees into 'Poor', 'Fair', 'Good', or 'Excellent'
--work-life balance based on their work-life balance score.

select 
	employee_number,
	Work_Life_Balance,
	CASE WHEN Work_Life_Balance=1 THEN 'Poor'
	WHEN Work_Life_Balance=2 THEN 'Fair'
	WHEN Work_Life_Balance=3 THEN 'Good'
	WHEN Work_Life_Balance=4 THEN 'Excellent'
	END AS Work_Life_Balance_Category
from emp
--w) Group employees into 3 groups based on their stock option level using the [NTILE] function.

select employee_number,Stock_Option_Level,
	NTILE(3) OVER(ORDER BY Stock_Option_Level) as ntile_group
from emp


--x) Find key reasons for Attrition in Company

select attrition,
	count(Attrition) as attrition_count,
	avg(Monthly_Income) as avg_monthly_income,
	avg(Distance_From_Home) as avg_distance,
	avg(Daily_Rate) as avg_daily_rate,
	avg(Years_At_Company) as avg_yrs_at_company,
	CAST(SUM(CASE WHEN Job_Satisfaction=1 THEN 1 ELSE 0 END) as float)/count(*) *100 as low_job_satisfaction,
	CAST(SUM(CASE WHEN Job_Satisfaction=4 THEN 1 ELSE 0 END) as float)/count(*) *100 as high_job_satisfaction,
	CAST(SUM(CASE WHEN Relationship_Satisfaction=1 THEN 1 ELSE 0 END) as float)/count(*) *100 as low_relationship_satisfaction,
	CAST(SUM(CASE WHEN Relationship_Satisfaction=4 THEN 1 ELSE 0 END) as float)/count(*) *100 as high_relationship_satisfaction,
	CAST(SUM(CASE WHEN Education='Master''s Degree' THEN 1 ELSE 0 END) as float)/count(*) *100 as associate_education,
	CAST(SUM(CASE WHEN Over_Time='yes' THEN 1 ELSE 0 END) as float)/count(*) *100 as overtime_percentage,
	CAST(SUM(CASE WHEN Marital_Status='married' THEN 1 ELSE 0 END) as float)/count(*) *100 as married_percentage,
	CAST(SUM(CASE WHEN Marital_Status='single' THEN 1 ELSE 0 END) as float)/count(*) *100 as single_percentage,
	CAST(SUM(CASE WHEN Performance_Rating=4 THEN 1 ELSE 0 END) as float)/count(*) *100 as high_performance_rating,
	(CAST(SUM(CASE WHEN Work_Life_Balance=1 THEN 1 ELSE 0 END) as float)/count(*) *100) as Low_Work_Life_Balance_High_Percent
from emp
group by Attrition
order by Attrition

--Employees with attrition is higher when the monthly income is low
--Attrition is higher when the distance from home is higher
--Attrition is higher when the Daily Pay Rate is low
--Higher the average years in company lower the attrition
--Attrition is higher when the relationship satisfaction is low
--Attrition is higher when the job satisfaction is low
--Attrition is higher when the employees have to work overtime
--Attrition is lower in case of employees who are married as they might prefer stability
--Attrition is higher in case of singles as they have a tendency to job jump for a better offer
--Attrition is lower when the performance rating is higher=4
--Attrition is higher in the case of low work life balance



