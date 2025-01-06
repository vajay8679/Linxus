SELECT TOP (1000) [Account]
      ,[Assignment]
      ,[Document Number]
      ,[Document Date]
      ,[Amount in local currency]
      ,[Local Currency]
      ,[Amount in loc.curr.2]
      ,[Amount in doc. curr.]
      ,[Profit Center]
      ,[Quantity]
      ,[Text]
      ,[Base Unit of Measure]
      ,[Company Code]
      ,[Cost Center]
      ,[Cost Element]
      ,[Document Number G/L]
      ,[Functional Area]
      ,[G/L Fiscal Year]
      ,[General ledger currency]
      ,[General Ledger Item]
      ,[Invoice reference]
      ,[Material]
      ,[Order]
      ,[Partner Profit Ctr]
      ,[Plant]
      ,[Posting Period]
      ,[Reference]
      ,[User name]
      ,[Type]
      ,[FAGLL03StagingID]
  FROM [FIN].[19_FAGLL03 STAGING]



Account	Assignment	Document Number	Document Date	Amount in local currency	Local Currency	Amount in loc.curr.2	Amount in doc. curr.	Profit Center	Quantity	Text	Base Unit of Measure	Company Code	Cost Center	Cost Element	Document Number G/L	Functional Area	G/L Fiscal Year	General ledger currency	General Ledger Item	Invoice reference	Material	Order	Partner Profit Ctr	Plant	Posting Period	Reference	User name	Type	FAGLL03StagingID
230000	20220405	2000091328	2022-04-05	139753.80	ZAR	139753.80	0.00	ZA08W40	0.000	NULL	NULL	ZA08	NULL	NULL	2000091328	SK50	2022	USD	000005	2000091328	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	91
230000	20220405	2000091330	2022-04-05	148591.87	ZAR	148591.87	148591.87	ZA08W40	0.000	Gain & Losess Fabrica 1106577 05.04.2022	NULL	ZA08	NULL	NULL	2000091330	SK50	2022	ZAR	000001	2000091330	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	92
230000	20220405	2000091330	2022-04-05	31875.25	ZAR	31875.25	0.00	ZA08W40	0.000	NULL	NULL	ZA08	NULL	NULL	2000091330	SK50	2022	USD	000004	2000091330	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	93
230000	20220401	2000091574	2022-04-01	562.05	ZAR	562.05	0.00	ZA08E01	0.000	NULL	NULL	ZA08	NULL	NULL	2000091574	SK50	2022	USD	000004	2000091574	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	94
230000	20220419	2000092365	2022-04-19	63492.27	ZAR	63492.27	63492.27	ZA08E01	0.000	Gain & Losses Nitro Exlosives 19.04.2022 1106410	NULL	ZA08	NULL	NULL	2000092365	SK50	2022	ZAR	000001	2000092365	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	95
230000	20220419	2000092365	2022-04-19	107279.75	ZAR	107279.75	0.00	ZA08E01	0.000	NULL	NULL	ZA08	NULL	NULL	2000092365	SK50	2022	USD	000004	2000092365	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	96
230000	20220411	2000092834	2022-04-11	68629.39	ZAR	68629.39	0.00	ZA08W40	0.000	NULL	NULL	ZA08	NULL	NULL	2000092834	SK50	2022	USD	000004	2000092834	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	97
230000	20220414	2000094933	2022-04-14	64517.59	ZAR	64517.59	0.00	ZA08E01	0.000	NULL	NULL	ZA08	NULL	NULL	2000094933	SK50	2022	USD	000004	2000094933	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	98
230000	20220429	2000094934	2022-04-29	-114703.56	ZAR	-114703.56	0.00	ZA08W40	0.000	NULL	NULL	ZA08	NULL	NULL	2000094934	SK50	2022	USD	000004	2000094934	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	99
230000	20220405	2000091328	2022-04-05	139753.80	ZAR	139753.80	0.00	ZA08W40	0.000	NULL	NULL	ZA08	NULL	NULL	2000091328	SK50	2022	USD	5	2000091328	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	100
230000	20220405	2000091330	2022-04-05	148591.87	ZAR	148591.87	148591.87	ZA08W40	0.000	Gain & Losess Fabrica 1106577 05.04.2022	NULL	ZA08	NULL	NULL	2000091330	SK50	2022	ZAR	1	2000091330	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	101
230000	20220405	2000091328	2022-04-05	139753.80	ZAR	139753.80	0.00	ZA08W40	0.000	NULL	NULL	ZA08	NULL	NULL	2000091328	SK50	2022	USD	5	2000091328	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	102
230000	20220405	2000091330	2022-04-05	148591.87	ZAR	148591.87	148591.87	ZA08W40	0.000	Gain & Losess Fabrica 1106577 05.04.2022	NULL	ZA08	NULL	NULL	2000091330	SK50	2022	ZAR	1	2000091330	NULL	NULL	NULL	NULL	4	NULL	C-NCUBEA	NULL	103

  select count(*) from [FIN].[19_FAGLL03 STAGING]  
  
  o/p - 13 result

