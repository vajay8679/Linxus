/****** Object:  StoredProcedure [FIN].[SP_ProcessNewDOTACTION_v1]    Script Date: 22-04-2024 16:04:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
ALTER PROCEDURE [FIN].[SP_ProcessNewDOTACTION_v1]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	DELETE FROM FIN.[50_DOTACTION]
	DELETE FROM FIN.[51_DOTACTION_FINAL]


INSERT INTO FIN.[50_DOTACTION]
SELECT
    'R' + CAST(YEAR(GETDATE()) AS varchar(max)) AS Version,
    YEAR(GETDATE()) AS [G/L Fiscal Year],
    MONTH(GETDATE()) as [Posting period],
    'CTB' AS TYPE,
    1 AS LOAD,
    [FIN].[MasterCostAndProfit].ProfitCenter,
    [FIN].[MasterCostAndProfit].PCDescription,
    [FIN].[MasterCostAndProfit].Country,
    [FIN].[MasterCostAndProfit].CompanyCode,
    FIN.[49_DOTACTION STAGING].[Cost Centre] as [Cost Center], 
    [FIN].[MasterCostAndProfit].CCDescription,
    [FIN].[MasterCostAndProfit].Responsible1,
    [FIN].[MasterCostAndProfit].Responsible2,
    [FIN].[MasterCostAndProfit].Responsible3,
    [FIN].[MasterCostAndProfit].Responsible4,
    [FIN].[MasterCostAndProfit].Functionalarea,
    [FIN].[MaestroFunctionalArea].Description,
    [FIN].[MaestroFunctionalArea].[Group],    
    FIN.[49_DOTACTION STAGING].[Employee Nr], 
    FIN.[49_DOTACTION STAGING].[Last Name], 
    FIN.[49_DOTACTION STAGING].[Known As] as Name, 
    CONCAT(FIN.[49_DOTACTION STAGING].[Known as], ' ', FIN.[49_DOTACTION STAGING].[Last Name]) AS [Employee Name],
    SUBSTRING(FIN.[49_DOTACTION STAGING].Gender, 1, 1) AS Gender,
    FIN.[49_DOTACTION STAGING].Position, 
    FIN.[49_DOTACTION STAGING].Position_TEXT, 
    FIN.[49_DOTACTION STAGING].[Role Category], 
    FIN.[49_DOTACTION STAGING].[Role Category Code],
    'Vigente' AS Status,
    1 AS Dotacion,
    0 AS Valor,
    NULL AS TEXT1,
    NULL AS USUARIO,
    FIN.[49_DOTACTION STAGING].[Employee subgroup], 
    FIN.[49_DOTACTION STAGING].[ID number], 
    FIN.[49_DOTACTION STAGING].Nationality,
    FIN.[49_DOTACTION STAGING].[Personnel area], 
    FIN.[49_DOTACTION STAGING].[PA Text],
    FIN.[49_DOTACTION STAGING].birdate, 
    FIN.[49_DOTACTION STAGING].[Joined Group], 
    FIN.[49_DOTACTION STAGING].Separation, 
    FIN.[49_DOTACTION STAGING].[Employment status]
FROM 
    FIN.[49_DOTACTION STAGING]
    LEFT JOIN 
    [FIN].[MasterCostAndProfit] ON 
        FIN.[49_DOTACTION STAGING].[Cost Centre] = [FIN].[MasterCostAndProfit].CostCenter
    LEFT JOIN [FIN].[MaestroFunctionalArea] ON  [FIN].[MasterCostAndProfit].Functionalarea = [FIN].[MaestroFunctionalArea].FunctionalArea



-- INSERT INTO FINAL

INSERT INTO [FIN].[51_DOTACTION_FINAL]
	SELECT * FROM FIN.[50_DOTACTION]

END

EXEC [FIN].[SP_ProcessNewDOTACTION_v1]