SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER PROCEDURE [FIN].[SP_ProcessNewFAGLL03Upload_Optimized]

@pFAGLL03UploadID INT,
@pUploadFunction NVARCHAR(50) 

 AS
 
BEGIN 

DECLARE @csvFile  VARCHAR(MAX),
@csvContent NVARCHAR(MAX),
@csvString NVARCHAR(MAX),
@currentRowNum INT,
@totalRows INT,
@startrow INT,
@offset INT,
@end INT,
@currentCSV VARCHAR(MAX)
 DECLARE @csvTable TABLE (Rownum INT,csvString VARCHAR(max));
 
DECLARE @tempTable TABLE(
tempTableID INT IDENTITY (1,1) NOT NULL,
Account VARCHAR(50),
Assignment VARCHAR(50),
DocumentNumber VARCHAR(50),
DocumentDate VARCHAR(50),
Amountinlocalcurrency VARCHAR(50),
LocalCurrency VARCHAR(50),
Amountinloccurr2 VARCHAR(50), 
Amountinloccurr VARCHAR(50),  
ProfitCenter VARCHAR(50),     
Quantity VARCHAR(50),         
[Text] VARCHAR(50),
BaseUnitofMeasure VARCHAR(50),
CompanyCode VARCHAR(50),
CostCenter VARCHAR(50),
CostElement VARCHAR(50),
DocumentNumberGL VARCHAR(50),
FunctionalArea VARCHAR(50),
GLFiscalYear VARCHAR(50),
Generalledgercurrency VARCHAR(50),
GeneralLedgerItem VARCHAR(50),
Invoicereference VARCHAR(50),
Material VARCHAR(50),
[Order]	 VARCHAR(50),
PartnerProfitCtr VARCHAR(50),
Plant	 VARCHAR(50),
PostingPeriod VARCHAR(50),
Reference VARCHAR(50),
Username VARCHAR(50) 


)

SET @csvFile=(SELECT FileContent FROM [FIN].[FAGLL03Upload] WHERE FAGLL03FileID=@pFAGLL03UploadID  )

SET @csvContent=SUBSTRING(@csvFile,CHARINDEX('<content>',@csvFile)+9,LEN(@csvFile)-CHARINDEX('<content>',@csvFile)-25)


SELECT @csvString=LTRIM(RTRIM(CONVERT(VARCHAR(MAX),CAST('' AS XML).value('xs:base64Binary(sql:column("BASE64_COLUMN"))','VARBINARY(MAX)')
)))
FROM (SELECT @csvContent AS BASE64_COLUMN) A;
 
INSERT INTO @csvTable
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS RowNum,
VALUE AS CSV_Row
FROM STRING_SPLIT(@csvString,CHAR(13))
WHERE LEN(VALUE)>1;

UPDATE @csvTable
SET csvString=REPLACE(csvString,',','|');

--SET @totalRows=(SELECT COUNT(RowNum) FROM @csvTable)
--SET @currentRowNum=2;


SET @totalRows = (SELECT COUNT(RowNum) FROM @csvTable);
SET @startrow = 2;
SET @offset = 10000;
SET @end = @startrow + @offset;
 
WHILE (@startrow <= @totalRows)
BEGIN
SET @currentCSV=(SELECT csvString FROM @csvTable WHERE RowNum=@startrow)
/*SELECT top 100
*,
NULLIF(REPLACE(REPLACE(VALUE,CHAR(13),''),CHAR(10),''),'') AS cellValue
FROM @csvTable cross apply STRING_SPLIT(csvString,'|', 1);
*/
-- select * from @csvTable;	

INSERT INTO @tempTable(Account,Assignment,DocumentNumber,DocumentDate,Amountinlocalcurrency,LocalCurrency
,Amountinloccurr2,Amountinloccurr,ProfitCenter,Quantity,[Text],BaseUnitofMeasure,CompanyCode,CostCenter
,CostElement,DocumentNumberGL,FunctionalArea,GLFiscalYear,Generalledgercurrency,GeneralLedgerItem,Invoicereference,Material,[Order]
,PartnerProfitCtr,Plant,PostingPeriod,Reference,Username )
SELECT [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
                         [21],[22],[23],[24],[25],[26],[27],[28] FROM ( 
SELECT 
Rownum,
ordinal,
NULLIF(REPLACE(REPLACE(VALUE,CHAR(13),''),CHAR(10),''),'') AS cellValue
FROM @csvTable cross apply STRING_SPLIT(csvString,'|', 1)
 where Rownum >= @startrow AND Rownum < @end
) src
PIVOT(
MAX(cellValue) FOR ordinal IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
                         [21],[22],[23],[24],[25],[26],[27],[28]  )) piv;
	

--SET @currentRowNum+=1;
--SET @startrow=@end;
--SET @end=@end+@offset;

SET @startrow = @end;
SET @end = @startrow + @offset;

END

--select * from @tempTable;



IF @pUploadFunction='SAP'
BEGIN
INSERT INTO [FIN].[19_FAGLL03 STAGING](Account,Assignment,[Document Number],[Local Currency],[Profit Center],[Text],[Base Unit of Measure],[Company Code],[Cost Center]
,[Cost Element],[Document Number G/L],[Functional Area],[General ledger currency],[General Ledger Item],[Invoice reference]
,Material,[Order],[Partner Profit Ctr],Plant,Reference,[User name])

SELECT Account,Assignment,DocumentNumber,LocalCurrency
,ProfitCenter,[Text],BaseUnitofMeasure,CompanyCode,CostCenter
,CostElement,DocumentNumberGL,FunctionalArea,Generalledgercurrency,GeneralLedgerItem,Invoicereference,Material,[Order]
,PartnerProfitCtr,Plant,Reference,Username
FROM @tempTable

END


IF @pUploadFunction='Adjustments'
BEGIN
INSERT INTO [FIN].[21_FAGLL03 FINAL](Account,Assignment,[Document Number],[Document Date],[Amount in local currency],[Local Currency],
[Amount in loc curr 2],[Amount in doc curr],[Profit Center],[Quantity],[Long Text],[Base Unit of Measure],[Company Code],[Cost Center]
,[Cost Element],[Document Number G/L],[Functional Area],[G/L Fiscal Year],[General ledger currency],[General Ledger Item],[Invoice reference]
,Material,[Order],[Partner Profit Ctr],Plant,[Posting Period],[User name])

SELECT Account,Assignment,DocumentNumber,DocumentDate,Amountinlocalcurrency,LocalCurrency
,Amountinloccurr2,Amountinloccurr,ProfitCenter,Quantity,[Text],BaseUnitofMeasure,CompanyCode,CostCenter
,CostElement,DocumentNumberGL,FunctionalArea,GLFiscalYear,Generalledgercurrency,GeneralLedgerItem,Invoicereference,Material,[Order]
,PartnerProfitCtr,Plant,PostingPeriod,Username
FROM @tempTable
END

END
/*
file id: 5
10 row - 17 seconds
100 rows - 17 seconds
500 rows - 18 second
1000 rows - 19 second
4000 rows - 25 second
8000 rows - 33 second

file id: 6
8000 rows - 43 second
16000 rows - 50 second
All records - 
*/


EXECUTE [FIN].[SP_ProcessNewFAGLL03Upload_Optimized] 
    @pFAGLL03UploadID = 6, 
    @pUploadFunction = 'SAP';


 select top 5000 * from FIN.[19_FAGLL03 STAGING]

 select count(*) from FIN.[19_FAGLL03 STAGING]