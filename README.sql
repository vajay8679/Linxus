-------------------------------------------------------------------------------------------------
---- select database -----
USE [ENAEX_FIN_PRD]
-------------------------------------------------------------------------------------------------
-- select query -----
SELECT TOP 5 * FROM [FIN].[26_KE24_FINAL];
-------------------------------------------------------------------------------------------------
-- Add a new column ---------
ALTER TABLE [FIN].[26_KE24_FINAL]
ADD [Freight Unitary Cost] DECIMAL(10,2)

ALTER TABLE [FIN].[26_KE24_FINAL]
ADD [Group2]  VARCHAR(50) NULL;
-------------------------------------------------------------------------------------------------
ALTER TABLE [FIN].[25_KE24]
ADD [PC Description] VARCHAR(50) NULL; -- Add a new column with the desired name and data type

UPDATE [FIN].[25_KE24]
SET [PC Description] = PC_Description; -- Copy data from the old column to the new column
-------------------------------------------------------------------------------------------------
---- Drop column -------
ALTER TABLE [FIN].[25_KE24]
DROP COLUMN PC_Description; 

ALTER TABLE [FIN].[26_KE24_FINAL]
DROP COLUMN [Freight Unitary Cost];
-------------------------------------------------------------------------------------------------
----count-----
select count(*)   FROM [FIN].[49_DOTACTION STAGING]
-------------------------------------------------------------------------------------------------
----delete complete data-----
DELETE FROM [FIN].[49_DOTACTION STAGING];
-------------------------------------------------------------------------------------------------
-- Create a new table based on the structure and data of an existing table into new table ----
---- copy data from one table to another table ----------
SELECT *
INTO [FIN].[49_DOTACTION STAGING]
FROM dbo.[49_DOTACTION_STAGING1];
-------------------------------------------------------------------------------------------------
---- like -----
select * from [FIN].[49_DOTACTION STAGING] WHERE [Employee Nr] LIKE '%Printed%'
-------------------------------------------------------------------------------------------------
---- delete based on where condition -------
DELETE FROM [FIN].[49_DOTACTION STAGING] WHERE [Employee Nr] LIKE '%Printed%'
-------------------------------------------------------------------------------------------------
-------- change data type of column --------------
ALTER TABLE [FIN].[49_DOTACTION STAGING]
ALTER COLUMN  [Employee Nr] INT NULL

ALTER TABLE [FIN].[49_DOTACTION STAGING]
ALTER COLUMN Separation  VARCHAR(50) NULL

ALTER TABLE [FIN].[51_DOTACTION_FINAL]
ALTER COLUMN [ID number]  float NULL
-------------------------------------------------------------------------------------------------
--------- renaming column -----------
EXEC sp_rename '[FIN].[25_KE24].[Employment Status]', 'Employment status', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[load1]', 'load', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R4A]', 'Responsible 4A', 'COLUMN';
-------------------------------------------------------------------------------------------------


-- #####################################################################################################


-------- how to create stored Procedure ---------------


-- Create Stored Procedure Template for Azure SQL Database
-- =======================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
ALTER PROCEDURE FIN.SP_ProcessNewDOTACTION_v1
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
   
END
GO


------------------after running above SP run below command to see your data in SP

EXEC [FIN].[SP_ProcessNewDOTACTION_v1]

-- #####################################################################################################



https://www.sqlservertutorial.net/getting-started/sql-server-sample-database/

----  returns the version of the SQL Server
select @@version;


----create tables

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);


CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) 
        REFERENCES sales.stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) 
        REFERENCES sales.staffs (staff_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



----- order by

ORDER BY column_list [ASC |DESC]
OFFSET offset_row_count {ROW | ROWS}
FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY


The OFFSET clause specifies the number of rows to skip before starting to return rows from the query. The offset_row_count can be a constant, variable, or parameter that is greater or equal to zero.

The FETCH clause specifies the number of rows to return after the OFFSET clause has been processed. The offset_row_count can be a constant, variable, or scalar that is greater or equal to one.

The OFFSET clause is mandatory while the FETCH clause is optional. Also, the FIRST and NEXT are synonyms, so you can use them interchangeably. Similarly, you can use the FIRST and NEXT interchangeably.

--skip first 10 rows

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS;


--To skip the first 10 products and select the next 10 products, you use both OFFSET and FETCH clauses as follows:
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;


---- SELECT TOP with a constant value
SELECT TOP 10
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;


---- one percent of 321 is a fraction value ( 3.21), SQL Server rounds it up to the next whole number which is four ( 4)
SELECT TOP 1 PERCENT
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;


---- SELECT TOP WITH TIES to include rows that match the values in the last row
-- third expensive product has a list price of 6499.99. Because the statement uses TOP WITH TIES, it returns three more products whose list prices are the same as the third one.

SELECT TOP 3 WITH TIES
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;


----distinct cities and states of customers, you can use the SELECT DISTINCT with the city and state columns:
SELECT 
  DISTINCT city, state 
FROM 
  sales.customers



--DISTINCT vs. GROUP BY

--DISTINCT and GROUP BY clause reduces the number of returned rows in the result set by removing the duplicates.
--However, you should use the GROUP BY clause when you want to apply an aggregate function to one or more columns.

--group by
SELECT 
  city, 
  state, 
  zip_code 
FROM 
  sales.customers 
GROUP BY 
  city, 
  state, 
  zip_code 
ORDER BY 
  city, 
  state, 
  zip_code


--distinct
SELECT 
  DISTINCT city, state, zip_code 
FROM 
  sales.customers;



---- NULL in where clause

SELECT
    customer_id,
    first_name,
    last_name,
    phone
FROM
    sales.customers
WHERE
    phone = NULL
ORDER BY
    first_name,
    last_name;

--WHERE clause returns rows that cause its predicate to evaluate to TRUE. However, the following expression evaluates to UNKNOWN.
phone = NULL;
--Therefore, you get an empty result set.
--To test whether a value is NULL or not, you always use the IS NULL operator.

--correct query
SELECT
    customer_id,
    first_name,
    last_name,
    phone
FROM
    sales.customers
WHERE
    phone IS NULL
ORDER BY
    first_name,
    last_name;



-- 'and' return first then after it 'or'
--SQL Server evaluates the AND operator first. Therefore, the query retrieves the products with the brand id 2 and list price greater than 1,000 or brand id 1.

SELECT
    *
FROM
    production.products
WHERE
    brand_id = 1
OR brand_id = 2
AND list_price > 1000
ORDER BY
    brand_id DESC;



--You can replace multiple OR operators by the IN operator

WHERE
    brand_id = 1
OR brand_id = 2
OR brand_id = 4


-- better one
WHERE brand_id IN (1, 2, 3)


-- Like
--last_name start with z
last_name LIKE 'z%'

--last_name ends with er
last_name LIKE '%er'

-- starts with the letter t and ends with the letter s
last_name LIKE 't%s'

----represents a single character that must be one of the characters specified in the list.
last_name LIKE '[YZ]%'


-- range from A to C -any of the character from -(A,B,C)
last_name LIKE '[A-C]%'

-- not in range of A to X
last_name LIKE '[^A-X]%'


--The query returns comments that contain 30% and 30 USD, which is not what we expected.
comment LIKE '%30%';

--In this query, the  ESCAPE clause specified that the character ! is the escape character. it will give '30%'
comment LIKE '%30!%%' ESCAPE '!';


--alias

SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    'Product Category';



---- create schema

CREATE SCHEMA hr;
GO


----Group by

SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;


-- having (dont use alias in it)
SELECT
    column_name1,
    column_name2,
    aggregate_function (column_name3) alias
FROM
    table_name
GROUP BY
    column_name1,
    column_name2
HAVING
    aggregate_function (column_name3) > value;


---The EXISTS operator returns TRUE if the subquery return results; otherwise, it returns FALSE.

SELECT
    customer_id,
    first_name,
    last_name,
    city
FROM
    sales.customers c
WHERE
    EXISTS (
        SELECT
            customer_id
        FROM
            sales.orders o
        WHERE
            o.customer_id = c.customer_id
        AND YEAR (order_date) = 2017
    )
ORDER BY
    first_name,
    last_name;



--EXISTS vs. JOIN

--The EXISTS operator returns TRUE or FALSE while the JOIN clause returns rows from another table.
--You use the EXISTS operator to test if a subquery returns any row and short circuits as soon as it does. On the other hand, you use JOIN to extend the result set by combining it with the columns from related tables.

--you use the EXISTS when you need to check the existence of rows from related tables without returning data from them.


-- ANY

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id = ANY (
        SELECT
            product_id
        FROM
            sales.order_items
        WHERE
            quantity >= 2
    )
ORDER BY
    product_name;


--ALL

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > ALL (
        SELECT
            AVG (list_price) avg_list_price
        FROM
            production.products
        GROUP BY
            brand_id
    )
ORDER BY
    list_price;


--UNION operator removes all duplicate rows from the result sets. However, if you want to retain the duplicate rows, you need to specify the ALL keyword is explicitly as shown below:

query_1
UNION
query_2
---------
query_1
UNION ALL
query_2


--EXCEPT

query_1
EXCEPT
query_2


T1
EXCEPT
T2

T1 result set includes 1, 2, and 3.
T2 result set includes 2, 3, and 4.
The except of the T1 and T2 returns 1 which is the distinct row from the T1 result set that does not appear in the T2 result set



--INTERSECT

query_1
INTERSECT
query_2

In this illustration, we had two result sets T1 and T2:

T1 result set includes 1, 2, and 3.
T2 result set includes 2, 3, and 4.
The intersection of T1 and T2 result sets returns the distinct rows which are 2 and 3.


--CUBE is a subclause of the GROUP BY clause that allows you to generate multiple grouping sets. The following illustrates the general syntax of the CUBE

SELECT
    d1,
    d2,
    d3,
    aggregate_function (c4)
FROM
    table_name
GROUP BY
    CUBE (d1, d2, d3);  


--1) Insert all rows from another table example
INSERT INTO sales.addresses (street, city, state, zip_code) 
SELECT
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name; 

