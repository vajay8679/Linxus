/****** Object:  StoredProcedure [FIN].[FIN.SP_ProcessNewDOTACTION_v1]    Script Date: 18-04-2024 21:16:25 ******/
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

-- 20_Crea TB26 KB24 Final

CREATE TABLE #MCP (
	Responsible1 VARCHAR(50), 
    Responsible2 VARCHAR(50), 
    Responsible3 VARCHAR(50), 
    Responsible4 VARCHAR(50), 
	Country VARCHAR(50),
	PCDescription VARCHAR(50),
    CCDescription VARCHAR(50),
    CompanyCode VARCHAR(50),
    Functionalarea VARCHAR(50),
	ProfitCenter VARCHAR(50),
    CostCenter VARCHAR(50),
	RowNum INT
)

INSERT INTO #MCP
	SELECT
    Responsible1, 
    Responsible2, 
    Responsible3, 
    Responsible4, 
	Country,
	PCDescription,
    CCDescription,
    CompanyCode
    Functionalarea,
	ProfitCenter,
    CostCenter,
    ROW_NUMBER() OVER (PARTITION BY [FIN].[MasterCostAndProfit].CostCenter ORDER BY (SELECT NULL)) AS RowNum
    FROM [FIN].[MasterCostAndProfit]

INSERT INTO FIN.[50_DOTACTION]
SELECT
    'R' + CAST(YEAR(GETDATE()) AS varchar(max)) AS Version,
    YEAR(GETDATE()) AS [G/L Fiscal Year],
    MONTH(GETDATE()) as [Posting period],
    'CTB' AS TYPE,
    1 AS LOAD,
    #MCP.ProfitCenter  as [Profit Center] 
    #MCP.PCDescription as [PC Description],
    #MCP.Country as [Country], 
    #MCP.CompanyCode as [Company Code], 
    FIN.[49_DOTACTION STAGING].[Cost Centre] as [Cost Center], 
    #MCP.CCDescription as [CC Description],
    #MCP.Responsible1 as [Responsible 1], 
    #MCP.Responsible2 as [Responsible 2], 
    #MCP.Responsible3 as [Responsible 3], 
    #MCP.Responsible4 as [Responsible 4], 
    #MCP.Functionalarea as [Functional area], 

    [FIN].[MaestroFunctionalArea].Description,  -- doubt
    [FIN].[MaestroFunctionalArea].Group,  -- doubt

    -- [FIN].[MaestroProducts].[GROUP], 
    FIN.[49_DOTACTION STAGING].[Employee Nr], 
    FIN.[49_DOTACTION STAGING].[Last Name], 
    FIN.[49_DOTACTION STAGING].[Known As] as Name,  -- doubt
    CONCAT(FIN.[49_DOTACTION STAGING].[Known as], ' ', FIN.[49_DOTACTION STAGING].[Last Name]) AS [Employee Name],
    -- FIN.[49_DOTACTION STAGING].Gender, 
    SUBSTRING(FIN.[49_DOTACTION STAGING].Gender, 1, 1) AS Gender,
    FIN.[49_DOTACTION STAGING].Position, 
    FIN.[49_DOTACTION STAGING].Position_TEXT, 
    FIN.[49_DOTACTION STAGING].[Role Category], 
    FIN.[49_DOTACTION STAGING].[Role Category Code],
    "Vigente" AS Status,
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
    #MCP ON 
        FIN.[49_DOTACTION STAGING].[Cost Centre] = #MCP.CostCenter -- AND #MCP.RowNum = 1
    LEFT JOIN [FIN].[MaestroFunctionalArea] ON  #MCP.Functionalarea = [FIN].[MaestroFunctionalArea].FunctionalArea

DROP TABLE #MCP


-- INSERT INTO FINAL

INSERT INTO [FIN].[51_DOTACTION_FINAL]
	SELECT * FROM FIN.[50_DOTACTION]

END
