-- 1. VIEW->PWBI_10_EERR
CREATE VIEW [FIN].[PWBI_10_EERR] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
    SELECT        'EERR' AS Fuente, Version, [G/L Fiscal Year] AS AÑO, [Posting period] AS MES, Account, [Long Text] AS Account_Description, Denom1, [Profit Center], [PC Description], [Profit Center] AS [Profit Center2],

                         [PC Description] AS [PC Description2], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area], [Group] AS Area_Description, '' AS Group_Material,

                         '' AS Material_Description, '' AS Customer, '' AS Customer_Description, '' AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Amount in local currency]) AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS Freight_Adjustment, 0 AS Total_Freight, '' AS Group_Material2, '' AS Material_Description2, '' AS MS_Customer_Name,

                         SUM([Amount in loc curr 2]) AS [Amount in loc curr 2], [R2A], [R3A], [R4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[21_FAGLL03 FINAL]

GROUP BY Version, [G/L Fiscal Year], [Posting period], Account, [Long Text], Denom1, [Profit Center], [PC Description], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area],[Group], [R3A], [R2A], [R4A]

HAVING        (SUM([Amount in local currency]) <> 0)

----------------------------

-- 2. VIEW->PWBI_11_RRHH

CREATE VIEW [FIN].[PWBI_11_RRHH] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'STAFF' AS Fuente, Version, [G/L Fiscal Year] AS AÑO, [Posting period] AS MES, '' AS Account, '' AS Account_Description, '' AS Denom1, [Profit Center], [PC Description], [Profit Center] AS [Profit Center2],

                         [PC Description] AS [PC Description2], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area], [Group] AS Area_Description, '' AS Group_Material,

                         '' AS Material_Description, '' AS Customer, '' AS Customer_Description, '' AS Type_of_Business2, [Role Category], 0 AS Qty_Unit2, SUM(Dotacion) AS Dotacion, 0 AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                         0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS Freight_Adjustment, 0 AS Total_Freight, '' AS Group_Material2, '' AS Material_Description2, '' AS MS_Customer_Name, 0 AS [Amount in loc curr 2],'' AS [Responsible 2A],'' AS [Responsible 3A],
                         '' AS [Responsible 4A], [Employee subgroup], [Personnel area], [PA Text]

FROM   [FIN].[51_DOTACTION_FINAL]

GROUP BY Version, [G/L Fiscal Year], [Posting period], [Profit Center], [PC Description], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area], [Group], [Role Category], [Employee subgroup], [Personnel area], [PA Text]

HAVING        (SUM(Dotacion) <> 0)



--Note : [Responsible 2A], [Responsible 3A], [Responsible 4A] this columns were not present in table [FIN].[51_DOTACTION_FINAL]

--3. VIEW->PWBI_12_VENTAS

CREATE VIEW [FIN].[PWBI_12_VENTAS] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, '' AS Account_Description, '' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description], [Responsible 1],

                         [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, SUM([Qty Unit2]) AS Qty_Unit2, 0 AS Dotacion, 0 AS [Amount in local currency], 0 AS [Con/Neg/Man Price], 0 AS Revenue,

                         0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4], Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Qty Unit2]) <> 0)



--4. VIEW->PWBI_12_VENTAS_Adjusted_Cost_Sales

CREATE VIEW [FIN].[PWBI_12_VENTAS_Adjusted_Cost_Sales] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Adjusted Cost of Sales' AS Account_Description, 'Adjusted Cost of Sales' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, (SUM([Stock Value]) + SUM(Freight)) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], (SUM([Stock Value]) + SUM(Freight)) * - 1 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM        [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Stock Value]) + SUM(Freight) <> 0)



-- 5. VIEW->PWBI_12_VENTAS_Gross_Margin

CREATE VIEW [FIN].[PWBI_12_VENTAS_Gross_Margin] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Gross Margin' AS Account_Description, 'Gross Margin' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM(Revenue) - (SUM([Stock Value]) + SUM(Freight)) AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], SUM(Revenue) - (SUM([Stock Value]) + SUM(Freight)) AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM           [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM(Revenue) - (SUM([Stock Value]) + SUM(Freight)) <> 0)

 

--6. VIEW->PWBI_13_VENTAS_ConNegManPrice

CREATE VIEW [FIN].[PWBI_13_VENTAS_ConNegManPrice] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Con/Neg/Man Price' AS Account_Description, 'Con/Neg/Man Price' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Con/Neg/Man Price]) AS [Amount in local currency], SUM([Con/Neg/Man Price])

                         AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM             [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Con/Neg/Man Price]) <> 0)

  



-- 7. VIEW->PWBI_14_VENTAS_Revenue

CREATE VIEW [FIN].[PWBI_14_VENTAS_Revenue] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Revenue' AS Account_Description, 'Revenue' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description],

                         [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM(Revenue) AS [Amount in local currency], 0 AS [Con/Neg/Man Price], SUM(Revenue)

                         AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM           [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM(Revenue) <> 0)



-- 8. VIEW->PWBI_14_VENTAS_Transportation_Recov

CREATE VIEW [FIN].[PWBI_14_VENTAS_Transportation_Recov] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Transportation Recov' AS Account_Description, 'Transportation Recov' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Transportation Recov]) AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                          0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, SUM([Transportation Recov])

                         AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Transportation Recov]) <> 0)