--3) Insert the top N of rows
TRUNCATE TABLE sales.addresses;


INSERT TOP (10) 
INTO sales.addresses (street, city, state, zip_code) 
SELECT
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;


--Delete
DELETE TOP (21) FROM production.product_history;
DELETE FROM  production.product_history;
DELETE FROM production.product_history WHERE model_year = 2017;
DELETE TOP (5) PERCENT FROM production.product_history;


--SQL Server MERGE statement example
CREATE TABLE sales.category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);

INSERT INTO sales.category(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (2,'Comfort Bicycles',25000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',10000);


CREATE TABLE sales.category_staging (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);


INSERT INTO sales.category_staging(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',20000),
    (5,'Electric Bikes',10000),
    (6,'Mountain Bikes',10000);


--To update data to the sales.category (target table) with the values from the sales.category_staging (source table), you use the following MERGE statement:
MERGE sales.category t 
    USING sales.category_staging s
ON (s.category_id = t.category_id)
WHEN MATCHED
    THEN UPDATE SET 
        t.category_name = s.category_name,
        t.amount = s.amount
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (category_id, category_name, amount)
         VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;


--SQL Server Transaction

--To start a transaction explicitly, you use the BEGIN TRANSACTION or BEGIN TRAN statement first:
BEGIN TRANSACTION;

--Then, execute one or more statements including INSERT, UPDATE, and DELETE.
--Finally, commit the transaction using the COMMIT statement:
COMMIT;

--Or roll back the transaction using the ROLLBACK statement:
ROLLBACK;

--Here’s the sequence of statements for starting a transaction explicitly and committing it:
-- start a transaction
BEGIN TRANSACTION;

-- other statements

-- commit the transaction
COMMIT;



-----------CTE
--A) Simple SQL Server CTE example
WITH cte_sales_amounts (staff, sales, year) AS (
    SELECT    
        first_name + ' ' + last_name, 
        SUM(quantity * list_price * (1 - discount)),
        YEAR(order_date)
    FROM    
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY 
        first_name + ' ' + last_name,
        year(order_date)
)

SELECT
    staff, 
    sales
FROM 
    cte_sales_amounts
WHERE
    year = 2018;


--B) Using a common table expression to make report averages based on counts
WITH cte_sales AS (
    SELECT 
        staff_id, 
        COUNT(*) order_count  
    FROM
        sales.orders
    WHERE 
        YEAR(order_date) = 2018
    GROUP BY
        staff_id

)
SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;



--C) Using multiple SQL Server CTE in a single query example
WITH cte_category_counts (
    category_id, 
    category_name, 
    product_count
)
AS (
    SELECT 
        c.category_id, 
        c.category_name, 
        COUNT(p.product_id)
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
    GROUP BY 
        c.category_id, 
        c.category_name
),
cte_category_sales(category_id, sales) AS (
    SELECT    
        p.category_id, 
        SUM(i.quantity * i.list_price * (1 - i.discount))
    FROM    
        sales.order_items i
        INNER JOIN production.products p 
            ON p.product_id = i.product_id
        INNER JOIN sales.orders o 
            ON o.order_id = i.order_id
    WHERE order_status = 4 -- completed
    GROUP BY 
        p.category_id
) 

SELECT 
    c.category_id, 
    c.category_name, 
    c.product_count, 
    s.sales
FROM
    cte_category_counts c
    INNER JOIN cte_category_sales s 
        ON s.category_id = c.category_id
ORDER BY 
    c.category_name;




---------------------------------------------

--Creating a new database
CREATE DATABASE database_name;

--SQL Server DROP DATABASE
DROP DATABASE IF EXISTS TestDb;


--schema in SQL Server
CREATE SCHEMA customer_services;
GO

--A schema is a collection of database objects including tables, views, triggers, stored procedures, indexes, etc. A schema is associated with a username which is known as the schema owner, who is the owner of the logically related database objects.

--A schema always belongs to one database. On the other hand, a database may have one or multiple schemas. For example, in our BikeStores sample database, we have two schemas: sales and production. An object within a schema is qualified using the schema_name.object_name format like sales.orders. Two tables in two schemas can share the same name so you may have hr.employees and sales.employees.


-- to alter schema 
https://www.sqlservertutorial.net/sql-server-basics/sql-server-alter-schema/


--First, create a new table named offices in the dbo schema:

CREATE TABLE dbo.offices
(
    office_id      INT
    PRIMARY KEY IDENTITY, 
    office_name    NVARCHAR(40) NOT NULL, 
    office_address NVARCHAR(255) NOT NULL, 
    phone          VARCHAR(20),
);


--Next, insert some rows into the dob.offices table:

INSERT INTO 
    dbo.offices(office_name, office_address)
VALUES
    ('Silicon Valley','400 North 1st Street, San Jose, CA 95130'),
    ('Sacramento','1070 River Dr., Sacramento, CA 95820');

--Then, create a stored procedure that finds office by office id:

CREATE PROC usp_get_office_by_id(
    @id INT
) AS
BEGIN
    SELECT 
        * 
    FROM 
        dbo.offices
    WHERE 
        office_id = @id;
END;

--After that, transfer this dbo.offices table to the sales schema:

ALTER SCHEMA sales TRANSFER OBJECT::dbo.offices;  

--If you execute the usp_get_office_by_id stored procedure, SQL Server will issue an error:

Msg 208, Level 16, State 1, Procedure usp_get_office_by_id, Line 5 [Batch Start Line 30]
Invalid object name 'dbo.offices'.

--Finally, manually modify the stored procedure to reflect the new schema:

ALTER PROC usp_get_office_by_id(
    @id INT
) AS
BEGIN
    SELECT 
        * 
    FROM 
        sales.offices
    WHERE 
        office_id = @id;
END;



---SQL Server DROP SCHEMA

--First, create a new schema named logistics:

CREATE SCHEMA logistics;
GO

--Next, create a new table named deliveries inside the logistics schema:

CREATE TABLE logistics.deliveries
(
    order_id        INT
    PRIMARY KEY, 
    delivery_date   DATE NOT NULL, 
    delivery_status TINYINT NOT NULL
);

--Then, drop the schema logistics:

DROP SCHEMA logistics;

--SQL Server issued the following error because the schema is not empty.

Msg 3729, Level 16, State 1, Line 1
Cannot drop schema 'logistics' because it is being referenced by object 'deliveries'.

--After that, drop the table logistics.deliveries:

