SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
ALTER PROCEDURE [FIN].[SP_ProcessNewFAGLL03_agg_temp]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    DELETE FROM FIN.[21_FAGLL03_agg_temp];

    -- Insert statements for procedure here
    INSERT INTO [FIN].[21_FAGLL03_agg_temp]
    SELECT 'EERR' AS Fuente,
           Version,
           [G/L Fiscal Year] AS AÑO,
           [Posting period] AS MES,
           Account,
           [Long Text] AS Account_Description,
           Denom1,
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
           '' AS Role_Category,
           0 AS Qty_Unit2,
           0 AS Dotacion,
           SUM([Amount in local currency]) AS [Amount in local currency],
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
           SUM([Amount in loc curr 2]) AS [Amount in loc curr 2],
           [R2A],
           [R3A],
           [R4A],
           '' AS [Employee subgroup],
           '' AS [Personnel area],
           '' AS [PA Text]
    FROM [FIN].[21_FAGLL03 FINAL]
    GROUP BY Version,
             [G/L Fiscal Year],
             [Posting period],
             Account,
             [Long Text],
             Denom1,
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
             [R3A],
             [R2A],
             [R4A]
    HAVING SUM([Amount in local currency]) <> 0;
END
GO


EXEC [FIN].[SP_ProcessNewFAGLL03_agg_temp]



CREATE VIEW [FIN].[PWBI_10_EERR]
as
select * from FIN.[21_FAGLL03_agg_temp]

select count(*) from FIN.[21_FAGLL03_agg_temp]

select * from FIN.[PWBI_10_EERR_test]