VIEW->PWBI_20_Report_Budget_Consolidated

 

SELECT        *

FROM            PWBI_10_EERR

UNION

SELECT        *

FROM            PWBI_11_RRHH

UNION

SELECT        *

FROM            PWBI_12_VENTAS

UNION

SELECT        *

FROM            PWBI_12_VENTAS_Adjusted_Cost_Sales

UNION

SELECT        *

FROM            PWBI_12_VENTAS_Gross_Margin

UNION

SELECT        *

FROM            PWBI_13_VENTAS_ConNegManPrice

UNION

SELECT        *

FROM            PWBI_14_VENTAS_Revenue

UNION

SELECT        *

FROM            PWBI_14_VENTAS_Transportation_Recov

UNION

SELECT        *

FROM            PWBI_15_VENTAS_Stock_Value

UNION

SELECT        *

FROM            PWBI_16_VENTAS_Sundry_Services

UNION

SELECT        *

FROM            PWBI_17_VENTAS_Freight

UNION

SELECT        *

FROM            PWBI_17_VENTAS_Road_Freight

UNION

SELECT        *

FROM            PWBI_18_VENTAS_Intern_Road_Freight

UNION

SELECT        *

FROM            PWBI_19_VENTAS_Freight_Adjustment

UNION

SELECT        *

FROM            PWBI_19_VENTAS_Storage_Handling

UNION

SELECT        *

FROM            PWBI_19_VENTAS_Storage_Warehouse

UNION

SELECT        *

FROM            PWBI_19_VENTAS_Total_Freight

 

 

VIEW->PWBI_10_EERR

SELECT        'EERR' AS Fuente, Version, [G/L Fiscal Year] AS AÑO, [Posting period] AS MES, Account, [Long Text] AS Account_Description, Denom1, [Profit Center], [PC Description], [Profit Center] AS [Profit Center2],

                         [PC Description] AS [PC Description2], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area], [Group] AS Area_Description, '' AS Group_Material,

                         '' AS Material_Description, '' AS Customer, '' AS Customer_Description, '' AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Amount in local currency]) AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS Freight_Adjustment, 0 AS Total_Freight, '' AS Group_Material2, '' AS Material_Description2, '' AS MS_Customer_Name,

                         SUM([Amount in loc curr 2]) AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[30_Base_EERR_SASOL]

GROUP BY Version, [G/L Fiscal Year], [Posting period], Account, [Long Text], Denom1, [Profit Center], [PC Description], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area],

                         [Group], [Responsible 3A], [Responsible 2A], [Responsible 4A]

HAVING        (SUM([Amount in local currency]) <> 0)

 

VIEW->PWBI_11_RRHH

SELECT        'STAFF' AS Fuente, Version, [G/L Fiscal Year] AS AÑO, [Posting period] AS MES, '' AS Account, '' AS Account_Description, '' AS Denom1, [Profit Center], [PC Description], [Profit Center] AS [Profit Center2],

                         [PC Description] AS [PC Description2], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area], [Group] AS Area_Description, '' AS Group_Material,

                         '' AS Material_Description, '' AS Customer, '' AS Customer_Description, '' AS Type_of_Business2, [Role Category], 0 AS Qty_Unit2, SUM(Dotacion) AS Dotacion, 0 AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                         0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS Freight_Adjustment, 0 AS Total_Freight, '' AS Group_Material2, '' AS Material_Description2, '' AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A],

                         [Responsible 4A], [Employee subgroup], [Personnel area], [PA Text]

FROM            dbo.[35_Base_RRHH_SASOL]

GROUP BY Version, [G/L Fiscal Year], [Posting period], [Profit Center], [PC Description], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area], [Group], [Role Category],

                         [Responsible 2A], [Responsible 3A], [Responsible 4A], [Employee subgroup], [Personnel area], [PA Text]

HAVING        (SUM(Dotacion) <> 0)

 

VIEW->PWBI_12_VENTAS

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, '' AS Account_Description, '' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description], [Responsible 1],

                         [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, SUM([Qty Unit2]) AS Qty_Unit2, 0 AS Dotacion, 0 AS [Amount in local currency], 0 AS [Con/Neg/Man Price], 0 AS Revenue,

                         0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Qty Unit2]) <> 0)

 

VIEW->PWBI_12_VENTAS_Adjusted_Cost_Sales

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Adjusted Cost of Sales' AS Account_Description, 'Adjusted Cost of Sales' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, (SUM([Stock Value]) + SUM(Freight)) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], (SUM([Stock Value]) + SUM(Freight)) * - 1 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Stock Value]) + SUM(Freight) <> 0)

 