DROP TABLE logistics.deliveries;

--Finally, issue the DROP SCHEMA again to drop the logistics schema:

DROP SCHEMA IF EXISTS logistics;


---SQL Server CREATE TABLE

CREATE TABLE sales.visits (
    visit_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    visited_at DATETIME,
    phone VARCHAR(20),
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);



--identity column
IDENTITY[(seed,increment)]
IDENTITY(1,1) --start from one and incremented by 1


CREATE SCHEMA hr;

CREATE TABLE hr.person (
    person_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL
);

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('John','Doe', 'M');

o/p- person_id - 1


-- DROP TABLE
DROP TABLE [database_name.][schema_name.]table_name_1,
DROP TABLE IF EXISTS sales.revenues;
DROP TABLE procurement.suppliers, procurement.supplier_groups;


--TRUNCATE TABLE

DELETE FROM sales.customer_groups;

TRUNCATE TABLE [database_name.][schema_name.]table_name;
TRUNCATE TABLE sales.customer_groups;


1) Use less transaction log
The DELETE statement removes rows one at a time and inserts an entry in the transaction log for each removed row. On the other hand, the TRUNCATE TABLE statement deletes the data by deallocating the data pages used to store the table data and inserts only the page deallocations in the transaction logs.

2) Use fewer locks
When the DELETE statement is executed using a row lock, each row in the table is locked for removal. The TRUNCATE TABLE locks the table and pages, not each row.

3) Identity reset
If the table to be truncated has an identity column, the counter for that column is reset to the seed value when data is deleted by the TRUNCATE TABLE statement but not the DELETE statement.


--Rename table name
EXEC sp_rename 'old_table_name', 'new_table_name'
EXEC sp_rename 'sales.contr', 'contracts';


--ALTER TABLE ADD Column
ALTER TABLE sales.quotations 
ADD description VARCHAR (255) NOT NULL;
--
ALTER TABLE sales.quotations 
    ADD 
        amount DECIMAL (10, 2) NOT NULL,
        customer_name VARCHAR (50) NOT NULL;


--ALTER TABLE ALTER COLUMN

ALTER TABLE table_name 
ALTER COLUMN column_name new_data_type(size);

--
ALTER TABLE t3 ALTER COLUMN c VARCHAR (20) NOT NULL;


--ALTER TABLE DROP COLUMN
ALTER TABLE table_name
DROP COLUMN column_name;

ALTER TABLE sales.price_lists
DROP COLUMN discount, surcharge;


--Computed Columns
ALTER TABLE persons
ADD full_name AS (first_name + ' ' + last_name);


--Persisted computed columns
--Computed columns can be persisted. It means that SQL Server physically stores the data of the computed columns on disk.

ALTER TABLE persons
ADD full_name AS (first_name + ' ' + last_name) PERSISTED;





