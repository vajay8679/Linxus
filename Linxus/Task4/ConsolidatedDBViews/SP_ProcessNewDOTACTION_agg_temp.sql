SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [FIN].[SP_ProcessNewDOTACTION_agg_temp]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    DELETE FROM FIN.[51_DOTACTION_FINAL_agg_temp];

    -- Insert statements for procedure here
    INSERT INTO [FIN].[51_DOTACTION_FINAL_agg_temp]
    SELECT 'STAFF' AS Fuente,
           Version,
           [G/L Fiscal Year] AS AÑO,
           [Posting period] AS MES,
           '' AS Account,
           '' AS Account_Description,
           '' AS Denom1,
           [Profit Center],
           [PC Description],
           [Profit Center] AS [Profit Center2],
           [PC Description] AS [PC Description2],
           [Cost Center],
           [CC Description],
           [Responsible 1],
           [Responsible 2],
           [Responsible 3],
           [Responsible 4],
           [Functional Area],
           [Group] AS Area_Description,
           '' AS Group_Material,
           '' AS Material_Description,
           '' AS Customer,
           '' AS Customer_Description,
           '' AS Type_of_Business2,
           [Role Category],
           0 AS Qty_Unit2,
           SUM(Dotacion) AS Dotacion,
           0 AS [Amount in local currency],
           0 AS [Con/Neg/Man Price],
           0 AS Revenue,
           0 AS [Stock Value],
           0 AS [Sundry & Services],
           0 AS [Road Freight],
           0 AS [Intern Road Frght],
           0 AS [Storage and Handling],
           0 AS [Storage/Warehouse],
           0 AS Freight,
           0 AS [Transportation Recov],
           0 AS [Gross Margin],
           0 AS [Adjusted Cost of Sales],
           0 AS Freight_Adjustment,
           0 AS Total_Freight,
           '' AS Group_Material2,
           '' AS Material_Description2,
           '' AS MS_Customer_Name,
           0 AS [Amount in loc curr 2],
           '' AS [Responsible 2A],
           '' AS [Responsible 3A],
           '' AS [Responsible 4A],
           [Employee subgroup],
           [Personnel area],
           [PA Text]
    FROM [FIN].[51_DOTACTION_FINAL]
    GROUP BY Version,
             [G/L Fiscal Year],
             [Posting period],
             [Profit Center],
             [PC Description],
             [Cost Center],
             [CC Description],
             [Responsible 1],
             [Responsible 2],
             [Responsible 3],
             [Responsible 4],
             [Functional Area],
             [Group],
             [Role Category],
             [Employee subgroup],
             [Personnel area],
             [PA Text]
    HAVING SUM(Dotacion) <> 0;
END
GO



EXEC [FIN].[SP_ProcessNewDOTACTION_agg_temp]


CREATE VIEW [FIN].[PWBI_11_RRHH]
as
select * from FIN.[51_DOTACTION_FINAL_agg_temp]

select count(*) from FIN.[51_DOTACTION_FINAL_agg_temp]

select top 5 * FROM [FIN].[51_DOTACTION_FINAL]
select top 5 * from FIN.[51_DOTACTION_FINAL_agg_temp]
select * from  [FIN].[PWBI_11_RRHH_test]