VIEW->PWBI_12_VENTAS_Gross_Margin

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Gross Margin' AS Account_Description, 'Gross Margin' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM(Revenue) - (SUM([Stock Value]) + SUM(Freight)) AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], SUM(Revenue) - (SUM([Stock Value]) + SUM(Freight)) AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM(Revenue) - (SUM([Stock Value]) + SUM(Freight)) <> 0)

 

VIEW->PWBI_13_VENTAS_ConNegManPrice

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Con/Neg/Man Price' AS Account_Description, 'Con/Neg/Man Price' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Con/Neg/Man Price]) AS [Amount in local currency], SUM([Con/Neg/Man Price])

                         AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Con/Neg/Man Price]) <> 0)

 

VIEW->PWBI_14_VENTAS_Revenue

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Revenue' AS Account_Description, 'Revenue' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description],

                         [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM(Revenue) AS [Amount in local currency], 0 AS [Con/Neg/Man Price], SUM(Revenue)

                         AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM(Revenue) <> 0)

 

VIEW->PWBI_14_VENTAS_Transportation_Recov

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Transportation Recov' AS Account_Description, 'Transportation Recov' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Transportation Recov]) AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                          0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, SUM([Transportation Recov])

                         AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Transportation Recov]) <> 0)

 

VIEW->PWBI_15_VENTAS_Stock_Value

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Stock Value' AS Account_Description, 'Stock Value' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description],

                         [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Stock Value]) * - 1 AS [Amount in local currency], 0 AS [Con/Neg/Man Price], 0 AS Revenue,

                         SUM([Stock Value]) * - 1 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov],

                         0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Stock Value]) <> 0)

 

VIEW->PWBI_16_VENTAS_Sundry_Services

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Sundry & Services' AS Account_Description, 'Sundry & Services' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Sundry & Services]) AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                         0 AS Revenue, 0 AS [Stock Value], SUM([Sundry & Services]) AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Sundry & Services]) <> 0)

 

VIEW->PWBI_17_VENTAS_Freight

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Freight' AS Account_Description, 'Freight' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description],

                         [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM(Freight) * - 1 AS [Amount in local currency], 0 AS [Con/Neg/Man Price], 0 AS Revenue,

                         0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], SUM(Freight) * - 1 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM(Freight) <> 0)

 

VIEW->PWBI_17_VENTAS_Road_Freight

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Road Freight' AS Account_Description, 'Road Freight' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Road Freight]) * - 1 AS [Amount in local currency], 0 AS [Con/Neg/Man Price],

                         0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], SUM([Road Freight]) * - 1 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov],

                          0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Road Freight]) <> 0)

 

VIEW->PWBI_18_VENTAS_Intern_Road_Freight

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Intern Road Frght' AS Account_Description, 'Intern Road Frght' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Intern Road Frght]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], SUM([Intern Road Frght]) * - 1 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse],

                         0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Intern Road Frght]) <> 0)

 

VIEW->PWBI_19_VENTAS_Freight_Adjustment

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Freight Adjustment' AS Account_Description, 'Freight Adjustment' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Freight Adjustment]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], SUM([Freight Adjustment]) * - 1 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Freight Adjustment]) <> 0)

 

VIEW->PWBI_19_VENTAS_Storage_Handling

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Storage and Handling' AS Account_Description, 'Storage and Handling' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Storage and Handling]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], SUM([Storage and Handling]) * - 1 AS [Storage and Handling], 0 AS [Storage/Warehouse],

                         0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Storage and Handling]) <> 0)

 

VIEW->PWBI_19_VENTAS_Storage_Warehouse

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Storage/Warehouse' AS Account_Description, 'Storage/Warehouse' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, SUM([Storage/Warehouse]) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], SUM([Storage/Warehouse]) * - 1 AS [Storage/Warehouse],

                         0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2,

                         [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Storage/Warehouse]) <> 0)

 

VIEW->PWBI_19_VENTAS_Total_Freight

SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Total Freight' AS Account_Description, 'Total Freight' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, (SUM([Road Freight]) + SUM([Freight Adjustment])) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], 0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], (SUM([Road Freight]) + SUM([Freight Adjustment])) * - 1 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM            dbo.[31_Base_Ventas_SASOL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],

                         Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        ((SUM([Road Freight]) + SUM([Freight Adjustment])) * - 1 <> 0)