--------------------------------------------------------------------------------------------

SELECT TOP (1000) [Account]
      ,[Assignment]
      ,[Document Number]
      ,[Document Date]
      ,[Amount in local currency]
      ,[Local Currency]
      ,[Amount in loc.curr.2]
      ,[Amount in doc. curr.]
      ,[Profit Center]
      ,[Quantity]
      ,[Text]
      ,[Base Unit of Measure]
      ,[Company Code]
      ,[Cost Center]
      ,[Cost Element]
      ,[Document Number G/L]
      ,[Functional Area]
      ,[G/L Fiscal Year]
      ,[General ledger currency]
      ,[General Ledger Item]
      ,[Invoice reference]
      ,[Material]
      ,[Order]
      ,[Partner Profit Ctr]
      ,[Plant]
      ,[Posting Period]
      ,[Reference]
      ,[User name]
      ,[Type]
  FROM [FIN].[19_FAGLL03 STAGING_2024_02_05]


select count(*) from [FIN].[19_FAGLL03 STAGING_2024_02_05]

 o/p - 683446

-----------------------------------------------------------

SELECT TOP (1000) [Account]
      ,[Assignment]
      ,[Document Number]
      ,[Document Date]
      ,[Amount in local currency]
      ,[Local Currency]
      ,[Amount in loc.curr.2]
      ,[Amount in doc. curr.]
      ,[Profit Center]
      ,[Quantity]
      ,[Text]
      ,[Base Unit of Measure]
      ,[Company Code]
      ,[Cost Center]
      ,[Cost Element]
      ,[Document Number G/L]
      ,[Functional Area]
      ,[G/L Fiscal Year]
      ,[General ledger currency]
      ,[General Ledger Item]
      ,[Invoice reference]
      ,[Material]
      ,[Order]
      ,[Partner Profit Ctr]
      ,[Plant]
      ,[Posting Period]
      ,[Reference]
      ,[User name]
      ,[Type]
  FROM [FIN].[20_FAGLL03]


select count(*) from [FIN].[20_FAGLL03]

o/p - 2624176

-----------------------------------------------------------

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


select count(*) from [FIN].[21_FAGLL03 FINAL]

o/p - 5790319





-----------------------------

select * from @tempTable

tempTable Account	Assignment	Document Number	Document Date	Amount in local currency	Local Currency	Amount in loc.curr.2	Amount in doc. curr.	Profit Center	Quantity	Text	Base Unit of Measure	Company Code	Cost Center	Cost Element	Document Number G/L	Functional Area	G/L Fiscal Year	General ledger currency	General Ledger Item	Invoice reference	Material	Order	Partner Profit Ctr	Plant	Posting Period	Reference	User name	Type	FAGLL03StagingID
1  230000	20230504	1500000095	5/4/2023	"-24	075.61"	BWP	-510.40	0.00	BW08W01	0.000	NULL	NULL	BW08	NULL	NULL	1500000095	SK50	2023	ZAR	000004	1500000095	NULL	NULL	NULL	NULL	5	NULL
2  230000	20230504	1500000095	5/4/2023	0.02	BWP	0.03	0.00	BW08Z01	0.000	NULL	NULL	BW08	NULL	NULL	1500000095	SK50	2023	ZAR	000005	1500000095	NULL	NULL	NULL	NULL	5	NULL	KAHTSY
3  230000	20230504	1500000095	5/4/2023	0.00	BWP	-0.01	0.00	BW08Z01	0.000	NULL	NULL	BW08	NULL	NULL	1500000095	SK50	2023	ZAR	000006	1500000095	NULL	NULL	NULL	NULL	5	NULL	KAHTSY