--SQL Server Temporary Tables
--The name of the temporary table starts with a hash symbol (#)

SELECT
    product_name,
    list_price
INTO #trek_products --- temporary table
FROM
    production.products
WHERE
    brand_id = 9;



--Create temporary tables using CREATE TABLE statement
CREATE TABLE #haro_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

--After creating the temporary table, you can insert data into this table as a regular table:
INSERT INTO #haro_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 2;



--select
SELECT
    *
FROM
    #haro_products;


--However, if you open another connection and try the query above query, you will get the following error:
Invalid object name '#haro_products'.
--This is because the temporary tables are only accessible within the session that created them.


---Global temporary tables (uses - ##)
--Sometimes, you may want to create a temporary table that is accessible across connections. In this case, you can use global temporary tables.


CREATE TABLE ##heller_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

INSERT INTO ##heller_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 3;

--drop table
DROP TABLE ##table_name;


--synonym in SQL Server
--In SQL Server, a synonym is an alias or alternative name for a database object such as a table, view, stored procedure, user-defined function, and sequence. A synonym provides you with many benefits if you use it properly.

CREATE SYNONYM orders FOR sales.orders;

--the following query uses the orders synonym instead of sales.orders table:
SELECT * FROM orders;


--
CREATE SYNONYM suppliers 
FOR testdb.purchasingSchema.suppliersTbl;

SELECT * FROM suppliers;

--removing synonyms
DROP SYNONYM IF EXISTS orders;


--SQL Server SELECT INTO
--create the marketing.customers table like the sales.customers table and copy all rows from the sales.customers table to the marketing.customers table:

SELECT 
    *
INTO 
    marketing.customers
FROM 
    sales.customers;


--SQL Server Data Types

INT,BIGINT,TINYINT,SMALLINT
DECIMAL(10,2) --total 10 digit and 2 digit after decimal
NUMERIC(10,2)

CHAR

--To store fixed-length, Unicode character string data in the database, you use the SQL Server NCHAR data type:

VARCHAR  -- by default 1
VARCHAR(n) -- defined n character
VARCHAR(max) --In this syntax, max defines the maximum storage size which is 231-1 bytes (2 GB).

DATETIME2  - '2018-06-23 07:30:20'
DATE - YYYY-MM-DD
TIME  - hh:mm:ss[.nnnnnnn]
DATETIMEOFFSET  - YYYY-MM-DDThh:mm:ss[.nnnnnnn][{+|-}hh:mm]
 --https://www.sqlservertutorial.net/sql-server-basics/sql-server-datetimeoffset/


--A globally unique identifier or GUID is a broader version of this type of ID numbers.

SELECT 
    NEWID() AS GUID;


GUID
------------------------------------
3297F0F2-35D3-4231-919D-1CFCF4035975


--The following statements declare a variable with type UNIQUEIDENTIFIER and assign it a GUID value generated by the NEWID() function.

DECLARE 
    @id UNIQUEIDENTIFIER;

SET @id = NEWID();

SELECT 
    @id AS GUID;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

GUID
------------------------------------
69AA3BA5-D51E-465E-8447-ECAA1939739A


----
CREATE SCHEMA marketing;
GO

CREATE TABLE marketing.customers(
    customer_id UNIQUEIDENTIFIER DEFAULT NEWID(),
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL
);
GO


--GUID values are globally unique across tables, databases, and even servers. Therefore, it allows you to merge data from different servers with ease.


--SQL Server JSON


--to check valid json
ISJSON(json_string)

SELECT ISJSON('{"name": "Joe"}') is_valid_json;

o/p-
is_valid_json
-------------
1


--storing json
CREATE TABLE employees(
   id INT IDENTITY PRIMARY KEY,
   info NVARCHAR(MAX) NOT NULL
);

INSERT INTO employees (info)
VALUES 
    ('{"name": "John", "age": 35, "dateOfBirth": "1989-05-15", "skills": ["JavaScript", "SQL", "Python"], "address": {"street": "123 Main St", "city": "New York", "state": "NY", "country": "USA"}}'),
    ('{"name": "Alice", "age": 28, "dateOfBirth": "1996-10-22", "skills": ["Java", "C#", "HTML/CSS"], "address": {"street": "456 Elm St", "city": "Los Angeles", "state": "CA", "country": "USA"}}');

--Extracting JSON data from SQL Server
JSON_VALUE(json_string, json_path)
--json_string is JSON data.
--json_path is a JSON path that specifies the value from the JSON string to extract


--For example, the following statement extracts the name, age, and dateOfBirth from the JSON data stored in the info column of the employees table:
SELECT 
    JSON_VALUE(info, '$.name') AS Name,
    JSON_VALUE(info, '$.age') AS Age,
    JSON_VALUE(info, '$.dateOfBirth') AS DateOfBirth
FROM 
    employees;

Output:

Name  | Age | DateOfBirth
--------------------------
John  | 35  | 1989-05-15
Alice | 28  | 1996-10-22

--To extract a JSON object or array from a JSON document, you can use the JSON_QUERY() function:

JSON_QUERY(json_string, json_path);

--For example, the following statement uses the JSON_QUERY() function to extract the skills from the info column of the employees table:

SELECT 
  JSON_QUERY(info, '$.skills') skills 
FROM 
  employees;
Code language: SQL (Structured Query Language) (sql)
Output:
skills
-------------------------------
["JavaScript", "SQL", "Python"]
["Java", "C#", "HTML/CSS"]



--drop constraint
ALTER TABLE hr.persons
DROP CONSTRAINT unique_phone;


--This example uses the COALESCE expression to evaluate a list of arguments and to return the first number or varchar value but not null:

SELECT 
    COALESCE(NULL, NULL, 100, 200) result;



--This example returns NULL because the first argument equals the second one:

SELECT 
    NULLIF(10, 10) result;

--Here is the output:

result
------
NULL

--However, the following example returns the first argument because two arguments are not equal:

SELECT 
    NULLIF(20, 10) result;

--The output is as follows:

result
------
20


--duplicate values
 --the query for finding the duplicate values in one column using the GROUP BY clause is as follows:

SELECT 
    col, 
    COUNT(col)
FROM 
    table_name
GROUP BY 
    col
HAVING 
    COUNT(col) > 1;


---Find duplicate from table
SELECT 
    a, 
    b, 
    COUNT(*) occurrences
FROM t1
GROUP BY
    a, 
    b
HAVING 
    COUNT(*) > 1;


---Delete duplicate rows from a table example
WITH cte AS (
    SELECT 
        contact_id, 
        first_name, 
        last_name, 
        email, 
        ROW_NUMBER() OVER (
            PARTITION BY 
                first_name, 
                last_name, 
                email
            ORDER BY 
                first_name, 
                last_name, 
                email
        ) row_num
     FROM 
        sales.contacts
)
DELETE FROM cte
WHERE row_num > 1;



--SQL Server Views

SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;

--SQL Server provides a better way to save this query in the database catalog through a view.
--So the query above can be stored as a view using the CREATE VIEW statement as follows:

CREATE VIEW sales.product_info
AS
SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;


SELECT * FROM sales.product_info;

--Advantages of views
Security,Simplicity,Consistency


--Creating a view using aggregate functions example
CREATE VIEW sales.staff_sales (
        first_name, 
        last_name,
        year, 
        amount
)
AS 
    SELECT 
        first_name,
        last_name,
        YEAR(order_date),
        SUM(list_price * quantity) amount
    FROM
        sales.order_items i
    INNER JOIN sales.orders o
        ON i.order_id = o.order_id
    INNER JOIN sales.staffs s
        ON s.staff_id = o.staff_id
    GROUP BY 
        first_name, 
        last_name, 
        YEAR(order_date);


--Redefining the view example
--To add the customer name column to the sales.daily_sales view, you use the CREATE VIEW OR ALTER as follows:

CREATE OR ALTER sales.daily_sales (
    year,
    month,
    day,
    customer_name,
    product_id,
    product_name
    sales
)
AS
SELECT
    year(order_date),
    month(order_date),
    day(order_date),
    concat(
        first_name,
        ' ',
        last_name
    ),
    p.product_id,
    product_name,
    quantity * i.list_price
FROM
    sales.orders AS o
    INNER JOIN
        sales.order_items AS i
    ON o.order_id = i.order_id
    INNER JOIN
        production.products AS p
    ON p.product_id = i.product_id
    INNER JOIN sales.customers AS c
    ON c.customer_id = o.customer_id;



--Create an index on the view.
CREATE UNIQUE CLUSTERED INDEX IDX_V1
   ON Sales.vOrders (OrderDate, ProductID);

   
--SQL Server DROP VIEW
DROP VIEW IF EXISTS sales.daily_sales;

--multiple view
DROP VIEW IF EXISTS 
    sales.staff_sales, 
    sales.product_catalogs;


--SQL Server rename view using Transact-SQL
EXEC sp_rename 
    @objname = 'sales.product_catalog',
    @newname = 'product_list';



--To list all views in a SQL Server Database, you query the sys.views or sys.objects catalog view. Here is an example:
SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name
FROM 
	sys.views as v;


-- if you want to know the views that contain the word sales, you can call the stored procedure usp_list_views:
EXEC usp_list_views @view_name = 'sales'


--Getting the view information using the sql.sql_module catalog
--To get the information of a view, you use the system catalog sys.sql_module and the OBJECT_ID() function:

SELECT
    definition,
    uses_ansi_nulls,
    uses_quoted_identifier,
    is_schema_bound
FROM
    sys.sql_modules
WHERE
    object_id
    = object_id(
            'sales.daily_sales'
        );

--Getting view information using the sp_helptext stored procedure
EXEC sp_helptext 'sales.product_catalog' ;


--SQL Server Indexed View

--Creating an SQL Server indexed view example
CREATE NONCLUSTERED INDEX 
    ucidx_product_name
ON production.product_master(product_name);


--SQL Server Clustered Indexes
CREATE CLUSTERED INDEX ix_parts_id
ON production.parts (part_id);  
--If you open the Indexes node under the table name, you will see the new index name ix_parts_id with type Clustered.

--SQL Server CREATE INDEX
CREATE [NONCLUSTERED] INDEX index_name
ON table_name(column_list);

--The sales.customers table is a clustered table because it has a primary key customer_id.

--Now, if you display the estimated execution plan of the above query again, you will find that the query optimizer uses the nonclustered index ix_customers_city:
--after creating index -it work with 'seek' not scan so its(seek- faster, scan - slow) scan have to scan whole data
CREATE INDEX ix_customers_city
ON sales.customers(city);


--SQL Server Rename Index
EXEC sp_rename 
    index_name, 
    new_index_name, 
    N'INDEX';  


--
EXEC sp_rename 
    @objname = N'index_name', 
    @newname = N'new_index_name',   
    @objtype = N'INDEX';


EXEC sp_rename 
        @objname = N'sales.customers.ix_customers_city',
        @newname = N'ix_cust_city' ,
        @objtype = N'INDEX';

EXEC sp_rename 
        N'sales.customers.ix_customers_city',
        N'ix_cust_city' ,
        N'INDEX';



--SQL Server Unique Index
CREATE UNIQUE INDEX index_name
ON table_name(column_list);

CREATE UNIQUE INDEX ix_cust_email 
ON sales.customers(email);


--SQL Server Disable Indexes
ALTER INDEX index_name
ON table_name
DISABLE;



--To disable all indexes of a table, you use the following form of the ALTER INDEX statement:
ALTER INDEX ALL ON table_name
DISABLE;


--
ALTER INDEX ix_cust_city 
ON sales.customers 
DISABLE;


--Enable index using ALTER INDEX and CREATE INDEX statements
ALTER INDEX index_name 
ON table_name  
REBUILD;

--This statement uses the DBCC DBREINDEX to enable an index on a table:
DBCC DBREINDEX (table_name, index_name);

--This statement uses the DBCC DBREINDEX to enable all indexes on a table:
DBCC DBREINDEX (table_name, " ");  


--drop index
DROP INDEX IF EXISTS ix_cust_email
ON sales.customers;

--drop multiple index
DROP INDEX 
    ix_cust_city ON sales.customers,
    ix_cust_fullname ON sales.customers;



--SQL Server Indexes with Included Columns

--create a new index ix_cust_email_inc that includes two columns first name and last name:

CREATE UNIQUE INDEX ix_cust_email_inc
ON sales.customers(email)
INCLUDE(first_name,last_name);

--Now, the query optimizer will solely use the non-clustered index to return the requested data of the query
--An index with included columns can greatly improve query performance because all columns in the query are included in the index; The query optimizer can locate all columns values within the index without accessing table or clustered index resulting in fewer disk I/O operations.

--Benefits of filtered indexes
--As mentioned earlier, filtered indexes can help you save spaces especially when the index key columns are sparse. Sparse columns are the ones that have many NULL values.

CREATE INDEX ix_cust_phone
ON sales.customers(phone)
INCLUDE (first_name, last_name)
WHERE phone IS NOT NULL;


--SQL Server Stored Procedures

--SQL Server stored procedures are used to group one or more Transact-SQL statements into logical units. The stored procedure is stored as a named object in the SQL Server Database Server.
--When you call a stored procedure for the first time, SQL Server creates an execution plan and stores it in the cache. In the subsequent executions of the stored procedure, SQL Server reuses the plan to execute the stored procedure very fast with reliable performance.

--Section 2. Control-of-flow statements
BEGIN…END – create a statement block that consists of multiple Transact-SQL statements that execute together.
IF ELSE – execute a statement block based on a condition.
WHILE – repeatedly execute a set of statements based on a condition as long as the condition is true.
BREAK – exit the loop immediately and skip the rest of the code after it within a loop.
CONTINUE – skip the current iteration of the loop immediately and continue the next one.



--A Basic Guide to SQL Server Stored Procedures


--select statement
SELECT 
	product_name, 
	list_price
FROM 
	production.products
ORDER BY 
	product_name;


--To create a stored procedure that wraps this query, you use the CREATE PROCEDURE statement as follows:
--Note that in addition to the CREATE PROCEDURE keywords, you can use the CREATE PROC keywords to make the statement shorter.


CREATE PROCEDURE uspProductList
AS
BEGIN
    SELECT 
        product_name, 
        list_price
    FROM 
        production.products
    ORDER BY 
        product_name;
END;


--Executing a stored procedure
EXECUTE sp_name;

EXEC sp_name;

EXEC uspProductList;


--Modifying a stored procedure
ALTER PROCEDURE uspProductList
    AS
    BEGIN
        SELECT 
            product_name, 
            list_price
        FROM 
            production.products
        ORDER BY 
            list_price 
    END;


--Executing a stored procedure
EXEC uspProductList;


--Deleting a stored procedure
DROP PROCEDURE sp_name;
DROP PROC sp_name;
DROP PROCEDURE uspProductList;


--SQL Server Stored Procedure Parameters
--Creating a stored procedure with one parameter

ALTER PROCEDURE uspFindProducts(@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price
    ORDER BY
        list_price;
END;

--To execute the uspFindProducts stored procedure, you pass an argument to it as follows:
EXEC uspFindProducts 100;
EXEC uspFindProducts 200;


EXECUTE [FIN].[SP_ProcessNewFAGLL03Upload] 
    @pFAGLL03UploadID = 5, 
    @pUploadFunction = 'SAP';


    @pFAGLL03UploadID INT,
@pUploadFunction NVARCHAR(50) 

--Creating a stored procedure with multiple parameters
ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price
    ORDER BY
        list_price;
END;



--Once the stored procedure is modified successfully, you can execute it by passing two arguments, one for @min_list_price and the other for @max_list_price:
EXECUTE uspFindProducts 900, 1000;


--better one
EXECUTE uspFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000;



--Creating text parameters
ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;



--
EXECUTE uspFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000,
    @name = 'Trek';


--Creating optional parameters
--SQL Server allows you to specify default values for parameters so that when you call stored procedures, you can skip the parameters with default values.

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = 999999
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;



-- we assigned 0 as the default value for the @min_list_price parameter and 999,999 as the default value for the @max_list_price parameter.
EXECUTE uspFindProducts 
    @name = 'Trek';

--you can pass like this
EXECUTE uspFindProducts 
    @min_list_price = 6000,
    @name = 'Trek';


--Using NULL as the default value
--In the uspFindProducts stored procedure, we used 999,999 as the default maximum list price. This is not robust because in the future you may have products with the list prices that are greater than that.
--A typical technique to avoid this is to use NULL as the default value for the parameters:

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = NULL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        (@max_list_price IS NULL OR list_price <= @max_list_price) AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

--In the WHERE clause, we changed the condition to handle NULL value for the @max_list_price parameter:

--The following statement executes the uspFindProducts stored procedure to find the product whose list prices are greater or equal to 500 and names contain the word Haro.

EXECUTE uspFindProducts 
    @min_list_price = 500,
    @name = 'Haro';



--Declaring a variable
--A variable is an object that holds a single value of a specific type e.g., integer, date, or varying character string.

DECLARE @model_year SMALLINT;
DECLARE @model_year AS SMALLINT;

DECLARE @model_year SMALLINT, 
        @product_name VARCHAR(MAX);

--Assigning a value to a variable
SET @model_year = 2018;


SELECT
    product_name,
    model_year,
    list_price 
FROM 
    production.products
WHERE 
    model_year = @model_year
ORDER BY
    product_name;


--Now, you can put everything together and execute the following code block to get a list of products whose model year is 2018:

DECLARE @model_year SMALLINT;

SET @model_year = 2018;

SELECT
    product_name,
    model_year,
    list_price 
FROM 
    production.products
WHERE 
    model_year = @model_year
ORDER BY
    product_name;



--Storing query result in a variable
DECLARE @product_count INT;

--use the SET statement to assign the query’s result set to the variable:

SET @product_count = (
    SELECT 
        COUNT(*) 
    FROM 
        production.products 
);


-- output the content of the @product_count variable: Or you can use the PRINT statement to print out the content of a variable:


SELECT @product_count;

PRINT @product_count;

PRINT 'The number of products is ' + CAST(@product_count AS VARCHAR(MAX));

0/p - The number of products is 204


--To hide the number of rows affected messages, you use the following statement:

SET NOCOUNT ON;   


--Selecting a record into variables
--The following steps illustrate how to declare two variables, assign a record to them, and output the contents of the variables:

DECLARE 
    @product_name VARCHAR(MAX),
    @list_price DECIMAL(10,2);


--assign the column names to the corresponding variables:

SELECT 
    @product_name = product_name,
    @list_price = list_price
FROM
    production.products
WHERE
    product_id = 100;


--Third, output the content of the variables:

SELECT 
    @product_name AS product_name, 
    @list_price AS list_price;



--Accumulating values into a variable
--The following stored procedure takes one parameter and returns a list of products as a string:

CREATE  PROC uspGetProductList(
    @model_year SMALLINT
) AS 
BEGIN
    DECLARE @product_list VARCHAR(MAX);

    SET @product_list = '';

    SELECT
        @product_list = @product_list + product_name 
                        + CHAR(10)
    FROM 
        production.products
    WHERE
        model_year = @model_year
    ORDER BY 
        product_name;

    PRINT @product_list;
END;



--
EXEC uspGetProductList 2018



--Creating output parameters
--To create an output parameter for a stored procedure, you use the following syntax:

parameter_name data_type OUTPUT

--

CREATE PROCEDURE uspFindProductByModel (
    @model_year SMALLINT,
    @product_count INT OUTPUT
) AS
BEGIN
    SELECT 
        product_name,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;

    SELECT @product_count = @@ROWCOUNT;
END;


--Note that the @@ROWCOUNT is a system variable that returns the number of rows read by the previous statement.
--Once you execute the CREATE PROCEDURE statement above, the uspFindProductByModel stored procedure is compiled and saved in the database catalog.


--Calling stored procedures with output parameters

DECLARE @count INT;

EXEC uspFindProductByModel
    @model_year = 2018,
    @product_count = @count OUTPUT;

SELECT @count AS 'Number of products found';




--

--first
DECLARE @count INT;

--then
EXEC uspFindProductByModel 
     @model_year = 2018, 
     @product_count = @count OUTPUT;


--You can call the uspFindProductByModel stored procedure as follows:

EXEC uspFindProductByModel 2018, @count OUTPUT;

--Note that if you forget the OUTPUT keyword after the @count variable, the @count variable will be NULL.
--show the value of the @count variable:

SELECT @count AS 'Number of products found';



--SQL Server BEGIN END
--The BEGIN...END statement is used to define a statement block. A statement block consists of a set of SQL statements that execute together. A statement block is also known as a batch.


BEGIN
    SELECT
        product_id,
        product_name
    FROM
        production.products
    WHERE
        list_price > 100000;

    IF @@ROWCOUNT = 0
        PRINT 'No product with price greater than 100000 found';
END


--To view the messages generated by the PRINT statement, in SQL Server Management Studio, you need to click the Messages tab. By default, the Messages tab is hidden.

--The BEGIN... END statement bounds a logical block of SQL statements. We often use the BEGIN...END at the start and end of a stored procedure and function. But it is not strictly necessary.
--However, the BEGIN...END is required for the IF ELSE statements, WHILE statements, etc., where you need to wrap multiple statements.


--Nesting BEGIN... END
--In this example, we used the BEGIN...END statement to wrap the whole statement block. Inside this block, we also used the BEGIN...END for the IF...ELSE statement.


BEGIN
    DECLARE @name VARCHAR(MAX);

    SELECT TOP 1
        @name = product_name
    FROM
        production.products
    ORDER BY
        list_price DESC;
    
    IF @@ROWCOUNT <> 0
    BEGIN
        PRINT 'The most expensive product is ' + @name
    END
    ELSE
    BEGIN
        PRINT 'No product found';
    END;
END



--SQL Server IF ELSE
--The IF...ELSE statement is a control-flow statement that allows you to execute or skip a statement block based on a specified condition.

BEGIN
    DECLARE @sales INT;

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2018;

    SELECT @sales;

    IF @sales > 1000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 1,000,000';
    END
END


--The output of the code block is:
Great! The sales amount in 2018 is greater than 1,000,000


--The IF ELSE statement
--When the condition in the IF clause evaluates to FALSE and you want to execute another statement block, you can use the ELSE clause.

--The following illustrates the IF ELSE statement:

IF Boolean_expression
BEGIN
    -- Statement block executes when the Boolean expression is TRUE
END
ELSE
BEGIN
    -- Statement block executes when the Boolean expression is FALSE
END


--
BEGIN
    DECLARE @sales INT;

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2017;

    SELECT @sales;

    IF @sales > 10000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 10,000,000';
    END
    ELSE
    BEGIN
        PRINT 'Sales amount in 2017 did not reach 10,000,000';
    END
END

o/p- Sales amount did not reach 10,000,000


--Nested IF...ELSE

BEGIN
    DECLARE @x INT = 10,
            @y INT = 20;

    IF (@x > 0)
    BEGIN
        IF (@x < @y)
            PRINT 'x > 0 and x < y';
        ELSE
            PRINT 'x > 0 and x >= y';
    END			
END

o/p- x > 0 and x < y


--SQL Server WHILE example
DECLARE @counter INT = 1;

WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END


--Output:

1
2
3
4
5


--SQL Server BREAK
DECLARE @counter INT = 0;

WHILE @counter <= 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 4
        BREAK;
    PRINT @counter;
END


--Output:

1
2
3


--SQL Server CONTINUE example
DECLARE @counter INT = 0;

WHILE @counter < 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 3
        CONTINUE;	
    PRINT @counter;
END

--o/p

1
2
4
5


--SQL Server CURSOR
--A database cursor is an object that enables traversal over the rows of a result set. It allows you to process individual row returned by a query.

--First, declare a cursor.
DECLARE cursor_name CURSOR
    FOR select_statement;

--Next, open and populate the cursor by executing the SELECT statement:
OPEN cursor_name;

--Then, fetch a row from the cursor into one or more variables:
FETCH NEXT FROM cursor INTO variable_list;

--SQL Server provides the @@FETCHSTATUS function that returns the status of the last cursor FETCH statement executed against the cursor; If @@FETCHSTATUS returns 0, meaning the FETCH statement was successful. You can use the WHILE statement to fetch all rows from the cursor as shown in the following code:

WHILE @@FETCH_STATUS = 0  
    BEGIN
        FETCH NEXT FROM cursor_name;  
    END;

--After that, close the cursor:
CLOSE cursor_name;

--Finally, deallocate the cursor:
DEALLOCATE cursor_name;



--The following code snippets put everything together:
DECLARE 
    @product_name VARCHAR(MAX), 
    @list_price   DECIMAL;

DECLARE cursor_product CURSOR
FOR SELECT 
        product_name, 
        list_price
    FROM 
        production.products;

OPEN cursor_product;

FETCH NEXT FROM cursor_product INTO 
    @product_name, 
    @list_price;

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @product_name + CAST(@list_price AS varchar);
        FETCH NEXT FROM cursor_product INTO 
            @product_name, 
            @list_price;
    END;

CLOSE cursor_product;

DEALLOCATE cursor_product;




--SQL Server TRY CATCH
--The TRY CATCH construct allows you to gracefully handle exceptions in SQL Server. To use the TRY CATCH construct, you first place a group of Transact-SQL statements that could cause an exception in a BEGIN TRY...END TRY block as follows:

BEGIN TRY  
   -- statements that may cause exceptions
END TRY 
BEGIN CATCH  
   -- statements that handle exception
END CATCH  


--nested
BEGIN TRY
    --- statements that may cause exceptions
END TRY
BEGIN CATCH
    -- statements to handle exception
    BEGIN TRY
        --- nested TRY block
    END TRY
    BEGIN CATCH
        --- nested CATCH block
    END CATCH
END CATCH


--SQL Server TRY CATCH examples
CREATE PROC usp_divide(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;
GO



--Second, call the usp_divide stored procedure to divide 10 by 2:

DECLARE @r decimal;
EXEC usp_divide 10, 2, @r output;
PRINT @r;

o/p - 5


DECLARE @r2 decimal;
EXEC usp_divide 10, 0, @r2 output;
PRINT @r2;

The following picture shows the output:
Error: 


--https://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-try-catch/


--raiseerror

--https://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-raiserror/

DECLARE 
    @ErrorMessage  NVARCHAR(4000), 
    @ErrorSeverity INT, 
    @ErrorState    INT;

BEGIN TRY
    RAISERROR('Error occurred in the TRY block.', 17, 1);
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(), 
        @ErrorSeverity = ERROR_SEVERITY(), 
        @ErrorState = ERROR_STATE();

    -- return the error inside the CATCH block
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;

--Here is the output:
Msg 50000, Level 17, State 1, Line 16
Error occurred in the TRY block.


--SQL Server THROW
BEGIN TRY
    INSERT INTO t1(id) VALUES(1);
    --  cause error
    INSERT INTO t1(id) VALUES(1);
END TRY
BEGIN CATCH
    PRINT('Raise the caught error again');
    THROW;
END CATCH



--SQL Server Dynamic SQL
--Dynamic SQL is a programming technique that allows you to construct SQL statements dynamically at runtime. It allows you to create more general purpose and flexible SQL statement because the full text of the SQL statements may be unknown at compilation. For example, you can use the dynamic SQL to create a stored procedure that queries data against a table whose name is not known until runtime.


--Creating a dynamic SQL is simple, you just need to make it a string as follows:

'SELECT * FROM production.products';

--To execute a dynamic SQL statement, you call the stored procedure sp_executesql as shown in the following statement:

EXEC sp_executesql N'SELECT * FROM production.products';

--Because the sp_executesql accepts the dynamic SQL as a Unicode string, you need to prefix it with an N.

DECLARE 
    @table NVARCHAR(128),
    @sql NVARCHAR(MAX);

SET @table = N'production.products';

SET @sql = N'SELECT * FROM ' + @table;

EXEC sp_executesql @sql;



--SQL Server dynamic SQL and stored procedures
--This stored procedure accepts any table and returns the result set from a specified table by using the dynamic SQL:

CREATE PROC usp_query (
    @table NVARCHAR(128)
)
AS
BEGIN

    DECLARE @sql NVARCHAR(MAX);
    -- construct SQL
    SET @sql = N'SELECT * FROM ' + @table;
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;


EXEC usp_query 'production.brands';


--https://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-dynamic-sql/



--SQL Server Table Variables
--Table variables are kinds of variables that allow you to hold rows of data, which are similar to temporary tables.

--Similar to local variables, table variables are out of scope at the end of the batch.

DECLARE @product_table TABLE (
    product_name VARCHAR(MAX) NOT NULL,
    brand_id INT NOT NULL,
    list_price DEC(11,2) NOT NULL
);

--Inserting data into the table variables
--Once declared, the table variable is empty. You can insert rows into the table variables using the INSERT statement:

INSERT INTO @product_table
SELECT
    product_name,
    brand_id,
    list_price
FROM
    production.products
WHERE
    category_id = 1;


--Querying data from the table variables
--Similar to a temporary table, you can query data from the table variables using the SELECT statement:

SELECT
    *
FROM
    @product_table;



--Note that you need to execute the whole batch or you will get an error:

DECLARE @product_table TABLE (
    product_name VARCHAR(MAX) NOT NULL,
    brand_id INT NOT NULL,
    list_price DEC(11,2) NOT NULL
);

INSERT INTO @product_table
SELECT
    product_name,
    brand_id,
    list_price
FROM
    production.products
WHERE
    category_id = 1;

SELECT
    *
FROM
    @product_table;
GO


--SQL Server Scalar Functions
--SQL Server scalar function takes one or more parameters and returns a single value.

CREATE FUNCTION sales.udfNetSale(
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2)
)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;


--You call a scalar function like a built-in function. For example, the following statement demonstrates how to call the udfNetSale function:
SELECT 
    sales.udfNetSale(10,100,0.1) net_sale;

o/p - 900.00


--The following example illustrates how to use the sales.udfNetSale function to get the net sales of the sales orders in the order_items table:

SELECT 
    order_id, 
    SUM(sales.udfNetSale(quantity, list_price, discount)) net_amount
FROM 
    sales.order_items
GROUP BY 
    order_id
ORDER BY
    net_amount DESC;



ALTER FUNCTION [schema_name.]function_name (parameter_list)
    RETURN data_type AS
    BEGIN
        statements
        RETURN value
    END


--Note that you can use the CREATE OR ALTER statement to create a user-defined function if it does not exist or to modify an existing scalar function:

CREATE OR ALTER FUNCTION [schema_name.]function_name (parameter_list)
        RETURN data_type AS
        BEGIN
            statements
            RETURN value
        END

    
--To remove an existing scalar function, you use the DROP FUNCTION statement:
DROP FUNCTION [schema_name.]function_name;
DROP FUNCTION sales.udfNetSale;


--SQL Server Table-valued Functions
--Creating a table-valued function
--The following statement example creates a table-valued function that returns a list of products including product name, model year and the list price for a specific model year:

CREATE FUNCTION udfProductInYear (
    @model_year INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        product_name,
        model_year,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;

--The syntax is similar to the one that creates a user-defined function.

--The RETURNS TABLE specifies that the function will return a table. As you can see, there is no BEGIN...END statement. The statement simply queries data from the production.products table.


--Executing a table-valued function
--To execute a table-valued function, you use it in the FROM clause of the SELECT statement:

SELECT 
    * 
FROM 
    udfProductInYear(2017);

--https://www.sqlservertutorial.net/sql-server-user-defined-functions/sql-server-table-valued-functions/


--SQL Server DROP FUNCTION
DROP FUNCTION [ IF EXISTS ] [ schema_name. ] function_name;

DROP FUNCTION IF EXISTS sales.udf_get_discount_amount;
DROP FUNCTION sales.udf_get_discount_amount;


--Introduction to SQL Server CREATE TRIGGER statement
--The CREATE TRIGGER statement allows you to create a new trigger that is fired automatically whenever an event such as INSERT, DELETE, or UPDATE occurs against a table.


--1) Create a table for logging the changes
--The following statement creates a table named production.product_audits to record information when an INSERT or DELETE event occurs against the production.products table:

CREATE TABLE production.product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);


--2) Creating an after DML trigger

CREATE TRIGGER production.trg_product_audit
ON production.products
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO production.product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d;
END



--3) Testing the trigger
--The following statement inserts a new row into the production.products table:

