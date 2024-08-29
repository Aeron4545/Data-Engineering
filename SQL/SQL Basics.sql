-- T-SQL or Transact SQL which is extension of SQL(Structured Query Language).
--T-SQL developed by Microsoft for use of SQL Server, Azure SQL DB.
-- Key Features of T-SQL: a) Variable , Control Flow Statements (IF)
--LOOPS
--TRY CATCH, CREATE FUNCTIONS, STORED PROCEDURES


-- 1.Show Databases

SELECT name FROM sys.databases;

-- 2.List of schemas
SELECT name as SchemaName from sys.schemas;


-- 3.Create new databases
CREATE DATABASE sales;

-- 4.
--Declare a variable with name Databasename
DECLARE @Databasename VARCHAR(128)= 'sales';

-- 5. Test condition to check if databases exists
IF NOT EXISTS(select 1 FROM sys.databases where name=@Databasename)
BEGIN
     DECLARE @SQL NVARCHAR(MAX)='CREATE DATABASE ' + QUOTENAME(@Databasename)
	 EXEC sp_executesql @SQL;
END


-- 6. Change database
USE sales;

-- 7. Create table using schema name (dbo) 
create table [dbo].products(productid varchar(20) NOT NULL,
productname varchar(50),price float, quantity int, store_name varchar(50),city varchar(50))

USE sales;


-- 8. Insert values into table sales
INSERT INTO products (productid, productname, price, quantity, store_name, city)
VALUES 
('P001', 'Smartphone', 29999.99, 150, 'ElectroMart', 'Mumbai'),
('P002', 'Laptop', 74999.50, 75, 'TechWorld', 'Bangalore'),
('P003', 'Washing Machine', 34999.00, 50, 'HomeAppliance', 'Delhi'),
('P004', 'Refrigerator', 44999.75, 60, 'CoolerKing', 'Chennai'),
('P005', 'Microwave Oven', 5999.00, 120, 'KitchenGoods', 'Hyderabad'),
('P006', 'Smart TV', 59999.99, 30, 'VisionTech', 'Kolkata'),
('P007', 'Headphones', 1999.50, 200, 'SoundWave', 'Pune'),
('P008', 'Smartwatch', 12999.00, 80, 'GadgetHub', 'Jaipur'),
('P009', 'Air Conditioner', 35999.00, 40, 'CoolBreeze', 'Ahmedabad'),
('P010', 'Tablet', 21999.75, 90, 'GizmoStore', 'Surat');

-- 9. Run query on products table to show all records
select * from products;

-- 10.show the schema description of the table
select 
	TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME='products';

--11. To drop a table
---DROP TABLE [dbo].products;


select count(*) from products where quantity > 30;

-- 12. 
alter table products add total_amount float;

alter table products add brand varchar;

--13. Drop column using alter
alter table products  drop column brand


--14. Update column schema/ Update existing column datatype

alter table products alter column price int;

alter table products alter column price float;  --DECIMAL(18,2) can also be used

-- 15. Update the value of column total_amount=price*quantity

update products set total_amount=price*quantity;
where 
select * from products;


--16. Query to show first five records

SELECT TOP (5) [productid]
      ,[productname]
      ,[price]
      ,[quantity]
      ,[store_name]
      ,[city]
      ,[total_amount]
  FROM [Sales].[dbo].[products]