--9. VIEW->PWBI_15_VENTAS_Stock_Value

CREATE VIEW [FIN].[PWBI_15_VENTAS_Stock_Value] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Stock Value' AS Account_Description, 'Stock Value' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description],

                         [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Stock Value]) * - 1 AS [Amount in local currency], 0 AS [Con/Neg/Man Price], 0 AS Revenue,

                         SUM([Stock Value]) * - 1 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov],

                         0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM             [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Stock Value]) <> 0)


-- 10. VIEW->PWBI_16_VENTAS_Sundry_Services

CREATE VIEW [FIN].[PWBI_16_VENTAS_Sundry_Services] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Sundry & Services' AS Account_Description, 'Sundry & Services' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Sundry & Services]) AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                         0 AS Revenue, 0 AS [Stock Value], SUM([Sundry & Services]) AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Sundry & Services]) <> 0)



--11. VIEW->PWBI_17_VENTAS_Freight

CREATE VIEW [FIN].[PWBI_17_VENTAS_Freight] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Freight' AS Account_Description, 'Freight' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description],

                         [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM(Freight) * - 1 AS [Amount in local currency], 0 AS [Con/Neg/Man Price], 0 AS Revenue,

                         0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], SUM(Freight) * - 1 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM             [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM(Freight) <> 0)



-- 12. VIEW->PWBI_17_VENTAS_Road_Freight

CREATE VIEW [FIN].[PWBI_17_VENTAS_Road_Freight] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Road Freight' AS Account_Description, 'Road Freight' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Road Freight]) * - 1 AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                         0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], SUM([Road Freight]) * - 1 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov],

                          0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Road Freight]) <> 0)


--13. VIEW->PWBI_18_VENTAS_Intern_Road_Freight

CREATE VIEW [FIN].[PWBI_18_VENTAS_Intern_Road_Freight] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Intern Road Frght' AS Account_Description, 'Intern Road Frght' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Intern Road Frght]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], SUM([Intern Road Frght]) * - 1 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse],

                         0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM           [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Intern Road Frght]) <> 0)



--14. VIEW->PWBI_19_VENTAS_Freight_Adjustment

CREATE VIEW [FIN].[PWBI_19_VENTAS_Freight_Adjustment] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Freight Adjustment' AS Account_Description, 'Freight Adjustment' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Freight Adjustment]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], SUM([Freight Adjustment]) * - 1 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM             [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Freight Adjustment]) <> 0)



--15. VIEW->PWBI_19_VENTAS_Storage_Handling


CREATE VIEW [FIN].[PWBI_19_VENTAS_Storage_Handling] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Storage and Handling' AS Account_Description, 'Storage and Handling' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Storage and Handling]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], SUM([Storage and Handling]) * - 1 AS [Storage and Handling], 0 AS [Storage/Warehouse],

                         0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Storage and Handling]) <> 0)




--16. VIEW->PWBI_19_VENTAS_Storage_Warehouse

CREATE VIEW [FIN].[PWBI_19_VENTAS_Storage_Warehouse] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Storage/Warehouse' AS Account_Description, 'Storage/Warehouse' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Storage/Warehouse]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], SUM([Storage/Warehouse]) * - 1 AS [Storage/Warehouse],

                         0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Storage/Warehouse]) <> 0)







--17. VIEW->PWBI_19_VENTAS_Total_Freight

CREATE VIEW [FIN].[PWBI_19_VENTAS_Total_Freight] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
        Denom1,
        [Profit Center],
        [PC Description],
        [Profit Center2],
        [PC Description2],
        [Cost Center],
        [CC Description],
        [Responsible 1],
        [Responsible 2],
        [Responsible 3],
        [Responsible 4],
        [Functional Area],
        Area_Description,
        Group_Material,
        Material_Description,
        Customer,
        Customer_Description,
        Type_of_Business2,
        Role_Category,
        Qty_Unit2,
        Dotacion,
        [Amount in local currency],
        [Con/Neg/Man Price],
        Revenue,
        [Stock Value],
        [Sundry & Services],
        [Road Freight],
        [Intern Road Frght],
        [Storage and Handling],
        [Storage/Warehouse],
        Freight,
        [Transportation Recov],
        [Gross Margin],
        [Adjusted Cost of Sales],
        Freight_Adjustment,
        Total_Freight,
        Group_Material2,
        Material_Description2,
        MS_Customer_Name,
        [Amount in loc curr 2],
        [Responsible 2A], 
        [Responsible 3A], 
        [Responsible 4A],
        [Employee subgroup],
        [Personnel area],
        [PA Text]
)
AS 
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Total Freight' AS Account_Description, 'Total Freight' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, (SUM([Road Freight]) + SUM([Freight Adjustment])) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], (SUM([Road Freight]) + SUM([Freight Adjustment])) * - 1 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM             [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        ((SUM([Road Freight]) + SUM([Freight Adjustment])) * - 1 <> 0)





-- -----------------------------------------------
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