INSERT INTO production.products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);


--Because of the INSERT event, the production.trg_product_audit trigger of production.products table was fired.
--Let’s examine the contents of the production.product_audits table:

SELECT 
    * 
FROM 
    production.product_audits;

 o/p-  with insert


--
DELETE FROM 
    production.products
WHERE 
    product_id = 322;

--As expected, the trigger was fired and inserted the deleted row into the production.product_audits table:

SELECT 
    * 
FROM 
    production.product_audits;

o/p - from insert , from delete



--SQL Server INSTEAD OF Trigger
https://www.sqlservertutorial.net/sql-server-triggers/sql-server-instead-of-trigger/


--SQL Server DDL Trigger
https://www.sqlservertutorial.net/sql-server-triggers/sql-server-ddl-trigger/


--SQL Server DISABLE TRIGGER example
DISABLE TRIGGER sales.trg_members_insert 
ON sales.members;

--disable all trigger
DISABLE TRIGGER ALL ON sales.members;


--Enable trigger 
ENABLE TRIGGER sales.trg_members_insert
ON sales.members;

ENABLE TRIGGER ALL ON DATABASE; 


--SQL Server View Trigger Definition
https://www.sqlservertutorial.net/sql-server-triggers/sql-server-view-trigger-definition/


--Drop trigger
DROP TRIGGER IF EXISTS sales.trg_member_insert;


