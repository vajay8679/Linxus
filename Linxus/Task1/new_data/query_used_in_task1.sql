-- select query
SELECT TOP 5 * FROM [FIN].[26_KE24_FINAL];
SELECT TOP 5 * FROM [FIN].[25_KE24];

---------------------------------------------------------------------------------------------------------
-- for renaming column

EXEC sp_rename '[FIN].[26_KE24_FINAL].[PC_Description ]', 'PC Description', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Material_Description]', 'Material Description', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Matl_Group]', 'Matl Group', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Mat_group_description]', 'Mat group description', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Mat_group_ description2]', 'Mat group description 2', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Material_type]', 'Material type', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Material_group_description]', 'Material group description', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[KG_BOX_BAG]', 'KG/BOX_BAG', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Kg_unit]', 'Kg/unit', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Unit_Box]', 'Unit/Box', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Unit_Rol]', 'Unit/Rol', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[Type of Business_2]', 'Type of Business2', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[R1]', 'Responsible 1', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[R2]', 'Responsible 2', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[R3]', 'Responsible 3', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[R4]', 'Responsible 4', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[PC_Description2]', 'PC Description2', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[MS_Customer_Name]', 'M&S Customer Name', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[R2A]', 'Responsible 2A', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[R3A]', 'Responsible 3A', 'COLUMN';
EXEC sp_rename '[FIN].[26_KE24_FINAL].[R4A]', 'Responsible 4A', 'COLUMN';


-- for adding new column with data types

ALTER TABLE [FIN].[26_KE24_FINAL]
ADD [Freight Unitary Cost] DECIMAL(18,2) NULL;

ALTER TABLE [FIN].[26_KE24_FINAL]
ADD [Group2]  VARCHAR(50) NULL;

ALTER TABLE [FIN].[26_KE24_FINAL]
ADD [Material Description2] VARCHAR(50) NULL;


ALTER TABLE [FIN].[26_KE24_FINAL]
ADD [Freight Adjustment] DECIMAL(18,2) NOT NULL DEFAULT 0;

----------------------------------------------------------------------------------------------------------

-- for renaming column

EXEC sp_rename '[FIN].[25_KE24].[PC_Description ]', 'PC Description', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Material_Description]', 'Material Description', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Matl_Group]', 'Matl Group', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Mat_group_description]', 'Mat group description', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Mat_group_ description2]', 'Mat group description 2', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Material_type]', 'Material type', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Material_group_description]', 'Material group description', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[KG_BOX_BAG]', 'KG/BOX_BAG', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Kg_unit]', 'Kg/unit', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Unit_Box]', 'Unit/Box', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Unit_Rol]', 'Unit/Rol', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[Type of Business_2]', 'Type of Business2', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R1]', 'Responsible 1', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R2]', 'Responsible 2', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R3]', 'Responsible 3', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R4]', 'Responsible 4', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[PC_Description2]', 'PC Description2', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[MS_Customer_Name]', 'M&S Customer Name', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R2A]', 'Responsible 2A', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R3A]', 'Responsible 3A', 'COLUMN';
EXEC sp_rename '[FIN].[25_KE24].[R4A]', 'Responsible 4A', 'COLUMN';


-- for adding new column with data types

ALTER TABLE [FIN].[25_KE24]
ADD [Freight Unitary Cost] DECIMAL(18,2) NULL;

ALTER TABLE [FIN].[25_KE24]
ADD [Group2]  VARCHAR(50) NULL;

ALTER TABLE [FIN].[25_KE24]
ADD [Material Description2] VARCHAR(50) NULL;

ALTER TABLE [FIN].[25_KE24]
ADD [Freight Adjustment] DECIMAL(18,2) NOT NULL DEFAULT 0;
-------------------------------------------------------------------------------------------------


-- ###############################################################################################

----------------------------------------------- tried command --------------------------------

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



--------------------------


--truncate table
TRUNCATE TABLE sales.addresses;



----------------
--check execution

EXEC sp_who2;
GO