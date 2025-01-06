--1. view - PWBI_10_EERR
CREATE VIEW [FIN].[PWBI_10_EERR]
as
select * from FIN.[21_FAGLL03_agg_temp]


--2. view - PWBI_11_RRHH
CREATE VIEW [FIN].[PWBI_11_RRHH]
as
select * from FIN.[51_DOTACTION_FINAL_agg_temp]


--3. view - PWBI_12_VENTAS
CREATE VIEW [FIN].[PWBI_12_VENTAS]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = '' 
AND Denom1 = '' 
AND Qty_Unit2 <> 0 


--4. VIEW->PWBI_12_VENTAS_Adjusted_Cost_Sales
CREATE VIEW [FIN].[PWBI_12_VENTAS_Adjusted_Cost_Sales]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Adjusted Cost of Sales' 
AND Denom1 = 'Adjusted Cost of Sales'
--AND [Adjusted Cost of Sales] <> 0 


-- 5. VIEW->PWBI_12_VENTAS_Gross_Margin
CREATE VIEW [FIN].[PWBI_12_VENTAS_Gross_Margin]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Gross Margin' 
AND Denom1 = 'Gross Margin'
AND ([Amount in local currency] <> 0)


--6. VIEW->PWBI_13_VENTAS_ConNegManPrice
CREATE VIEW [FIN].[PWBI_13_VENTAS_ConNegManPrice]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Con/Neg/Man Price' 
AND Denom1 = 'Con/Neg/Man Price'
AND ([Con/Neg/Man Price] <> 0)


-- 7. VIEW->PWBI_14_VENTAS_Revenue
CREATE VIEW [FIN].[PWBI_14_VENTAS_Revenue]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Revenue' 
AND Denom1 = 'Revenue'
AND (Revenue <> 0)


-- 8. VIEW->PWBI_14_VENTAS_Transportation_Recov
CREATE VIEW [FIN].[PWBI_14_VENTAS_Transportation_Recov]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Transportation Recov' 
AND Denom1 = 'Transportation Recov'
AND ([Transportation Recov] <> 0)



--9. VIEW->PWBI_15_VENTAS_Stock_Value
CREATE VIEW [FIN].[PWBI_15_VENTAS_Stock_Value]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Stock Value' 
AND Denom1 = 'Stock Value'


-- 10. VIEW->PWBI_16_VENTAS_Sundry_Services
CREATE VIEW [FIN].[PWBI_16_VENTAS_Sundry_Services]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Sundry & Services' 
AND Denom1 = 'Sundry & Services'
AND ([Sundry & Services] <> 0)


--11. VIEW->PWBI_17_VENTAS_Freight
CREATE VIEW [FIN].[PWBI_17_VENTAS_Freight]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Freight' 
AND Denom1 = 'Freight'


-- 12. VIEW->PWBI_17_VENTAS_Road_Freight
CREATE VIEW [FIN].[PWBI_17_VENTAS_Road_Freight]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Road Freight' 
AND Denom1 = 'Road Freight'


--13. VIEW->PWBI_18_VENTAS_Intern_Road_Freight
CREATE VIEW [FIN].[PWBI_18_VENTAS_Intern_Road_Freight]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Intern Road Frght' 
AND Denom1 = 'Intern Road Frght'


--14. VIEW->PWBI_19_VENTAS_Freight_Adjustment
CREATE VIEW [FIN].[PWBI_19_VENTAS_Freight_Adjustment]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Freight Adjustment' 
AND Denom1 = 'Freight Adjustment'


--15. VIEW->PWBI_19_VENTAS_Storage_Handling
CREATE VIEW [FIN].[PWBI_19_VENTAS_Storage_Handling]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Storage and Handling' 
AND Denom1 = 'Storage and Handling'


--16. VIEW->PWBI_19_VENTAS_Storage_Warehouse
CREATE VIEW [FIN].[PWBI_19_VENTAS_Storage_Warehouse]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Storage/Warehouse' 
AND Denom1 = 'Storage/Warehouse'


--17. VIEW->PWBI_19_VENTAS_Total_Freight
CREATE VIEW [FIN].[PWBI_19_VENTAS_Total_Freight]
as
SELECT * 
FROM FIN.[26_KE24_FINAL_agg_temp] 
WHERE Account_Description = 'Total Freight' 
AND Denom1 = 'Total Freight'


--18. VIEW->PWBI_20_Report_Budget_Consolidated

CREATE VIEW [FIN].[PWBI_20_Report_Budget_Consolidated]
as
SELECT        *

FROM            [FIN].PWBI_10_EERR

UNION

SELECT        *

FROM            [FIN].PWBI_11_RRHH

UNION

SELECT        *

FROM            [FIN].PWBI_12_VENTAS

UNION

SELECT        *

FROM            [FIN].PWBI_12_VENTAS_Adjusted_Cost_Sales

UNION

SELECT        *

FROM            [FIN].PWBI_12_VENTAS_Gross_Margin

UNION

SELECT        *

FROM            [FIN].PWBI_13_VENTAS_ConNegManPrice

UNION

SELECT        *

FROM            [FIN].PWBI_14_VENTAS_Revenue

UNION

SELECT        *

FROM            [FIN].PWBI_14_VENTAS_Transportation_Recov

UNION

SELECT        *

FROM            [FIN].PWBI_15_VENTAS_Stock_Value

UNION

SELECT        *

FROM            [FIN].PWBI_16_VENTAS_Sundry_Services

UNION

SELECT        *

FROM            [FIN].PWBI_17_VENTAS_Freight

UNION

SELECT        *

FROM            [FIN].PWBI_17_VENTAS_Road_Freight

UNION

SELECT        *

FROM            [FIN].PWBI_18_VENTAS_Intern_Road_Freight

UNION

SELECT        *

FROM            [FIN].PWBI_19_VENTAS_Freight_Adjustment

UNION

SELECT        *

FROM            [FIN].PWBI_19_VENTAS_Storage_Handling

UNION

SELECT        *

FROM            [FIN].PWBI_19_VENTAS_Storage_Warehouse

UNION

SELECT        *

FROM            [FIN].PWBI_19_VENTAS_Total_Freight