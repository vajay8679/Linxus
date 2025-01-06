SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [FIN].[SP_ProcessNewKE24_agg_temp]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    DELETE FROM FIN.[26_KE24_FINAL_agg_temp];

    -- Insert statements for procedure here
    INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
    SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, '' AS Account_Description, '' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center], '' AS [CC Description], [Responsible 1],

                         [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description, Customer,

                         Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, SUM([Qty Unit2]) AS Qty_Unit2, 0 AS Dotacion, 0 AS [Amount in local currency], 0 AS [Con/Neg/Man Price], 0 AS Revenue,

                         0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight, 0 AS [Transportation Recov], 0 AS [Gross Margin],

                         0 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2, [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name,

                         0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup], '' AS [Personnel area], '' AS [PA Text]

FROM            [FIN].[26_KE24_FINAL]

GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4], Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Qty Unit2]) <> 0)


   
   
   
INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
SELECT        'SALES' AS Fuente, Version, AÑO, MES, '' AS Account, 'Adjusted Cost of Sales' AS Account_Description, 'Adjusted Cost of Sales' AS Denom1, [Profit Center], [PC Description], [Profit Center2], [PC Description2], '' AS [Cost Center],

                         '' AS [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], 'SK20' AS [Functional Area], 'Sale Cost' AS Area_Description, [Group] AS Group_Material, [Material Description] AS Material_Description,

                         Customer, Name AS Customer_Description, [Type of Business2] AS Type_of_Business2, '' AS Role_Category, 0 AS Qty_Unit2, 0 AS Dotacion, (SUM([Stock Value]) + SUM(Freight)) * - 1 AS [Amount in local currency],

                         0 AS [Con/Neg/Man Price], 0 AS Revenue, 0 AS [Stock Value], 0 AS [Sundry & Services], 0 AS [Road Freight], 0 AS [Intern Road Frght], 0 AS [Storage and Handling], 0 AS [Storage/Warehouse], 0 AS Freight,

                         0 AS [Transportation Recov], 0 AS [Gross Margin], (SUM([Stock Value]) + SUM(Freight)) * - 1 AS [Adjusted Cost of Sales], 0 AS [Freight Adjustment], 0 AS Total_Freight, Group2 AS Group_Material2,

                         [Material Description2] AS Material_Description2, [M&S Customer Name] AS MS_Customer_Name, 0 AS [Amount in loc curr 2], [Responsible 2A], [Responsible 3A], [Responsible 4A], '' AS [Employee subgroup],

                         '' AS [Personnel area], '' AS [PA Text]

FROM        [FIN].[26_KE24_FINAL]
GROUP BY Version, AÑO, MES, [Profit Center], [PC Description], [Profit Center2], [PC Description2], [Responsible 1], [Group], [Material Description], Customer, Name, [Type of Business2], [Responsible 2], [Responsible 3], [Responsible 4],Group2, [Material Description2], [M&S Customer Name], [Responsible 2A], [Responsible 3A], [Responsible 4A]

HAVING        (SUM([Stock Value]) + SUM(Freight) <> 0)




INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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





INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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




INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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





INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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






INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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







INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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






INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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






INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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



INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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





INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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





INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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




INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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




INSERT INTO [FIN].[26_KE24_FINAL_agg_temp]
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


END
GO







EXEC [FIN].[SP_ProcessNewKE24_agg_temp]

select count(*) from FIN.[26_KE24_FINAL_agg_temp]
select top 5 * from FIN.[26_KE24_FINAL_agg_temp]

CREATE VIEW [FIN].[PWBI_11_RRHH_test]
as
select * from FIN.[26_KE24_FINAL_agg_temp]


select top 5 * FROM [FIN].[51_DOTACTION_FINAL]
select * from  [FIN].[PWBI_11_RRHH_test]