--SQL Server Aggregate Functions
--https://www.sqlservertutorial.net/sql-server-aggregate-functions/

Aggregate     function	Description
AVG - 	Calculate the average of non-NULL values in a set of values.
CHECKSUM_AGG -	Calculate a checksum value based on a group of rows.
COUNT	- Return the number of rows in a group that satisfy a condition.
COUNT(*) -	Return the number of rows from a table, which meets a certain condition.
COUNT(DISTINCT) -	Return the number of unique values in a column that meets a certain condition.
COUNT IF -	Show you how to use the COUNT function with the IIF function to form a COUNT IF function that returns the total number of values based on a condition.
COUNT_BIG -	The COUNT_BIG() function returns the number of rows (with BIGINT data type) in a group, including rows with NULL values.
MAX	- Return the highest value (maximum) in a set of non-NULL values.
MIN	- Return the lowest value (minimum) in a set of non-NULL values.
STDEV -	Calculate the sample standard deviation of a set of values.
STDEVP -	Return the population standard deviation of a set of values.
SUM -	Return the summation of all non-NULL values in a set.
SUM IF -	Use the SUM function with the IIF function to form a SUM IF function that returns the total of values based on a condition.
STRING_AGG - 	Concatenate strings by a specified separator
VAR -	Return the sample variance of a set of values.
VARP	- Return the population variance of a set of values.


