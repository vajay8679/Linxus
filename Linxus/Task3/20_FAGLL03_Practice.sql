use ENAEX_FIN_PRD;

create Table [FIN].[20_FAGLL03_Practice] (
   [Account] VARCHAR(50) NULL,
   [Assignment] VARCHAR(50) NULL,
   [Document Number] VARCHAR(50) NULL,
   [Document Date] date NULL,
   [Amount in local currency] NUMERIC(18,2) NULL,
   [Local Currency] VARCHAR(50) NULL,
   [Amount in loc.curr.2] NUMERIC(18,2) NULL,
   [Amount in doc. curr.] NUMERIC(18,2) NULL,
   [Profit Center] VARCHAR(50) NULL,
   [Quantity] NUMERIC(18,2) NULL,
   [Text] VARCHAR(50) NULL,
   [Base Unit of Measure] VARCHAR(50) NULL,
   [Company Code] VARCHAR(50) NULL,
   [Cost Center] VARCHAR(50) NULL,
   [Cost Element] VARCHAR(50) NULL,
   [Document Number G/L] VARCHAR(50) NULL,
   [Functional Area] VARCHAR(50) NULL,
   [G/L Fiscal Year] NUMERIC(18,2) NULL,
   [General ledger currency] VARCHAR(50) NULL,
   [General Ledger Item] VARCHAR(50) NULL,
   [Invoice reference] VARCHAR(50) NULL,
   [Material] VARCHAR(50) NULL,
   [Order] VARCHAR(50) NULL,
   [Partner Profit Ctr] VARCHAR(50) NULL,
   [Plant] VARCHAR(50) NULL,
   [Posting Period] NUMERIC(18,2) NULL,
   [Reference] VARCHAR(50) NULL,
   [User name] VARCHAR(50) NULL,
   [Type] VARCHAR(50) NULL
    );





create Table [FIN].[21_FAGLL03_FINAL_Practice] (
   [Version] VARCHAR(50) NULL,
   [G/L Fiscal Year] int NULL,
   [Posting period] int NULL,
   [Type] VARCHAR(50) NULL,
   [Account] VARCHAR(50) NULL,
   [Long Text] VARCHAR(50) NULL,
   [Denom1] VARCHAR(50) NULL,
   [Assignment] VARCHAR(50) NULL,
   [Document Number] VARCHAR(50) NULL,
   [Document Date] date NULL,
   [Amount in local currency] NUMERIC(18,2) NULL,
   [Local Currency] VARCHAR(50) NULL,
   [Amount in loc curr 2] NUMERIC(18,2) NULL,
   [Amount in doc curr] NUMERIC(18,2) NULL,
   [Profit Center] VARCHAR(50) NULL,
   [PC Description] VARCHAR(50) NULL,
   [Country] VARCHAR(50) NULL,
   [Text1] VARCHAR(50) NULL,
   [Base Unit of Measure] VARCHAR(50) NULL,
   [Company Code] VARCHAR(50) NULL,
   [Cost Center] VARCHAR(50) NULL,
   [CC Description] VARCHAR(50) NULL,
   [Responsible 1] VARCHAR(50) NULL,
   [Responsible 2] VARCHAR(50) NULL,
   [Responsible 3] VARCHAR(50) NULL,
   [Responsible 4] VARCHAR(50) NULL,
   [Cost Element] VARCHAR(50) NULL,
   [Document Number G/L] VARCHAR(50) NULL,
   [Functional Area] VARCHAR(50) NULL,
   [Description] VARCHAR(50) NULL,
   [Group] VARCHAR(50) NULL,
   [General ledger currency] VARCHAR(50) NULL,
   [General Ledger Item] VARCHAR(50) NULL,
   [Invoice reference] VARCHAR(50) NULL,
   [Material] VARCHAR(50) NULL,
   [Material Description]  VARCHAR(50) NULL,
   [Matl Group]  VARCHAR(50) NULL,
   [Mat group description]  VARCHAR(50) NULL,
   [Mat group description 2]  VARCHAR(50) NULL,
   [Material type]  VARCHAR(50) NULL,
   [Material group description]  VARCHAR(50) NULL,
   [Order]  VARCHAR(50) NULL,
   [Partner Profit Ctr]  VARCHAR(50) NULL,
   [Plant]  VARCHAR(50) NULL,
   [New Plant Name] VARCHAR(50) NULL,
   [Quantity]  VARCHAR(50) NULL,
   [User name]  VARCHAR(50) NULL,
   [Status]  VARCHAR(50) NULL,
   [R2A]  VARCHAR(50) NULL,
   [R3A]  VARCHAR(50) NULL,
   [R4A]  VARCHAR(50) NULL
    );



   SELECT TOP (1000) [Version]
      ,[G/L Fiscal Year]
      ,[Posting period]
      ,[Type]
      ,[Account]
      ,[Long Text]
      ,[Denom1]
      ,[Assignment]
      ,[Document Number]
      ,[Document Date]
      ,[Amount in local currency]
      ,[Local Currency]
      ,[Amount in loc curr 2]
      ,[Amount in doc curr]
      ,[Profit Center]
      ,[PC Description]
      ,[Country]
      ,[Text1]
      ,[Base Unit of Measure]
      ,[Company Code]
      ,[Cost Center]
      ,[CC Description]
      ,[Responsible 1]
      ,[Responsible 2]
      ,[Responsible 3]
      ,[Responsible 4]
      ,[Cost Element]
      ,[Document Number G/L]
      ,[Functional Area]
      ,[Description]
      ,[Group]
      ,[General ledger currency]
      ,[General Ledger Item]
      ,[Invoice reference]
      ,[Material]
      ,[Material Description]
      ,[Matl Group]
      ,[Mat group description]
      ,[Mat group description 2]
      ,[Material type]
      ,[Material group description]
      ,[Order]
      ,[Partner Profit Ctr]
      ,[Plant]
      ,[New Plant Name]
      ,[Quantity]
      ,[User name]
      ,[Status]
      ,[R2A]
      ,[R3A]
      ,[R4A]
  FROM [FIN].[21_FAGLL03 FINAL]