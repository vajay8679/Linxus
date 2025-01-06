--select * from @csvTable;

Rownum	csvString
1	Account,Assignment,Document Number,Document Date,Amount in local currency,Local Currency,Amount in loc.curr.2,Amount in doc. curr.,Profit Center,Quantity,Text,Base Unit of Measure,Company Code,Cost Center,Cost Element,Document Number G/L,Functional Area,G/L Fiscal Year,General ledger currency,General Ledger Item,Invoice reference,Material,Order,Partner Profit Ctr,Plant,Posting Period,Reference,User name
2	
230000,20230504,1500000095,5/4/2023,"-24,075.61",BWP,-510.40,0.00,BW08W01,0.000,,,BW08,,,1500000095,SK50,2023,ZAR,000004,1500000095,,,,,5,,KAHTSY
3	
230000,20230504,1500000095,5/4/2023,0.02,BWP,0.03,0.00,BW08Z01,0.000,,,BW08,,,1500000095,SK50,2023,ZAR,000005,1500000095,,,,,5,,KAHTSY


....

34204 records




UPDATE @csvTable
SET csvString=REPLACE(csvString,',','|');

select * from @csvTable;



Rownum	csvString
1	Account|Assignment|Document Number|Document Date|Amount in local currency|Local Currency|Amount in loc.curr.2|Amount in doc. curr.|Profit Center|Quantity|Text|Base Unit of Measure|Company Code|Cost Center|Cost Element|Document Number G/L|Functional Area|G/L Fiscal Year|General ledger currency|General Ledger Item|Invoice reference|Material|Order|Partner Profit Ctr|Plant|Posting Period|Reference|User name
2	
230000|20230504|1500000095|5/4/2023|"-24|075.61"|BWP|-510.40|0.00|BW08W01|0.000|||BW08|||1500000095|SK50|2023|ZAR|000004|1500000095|||||5||KAHTSY
3	
230000|20230504|1500000095|5/4/2023|0.02|BWP|0.03|0.00|BW08Z01|0.000|||BW08|||1500000095|SK50|2023|ZAR|000005|1500000095|||||5||KAHTSY


......

34204 records



SET @totalRows=(SELECT COUNT(RowNum) FROM @csvTable)
SET @currentRowNum=2;


select  @totalRows;
34204


select  @currentRowNum;
2



SET @currentCSV=(SELECT csvString FROM @csvTable WHERE RowNum=@currentRowNum)

select  @currentCSV;



230000|20230504|1500000095|5/4/2023|"-24|075.61"|BWP|-510.40|0.00|BW08W01|0.000|||BW08|||1500000095|SK50|2023|ZAR|000004|1500000095|||||5||KAHTSY




SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS r,
NULLIF(REPLACE(REPLACE(VALUE,CHAR(13),''),CHAR(10),''),'') AS cellValue
FROM STRING_SPLIT(@currentCSV,'|')

SELECT ct.RowNum,
         cellValue = NULLIF(REPLACE(REPLACE(d.VALUE, CHAR(13), ''), CHAR(10), ''), '')
  FROM @csvTable AS ct
  CROSS APPLY STRING_SPLIT(ct.csvString, '|') AS d
  WHERE LEN(d.VALUE) > 1

r	cellValue
1	230000
2	20230504
3	1500000095
4	5/4/2023
5	"-24
6	075.61"
7	BWP
8	-510.40
9	0.00
10	BW08W01
11	0.000
12	NULL
13	NULL
14	BW08
15	NULL
16	NULL
17	1500000095
18	SK50
19	2023
20	ZAR
21	000004
22	1500000095
23	NULL
24	NULL
25	NULL
26	NULL
27	5
28	NULL
29	KAHTSY



SELECT * FROM ( 
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS r,
NULLIF(REPLACE(REPLACE(VALUE,CHAR(13),''),CHAR(10),''),'') AS cellValue
FROM STRING_SPLIT(@currentCSV,'|')) src
PIVOT(
MAX(cellValue) FOR r IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
                         [21],[22],[23],[24],[25],[26],[27],[28]  )) piv;

                
1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28
230000	20230504	1500000095	5/4/2023	"-24	075.61"	BWP	-510.40	0.00	BW08W01	0.000	NULL	NULL	BW08	NULL	NULL	1500000095	SK50	2023	ZAR	000004	1500000095	NULL	NULL	NULL	NULL	5	NULL