--
SELECT
    CAST(ROUND(AVG(list_price),2) AS DEC(10,2))
    avg_product_price
FROM
    production.products;


SELECT
    COUNT(*) product_count
FROM
    production.products
WHERE
    list_price > 500;




---------
Aggregate functions operate on rows and return a single row.
Use aggregate functions with the GROUP BY clause to aggregate values within groups.
Use the AVG() function to calculate the average of values.
Use the SUM() function to calculate the total of values.
Use the COUNT() function to count the number of values in a column.
Use the MIN() function to get the minimum value in a set.
Use the MAX() function to get the maximum value in a set.



--SQL Server COUNT IF example
SELECT COUNT(IIF(employee_type='Full-time',1,NULL)) full_time_employee_count
FROM employees;



--Returning the current date and time
Function	Description
CURRENT_TIMESTAMP	Returns the current system date and time without the time zone part.
GETUTCDATE	Returns a date part of a date as an integer number.
GETDATE	Returns the current system date and time of the operating system on which the SQL Server is running.
SYSDATETIME	Returns the current system date and time with more fractional seconds precision than the GETDATE() function.
SYSUTCDATETIME	Returns the current system date and time in UTC time
SYSDATETIMEOFFSET	Returns the current system date and time with the time zone.

--Returning the date and time Parts
Function	Description
DATENAME	Returns a date part of a date as a character string
DATEPART	Returns a date part of a date as an integer number
DAY	Returns the day of a specified date as an integer
MONTH	Returns the month of a specified date as an integer
YEAR	Returns the year of the date as an integer.

--Returning a difference between two dates
Function	Return value
DATEDIFF	Returns a difference in date part between two dates.

--Modifying dates
Function	Description
DATEADD	Adds a value to a date part of a date and return the new date value.
EOMONTH	Returns the last day of the month containing the specified date, with an optional offset.
SWITCHOFFSET	Changes the time zone offset of a DATETIMEOFFSET value and preserves the UTC value.
TODATETIMEOFFSET	Transforms a DATETIME2 value into a DATETIMEOFFSET value.

--Constructing date and time from their parts
Function	Description
DATEFROMPARTS	Return a DATE value from the year, month, and day.
DATETIME2FROMPARTS	Returns a DATETIME2 value from the date and time arguments
DATETIMEOFFSETFROMPARTS	Returns a DATETIMEOFFSET value from the date and time arguments
TIMEFROMPARTS	Returns a TIME value from the time parts with the precisions

--Validating date and time values
Function	Description
ISDATE	Check if a value is a valid date, time, or datetime value


https://www.sqlservertutorial.net/sql-server-date-functions/


--SQL Server TODATETIMEOFFSET() function examples
--A) Using SQL Server TODATETIMEOFFSET() function the change the time zone offset of a date and time example

SELECT
    TODATETIMEOFFSET (
        '2019-03-06 07:43:58',
        '-08:00'
    ) result;


result
----------------------------------
2019-03-06 07:43:58.0000000 -08:00

(1 row affected)


--B) Using SQL Server TODATETIMEOFFSET() function to change the time zone offset in minutes
SELECT 
    TODATETIMEOFFSET (GETDATE(), -180) result;


result
----------------------------------
2019-03-06 08:34:32.087 -03:00

(1 row affected)


--C) Using SQL Server TODATETIMEOFFSET() function to add a specified hour time zone offset to the current date and time

SELECT 
    TODATETIMEOFFSET (
        '2019-03-06 09:55:00', 
        '+13:00') 
    result;


result
----------------------------------
2019-03-06 09:55:00.0000000 +13:00

(1 row affected)




--SQL Server String Functions
--The following SQL Server string functions process on an input string and return a string or numeric value:

--https://www.sqlservertutorial.net/sql-server-string-functions/

Function	Description
ASCII	Return the ASCII code value of a character
CHAR	Convert an ASCII value to a character
CHARINDEX	Search for a substring inside a string starting from a specified location and return the position of the substring.
CONCAT	Join two or more strings into one string
CONCAT_WS	Concatenate multiple strings with a separator into a single string
DIFFERENCE	Compare the SOUNDEX() values of two strings
FORMAT	Return a value formatted with the specified format and optional culture
LEFT	Extract a given a number of characters from a character string starting from the left
LEN	Return a number of characters of a character string
LOWER	Convert a string to lowercase
LTRIM	Return a new string from a specified string after removing all leading blanks
NCHAR	Return the Unicode character with the specified integer code, as defined by the Unicode standard
PATINDEX	Returns the starting position of the first occurrence of a pattern in a string.
QUOTENAME	Returns a Unicode string with the delimiters added to make the input string a valid delimited identifier
REPLACE	Replace all occurrences of a substring, within a string, with another substring
REPLICATE	Return a string repeated a specified number of times
REVERSE	Return the reverse order of a character string
RIGHT	Extract a given a number of characters from a character string starting from the right
RTRIM	Return a new string from a specified string after removing all trailing blanks
SOUNDEX	Return a four-character (SOUNDEX) code of a string based on how it is spoken
SPACE	Returns a string of repeated spaces.
STR	Returns character data converted from numeric data.
STRING_AGG	Concatenate rows of strings with a specified separator into a new string
STRING_ESCAPE	Escapes special characters in a string and returns a new string with escaped characters
STRING_SPLIT	A table-valued function that splits a string into rows of substrings based on a specified separator.
STUFF	Delete a part of a string and then insert another substring into the string starting at a specified position.
SUBSTRING	Extract a substring within a string starting from a specified location with a specified length
TRANSLATE	Replace several single-characters, one-to-one translation in one operation.
TRIM	Return a new string from a specified string after removing all leading and trailing blanks
UNICODE	Returns the integer value, as defined by the Unicode standard, of a character.
UPPER	Convert a string to uppercase



--
'John' + ' ' + 'Doe' AS full_name;
CONCAT(first_name,' ',last_name),


CONCAT_WS(' ', 'John', 'Doe') full_name; o/p - John Doe

CONCAT_WS(', ', last_name, first_name) full_name  o/p - Ajay, Verma

CONCAT_WS(',', 1, 2, NULL, NULL, 3); o/p- 1,2,3

 CHAR(65) char_65, o/p -A

 SELECT LEFT('SQL Server',3) result; o/p - SQL



--
REPLACE(input_string, substring, new_substring);

REPLACE(REPLACE(phone, '(', ''), ')', '') phone_formatted

(912) 405060  -> 912 405060


REPLICATE('z',3) result; o/p -zzz

SUBSTRING(input_string, start, length);
SUBSTRING('SQL Server SUBSTRING', 5, 6) result; o/p -Server

STRING_SPLIT('red,green,,blue', ','); 
o/p -
value
---------------
red
green

blue



--SQL Server JSON Functions

https://www.sqlservertutorial.net/sql-server-json-functions/

JSON_VALUE() – Extract a scalar value from a JSON document.
JSON_QUERY() – Extract an object or an array from a JSON document.
JSON_MODIFY() – Insert, Update, and Delete elements in a JSON document.
OPENJSON() – Create a relational view of a JSON document.



--1) Basic SQL Server FOR JSON clause example
--https://www.sqlservertutorial.net/sql-server-json-functions/sql-server-for-json/
SELECT 
  TOP 5 product_id, 
  product_name, 
  list_price 
FROM 
  production.products 
ORDER BY 
  list_price DESC 
FOR JSON AUTO;


o/p 
[
  {
    "product_id": 155,
    "product_name": "Trek Domane SLR 9 Disc - 2018",
    "list_price": 11999.99
  },
  {
    "product_id": 149,
    "product_name": "Trek Domane SLR 8 Disc - 2018",
    "list_price": 7499.99
  },
  {
    "product_id": 51,
    "product_name": "Trek Silque SLR 8 Women's - 2017",
    "list_price": 6499.99
  },
  {
    "product_id": 156,
    "product_name": "Trek Domane SL Frameset - 2018",
    "list_price": 6499.99
  },
  {
    "product_id": 157,
    "product_name": "Trek Domane SL Frameset Women's - 2018",
    "list_price": 6499.99
  }
]




--SQL Server System Functions
--https://www.sqlservertutorial.net/sql-server-system-functions/

CAST – Cast a value of one type to another.
CONVERT – Convert a value of one type to another.
CHOOSE – Return one of the two values based on the result of the first argument.
ISNULL – Replace NULL with a specified value.
ISNUMERIC – Check if an expression is a valid numeric type.
IIF – Add if-else logic to a query.
TRY_CAST – Cast a value of one type to another and return NULL if the cast fails.
TRY_CONVERT – Convert a value of one type to another and return the value to be translated into the specified type. It returns NULL if the cast fails.
TRY_PARSE – Convert a string to a date/time or a number and return NULL if the conversion fails.
Convert datetime to string – Show you how to convert a datetime value to a string in a specified format.
Convert string to datetime – Describe how to convert a string to a datetime value.
Convert datetime to date – Convert a datetime to a date.
GENERATE_SERIES() – Generate a series of numbers within a specific range.



--SQL Server Window Functions
--https://www.sqlservertutorial.net/sql-server-window-functions/

Name	Description
CUME_DIST	Calculate the cumulative distribution of a value in a set of values
DENSE_RANK	Assign a rank value to each row within a partition of a result, with no gaps in rank values.
FIRST_VALUE	Get the value of the first row in an ordered partition of a result set.
LAG	Provide access to a row at a given physical offset that comes before the current row.
LAST_VALUE	Get the value of the last row in an ordered partition of a result set.
LEAD	Provide access to a row at a given physical offset that follows the current row.
NTILE	Distribute rows of an ordered partition into a number of groups or buckets
PERCENT_RANK	Calculate the percent rank of a value in a set of values.
RANK	Assign a rank value to each row within a partition of a result set
ROW_NUMBER	Assign a unique sequential integer to rows within a partition of a result set, the first row starts from 1.


--SQL Server Math Functions
--https://www.sqlservertutorial.net/sql-server-math-functions/

Function	Description
ABS	Return the absolute value of a number.
ACOS	Return an angle (in radians) of a specified cosine.
ASIN	Return an angle (in radians) of a specified sine.
ATAN	Return the arctangent (in radians) of a specified tangent.
CEILING	Round a number to the nearest integer greater than or equal to the input number.
COS	Return the cosine of the specified angle, measured in radians.
COT	Return the cotangent of the specified angle, which is the reciprocal of the tangent.
DEGREES	Convert an angle value in radians to degrees.
EXP	Return the exponential value of a number.
FLOOR	Round a number to the nearest integer less than or equal to the input value.
LOG	Return the natural logarithm of a float with a specific base (default to e).
PI	Return the constant value of PI, accurate to 15 digits.
POWER	Return the result of raising a number to a specific power.
RAND	Return a random float between 0 and 1.
RADIANS	Convert an angle value in degrees to radians.
ROUND	Return a number rounded to a specified precision.
SIGN	Return the sign of a number, 1 for positive, -1 for negative, and 0 for zero.
SIN	Return the sine of an angle in radians.
SQRT	Return the square root of a float.
SQUARE	Return the square of a number.
TAN	Return the tangent of the specified angle, measured in radians.





shorcut key

F5  - Execute query