/****** Object:  StoredProcedure [FIN].[SP_ProcessNewFAGLL03_v3]    Script Date: 25-04-2024 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
ALTER PROCEDURE [FIN].[SP_ProcessNewFAGLL03_v3]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	DECLARE @fagll03count int = 0

	DELETE FROM FIN.[20_FAGLL03]

	INSERT INTO FIN.[20_FAGLL03]
		SELECT * FROM FIN.[19_FAGLL03 STAGING]

	CREATE TABLE #DistinctCombinations (
		[G/L Fiscal Year] INT,
		[Posting Period] INT
	)

	INSERT INTO #DistinctCombinations ([G/L Fiscal Year], [Posting Period])
	SELECT DISTINCT [G/L Fiscal Year], [Posting Period]
	FROM FIN.[19_FAGLL03 STAGING]

	DECLARE @postingPeriod INT
	DECLARE @fiscalYear INT

	WHILE EXISTS (SELECT 1 FROM #DistinctCombinations)
	BEGIN
		
		SELECT TOP 1 @postingPeriod = [Posting Period], @fiscalYear = [G/L Fiscal Year]
		FROM #DistinctCombinations

		DELETE FROM FIN.[21_FAGLL03 FINAL]
		WHERE [Posting period] = @postingPeriod AND [G/L Fiscal Year] = @fiscalYear

		DELETE FROM #DistinctCombinations
		WHERE [Posting Period] = @postingPeriod AND [G/L Fiscal Year] = @fiscalYear
	END

	DROP TABLE #DistinctCombinations
	
	SET @fagll03count = (SELECT COUNT(*) FROM [FIN].[20_FAGLL03])

	PRINT 'FAGLL03 Count | Intial : '+CAST(@fagll03count AS varchar(max))

--This stored procedure replicates the Access Macro: 06_Generate File EERR

	--The following steps are skipped as these are access specific processes where information is cross checked directly with the SASOL db
	-- 00_0_Elimina TB01 LOAD
	-- 00_1_Crea TB01 LOAD
	-- 00_2_Rescata LOAD SQL
	-- 00_3_Incrementa en uno LOAD
	-- 03_0_Elimina TB11 Documents
	-- 03_1_Crea TB11 Documents
	-- 03_2_Identifica Documentos Ya Procesados
	-- 04_Elimina TB20 FAGLL03 Documentos Ya Procesados
	-- 06_Incorpora CTB a Type

	UPDATE [FIN].[20_FAGLL03] SET [Type] = 'CTB';

	-- 07_Incorpora SK21 ZA08Z01 NULL

	UPDATE [FIN].[20_FAGLL03] SET [20_FAGLL03].[Functional Area] = 'SK21'
	WHERE ((([FIN].[20_FAGLL03].[Functional Area]) Is Null) AND (([20_FAGLL03].[Profit Center])='ZA08Z01'));



	-- 08_Valida TB12 Profit Ceco Center

	DROP TABLE IF EXISTS #Corridge_Profit;
	CREATE TABLE #Corridge_Profit
	(
	[Profit Center] varchar(max),
	[Cost Center] varchar(max),
	[Profit_OK] varchar(max),
	[OK] varchar(max)
	);

	INSERT INTO #Corridge_Profit
		SELECT [Profit Center],[Cost Center],LEFT([Cost Center],7) AS Profit_OK, 'SI' AS OK
		FROM [FIN].[20_FAGLL03]
		GROUP BY [20_FAGLL03].[Profit Center], [20_FAGLL03].[Cost Center], Left([Cost Center],7)
		HAVING ((([20_FAGLL03].[Cost Center])<>'' And ([20_FAGLL03].[Cost Center]) Is Not Null));

	DECLARE @corridgeProfitCount int = 0

		SET @corridgeProfitCount = (SELECT COUNT(*) from #Corridge_Profit WHERE [OK] = 'SI')

		PRINT 'Corridge profit count: '+ CAST(@corridgeProfitCount AS varchar(max))

	-- 09_Valida Profit Center Erroneos

	UPDATE #Corridge_Profit SET [OK] = 'NO'
		WHERE [Profit Center]<>[Profit_OK];

		SET @corridgeProfitCount = (SELECT COUNT(*) from #Corridge_Profit WHERE [OK] = 'NO')

		PRINT 'Corridge profit count OK=NO : ' + CAST(@corridgeProfitCount AS varchar(max))

	-- 18_Incorpora GST Profit Erroneo

	INSERT INTO FIN.[20_FAGLL03] 
		( [Account], [Assignment], [Document Number], [Document Date], [Amount in local currency], 
		[Local Currency],[Amount in loc.curr.2], [Amount in doc. curr.], [Profit Center], [Quantity], 
		[Text], [Base Unit of Measure], [Company Code], [Cost Center],[Cost Element], [Functional Area], 
		[G/L Fiscal Year], [General ledger currency], [General Ledger Item],[Invoice reference], 
		[Material], [Order], [Partner Profit Ctr], [Plant], [Posting Period], [Reference], [User name],[Type])
			SELECT [Account],[Assignment],[Document Number],[Document Date], 
			[Amount in local currency] * -1,
			[Local Currency],
			[Amount in loc.curr.2] * -1, 
			[Amount in doc. curr.] * -1,
			[FIN].[20_FAGLL03].[Profit Center],
			[Quantity] * -1,
			[Text],[Base Unit of Measure], 
			[Company Code],[FIN].[20_FAGLL03].[Cost Center],
			[Cost Element],[Functional Area],[G/L Fiscal Year],[General ledger currency], 
			[General Ledger Item],[Invoice reference],[Material],[Order],
			[Partner Profit Ctr],[Plant],[Posting Period],[Reference],[User name],'GST' AS [Type]
			FROM [FIN].[20_FAGLL03] INNER JOIN #Corridge_Profit ON [FIN].[20_FAGLL03].
			[Cost Center] = #Corridge_Profit.[Cost Center] AND 
			[FIN].[20_FAGLL03].[Profit Center] = #Corridge_Profit.[Profit Center]
			WHERE #Corridge_Profit.[OK]='NO';

	SET @fagll03count = (SELECT COUNT(*) FROM [FIN].[20_FAGLL03])

	PRINT 'FAGLL03 Count | After Profit Correction 1 : '+CAST(@fagll03count AS varchar(max))

	-- 19_Incorpora GST Profit Correcto

	INSERT INTO FIN.[20_FAGLL03] 
		( [Account], [Assignment], [Document Number], [Document Date], [Amount in local currency], 
		[Local Currency],[Amount in loc.curr.2], [Amount in doc. curr.], [Profit Center], [Quantity], 
		[Text], [Base Unit of Measure], [Company Code], [Cost Center],[Cost Element], [Functional Area], 
		[G/L Fiscal Year], [General ledger currency], [General Ledger Item],[Invoice reference], 
		[Material], [Order], [Partner Profit Ctr], [Plant], [Posting Period], [Reference], [User name],[Type])
			SELECT [Account],[Assignment],[Document Number],[Document Date], 
			[Amount in local currency] *-1,
			[Local Currency],
			[Amount in loc.curr.2] *-1, 
			[Amount in doc. curr.] *-1,
			#Corridge_Profit.[Profit_OK],
			[Quantity] *-1,
			[Text],[Base Unit of Measure], 
			[Company Code],[FIN].[20_FAGLL03].[Cost Center],
			[Cost Element],[Functional Area],[G/L Fiscal Year],[General ledger currency], 
			[General Ledger Item],[Invoice reference],[Material],[Order],
			[Partner Profit Ctr],[Plant],[Posting Period],[Reference],[User name],'GST' AS [Type]
			FROM [FIN].[20_FAGLL03] INNER JOIN #Corridge_Profit ON [FIN].[20_FAGLL03].
			[Cost Center] = #Corridge_Profit.[Cost Center] AND 
			[FIN].[20_FAGLL03].[Profit Center] = #Corridge_Profit.[Profit Center]
			WHERE #Corridge_Profit.[OK]='NO' AND [Type] = 'GST';

	SET @fagll03count = (SELECT COUNT(*) FROM [FIN].[20_FAGLL03])

	PRINT 'FAGLL03 Count | After Profit Correction 2 : '+CAST(@fagll03count AS varchar(max))

	-- 20_Valida TB13 Function Area

	DROP TABLE IF EXISTS #Corridge_Function_Area;
	CREATE TABLE #Corridge_Function_Area
	(
	[Cost Center] varchar(max),
	[Functional Area] varchar(max),
	[Area_OK] varchar(max),
	[OK] varchar(max)
	);

	INSERT INTO #Corridge_Function_Area
		SELECT [Cost Center],[Functional Area],[Functional Area] AS Area_OK, 'SI' AS OK 
		FROM [FIN].[20_FAGLL03]
		GROUP BY [20_FAGLL03].[Cost Center], [20_FAGLL03].[Functional Area]
		HAVING ((([20_FAGLL03].[Cost Center])<>'' And ([20_FAGLL03].[Cost Center]) Is Not Null));

	DECLARE @corridgeFunctionAreaCount int = 0

	SET @corridgeFunctionAreaCount = (SELECT COUNT(*) from #Corridge_Function_Area WHERE [OK] = 'SI')

	PRINT 'Corridge function area count: '+ CAST(@corridgeFunctionAreaCount AS varchar(max))

	-- 22_Elimina TB13 Function Area

	DROP TABLE IF EXISTS #Corridge_Function_Area_Duplicates;
	CREATE TABLE #Corridge_Function_Area_Duplicates
	(
	[Cost Center] varchar(max),
	[Functional Area] varchar(max),
	[Area_OK] varchar(max),
	[OK] varchar(max)
	);

	INSERT INTO #Corridge_Function_Area_Duplicates
		SELECT [Cost Center], [Functional Area], [Area_OK], [OK]
		FROM #Corridge_Function_Area
		WHERE ((([Cost Center]) IN (SELECT [Cost Center] FROM #Corridge_Function_Area
			GROUP BY [Cost Center] HAVING Count(*)>1 )))
			ORDER BY #Corridge_Function_Area.[Cost Center];

	DECLARE @corridgeFunctionAreaDuplicatesCount int = 0

	SET @corridgeFunctionAreaDuplicatesCount = (SELECT COUNT(*) from #Corridge_Function_Area_Duplicates WHERE [OK] = 'SI')

	PRINT 'Corridge function area duplicates count: '+ CAST(@corridgeFunctionAreaDuplicatesCount AS varchar(max))
	
	DELETE FROM #Corridge_Function_Area_Duplicates
	WHERE (((#Corridge_Function_Area_Duplicates.[Functional Area]) Is Null));

	SET @corridgeFunctionAreaDuplicatesCount = (SELECT COUNT(*) from #Corridge_Function_Area_Duplicates WHERE [OK] = 'SI')

	PRINT 'Corridge function area duplicates count after NULL removed: '+ CAST(@corridgeFunctionAreaDuplicatesCount AS varchar(max))

	-- 23_Incorpora Area Ok TB13

	UPDATE #Corridge_Function_Area
		SET [Area_OK] = MCP.[Functionalarea]
		FROM #Corridge_Function_Area
		INNER JOIN [FIN].[MasterCostAndProfit] MCP
		ON #Corridge_Function_Area.[Cost Center] = MCP.[CostCenter];

	-- 24_Identifica Area Ok TB13 Erroneo

	UPDATE #Corridge_Function_Area SET [OK] = 'NO'
		WHERE [Functional Area]<>[Area_OK];

	SET @corridgeFunctionAreaCount = (SELECT COUNT(*) from #Corridge_Function_Area WHERE [OK] = 'SI')

	PRINT 'Corridge function area count | After update: '+ CAST(@corridgeFunctionAreaCount AS varchar(max))


	-- 25_Incorpora GST Function Area Erroneo

	INSERT INTO FIN.[20_FAGLL03]( Account, Assignment, [Document Number], [Document Date], 
	[Amount in local currency], [Local Currency], [Amount in loc.curr.2], [Amount in doc. curr.], 
	[Profit Center], [Text], [Base Unit of Measure], [Company Code], [Cost Center], 
	[Cost Element], [Document Number G/L], [Functional Area], 
	[G/L Fiscal Year], [General ledger currency], [General Ledger Item], [Invoice reference], 
	Material, [Order], [Partner Profit Ctr], Plant, [Posting period], Quantity, Reference, [User name], Type )
		SELECT [Account], [Assignment], 
		[Document Number], [Document Date], 
		[Amount in local currency] *-1, 
		[Local Currency], 
		[Amount in loc.curr.2] *-1, 
		[Amount in doc. curr.] *-1, 
		[Profit Center], [Text], 
		[Base Unit of Measure], [Company Code], 
		FIN.[20_FAGLL03].[Cost Center], [Cost Element], 
		[Document Number G/L], FIN.[20_FAGLL03].[Functional Area], 
		[G/L Fiscal Year], [General ledger currency], 
		[General Ledger Item], [Invoice reference], 
		[Material], [Order],[Partner Profit Ctr], 
		[Plant], [Posting period], 
		[Quantity] *-1, [Reference], 
		[User name], 'GS2' AS Type
		FROM FIN.[20_FAGLL03] INNER JOIN #Corridge_Function_Area ON ([20_FAGLL03].[Functional Area] = #Corridge_Function_Area.[Functional Area]) 
		AND ([20_FAGLL03].[Cost Center] = #Corridge_Function_Area.[Cost Center])
		WHERE (((#Corridge_Function_Area.OK)='NO'));

	SET @fagll03count = (SELECT COUNT(*) FROM [FIN].[20_FAGLL03])

	PRINT 'FAGLL03 Count | After Functional Area Correction 1 : '+CAST(@fagll03count AS varchar(max))

	-- 26_Incorpora GST Function Area Correcto

	INSERT INTO FIN.[20_FAGLL03]( [Account], [Assignment], [Document Number], [Document Date], 
	[Amount in local currency], [Local Currency], [Amount in loc.curr.2], [Amount in doc. curr.], 
	[Profit Center], [Text], [Base Unit of Measure], [Company Code], [Cost Center], 
	[Cost Element], [Document Number G/L], [Functional Area], 
	[G/L Fiscal Year], [General ledger currency], [General Ledger Item], [Invoice reference], 
	[Material], [Order], [Partner Profit Ctr], [Plant], [Posting period], [Quantity], [Reference], [User name], Type )
		SELECT [Account], [Assignment],[Document Number], 
		[Document Date], 
		[Amount in local currency] *-1, 
		[Local Currency], 
		[Amount in loc.curr.2] *-1, 
		[Amount in doc. curr.] *-1, 
		[Profit Center], [Text], 
		[Base Unit of Measure], 
		[Company Code], FIN.[20_FAGLL03].[Cost Center], 
		[Cost Element], [Document Number G/L], 
		#Corridge_Function_Area.Area_OK, 
		[G/L Fiscal Year], [General ledger currency], 
		[General Ledger Item], [Invoice reference], 
		[Material], [Order], FIN.[20_FAGLL03].[Partner Profit Ctr], 
		[Plant], [Posting period], 
		[Quantity] *-1, [Reference], 
		[User name], 'GST' AS Type
		FROM FIN.[20_FAGLL03] INNER JOIN #Corridge_Function_Area ON ([20_FAGLL03].[Functional Area] = #Corridge_Function_Area.[Functional Area]) AND ([20_FAGLL03].[Cost Center] = #Corridge_Function_Area.[Cost Center])
		WHERE (((#Corridge_Function_Area.OK)='NO') AND ((Type)='GS2'));

	SET @fagll03count = (SELECT COUNT(*) FROM [FIN].[20_FAGLL03])

	PRINT 'FAGLL03 Count | After Functional Area Correction 2 : '+CAST(@fagll03count AS varchar(max))


	-- 30_Crea TB21 FAGLL03 Final

	INSERT INTO FIN.[21_FAGLL03 FINAL] ([Version],[G/L Fiscal Year],[Posting period]
    ,[Type],[Account],[Long Text],[Denom1],[Assignment],[Document Number],[Document Date],[Amount in local currency],[Local Currency]
    ,[Amount in loc curr 2],[Amount in doc curr],[Profit Center],[PC Description],[Country],[Text1],[Base Unit of Measure],[Company Code]
	,[Cost Center],[CC Description],[Responsible 1],[Responsible 2],[Responsible 3],[Responsible 4],[Cost Element]
    ,[Document Number G/L],[Functional Area],[Description],[Group],[General ledger currency],[General Ledger Item]
    ,[Invoice reference],[Material],[Material Description],[Matl Group],[Mat group description],[Mat group description 2]
	,[Material type],[Material group description],[Order],[Partner Profit Ctr],[Plant],[New Plant Name],[Quantity]
    ,[User name],[Status],[R2A],[R3A],[R4A])
		SELECT 'R' + CAST(FAG.[G/L Fiscal Year] AS varchar(max)) AS Version, FAG.[G/L Fiscal Year], FAG.[Posting period], 
		Type, FAG.Account, MA.[LongText], 
		MA.[Denom1], FAG.[Assignment], FAG.[Document Number], 
		FAG.[Document Date], FAG.[Amount in local currency]*-1 AS [Amount in local currency], 
		FAG.[Local Currency], FAG.[Amount in loc.curr.2] * -1 AS [Amount in loc curr 2], 
		FAG.[Amount in doc. curr.] * -1 AS [Amount in doc curr], FAG.[Profit Center], 
		MCP.[PCDescription] AS [PC Description], MCP.Country, 
		FAG.[Text] AS [Text1], FAG.[Base Unit of Measure], FAG.[Company Code], 
		FAG.[Cost Center], MCP.[CCDescription] AS [CC Description], 
		MCP.[Responsible1] AS [Responsible 1], MCP.[Responsible2] AS [Responsible 2], 
		MCP.[Responsible3] AS [Responsible 3], MCP.[Responsible4] AS [Responsible 4], 
		FAG.[Cost Element], FAG.[Document Number G/L], FAG.[Functional Area], 
		MFA.[Description], MFA.[Group], 
		FAG.[General ledger currency], FAG.[General Ledger Item], 
		FAG.[Invoice reference], FAG.Material, 
		MPR.[MaterialDescription] AS [Material Description], 
		MPR.[MatlGroup] AS [Matl Group], 
		MPR.[MatlGroupDescription] AS [Mat group description], 
		MPR.[MatlGroupDescription2] AS [Mat group description 2], 
		MPR.[MaterialType] AS [Material type], 
		MPR.[MaterialGroupDescription] AS [Material group description], 
		FAG.[Order], FAG.[Partner Profit Ctr], 
		FAG.Plant, MPL.[NewPlantName], 
		FAG.Quantity *-1, FAG.[User name], MCP.Status, 
		MCP.[Respnsible2A], MCP.[Responisble3A], 
		MCP.[Responsible4A]
		FROM ((((FIN.[20_FAGLL03] FAG 
			LEFT JOIN FIN.[MasterCostAndProfit] MCP 
				ON (FAG.[Cost Center] = MCP.[CostCenter] AND FAG.[Profit Center] = MCP.[ProfitCenter])
				OR (FAG.[Cost Center] IS NULL AND FAG.[Profit Center] = MCP.[ProfitCenter])) 
			LEFT JOIN FIN.[MaestroAccounts] MA ON FAG.[Account] = MA.[G/LAcct]) 
			LEFT JOIN FIN.[MaestroFunctionalArea] MFA ON FAG.[Functional Area] = MFA.[FunctionalArea])
			LEFT JOIN FIN.[MaestroPlants] MPL ON FAG.[Plant] = MPL.[NewPlant]) 
			LEFT JOIN FIN.[MaestroProducts] MPR ON FAG.[Material] = MPR.[Material]


	DECLARE @fagll03finalcount int = 0
	
	SET @fagll03finalcount = (SELECT COUNT(*) FROM [FIN].[21_FAGLL03 FINAL])

	PRINT 'FAGLL03 FINAL Count : '+CAST(@fagll03finalcount AS varchar(max))

	-- 31_Corrige Function Area NULL

	UPDATE FIN.[21_FAGLL03 FINAL] 
		SET [Functional Area] = 'SK20', 
			[Description] = 'Costo de Venta', 
			[Group] = 'Sale Cost'
		WHERE ((([Functional Area])='' OR ([Functional Area]) IS NULL) AND (([Profit Center])<>'ZA08Z01'));

	PRINT 'Updated Functional Area == NULL'

	-- 32_Corriige Responsable 1 NULL
		-- Skipped, do not have access to dbo_45_Maestro_R1

	-- 33_Corriige Responsable 2 NULL
		-- Skipped, do not have access to dbo_46_Maestro_R2

	-- 34_Corriige Responsable 3 NULL
		-- Skipped, do not have access to dbo_47_Maestro_R3

	-- 35_Corriige Responsable 4 NULL
		-- Skipped, do not have access to dbo_48_Maestro_R4

	-- 36_Corriige Responsable 2A NULL
		-- Skipped, do not have access to dbo_46_Maestro_R2A

	-- 37_Corriige Responsable 3A NULL
		-- Skipped, do not have access to dbo_47_Maestro_R3A

	-- 38_Corriige Responsable 4A NULL
		-- Skipped, do not have access to dbo_48_Maestro_R4A

	-- 39_Corriige Plant NULL

	UPDATE FIN.[21_FAGLL03 FINAL]
		SET [Plant] = MPL.NewPlant,
			[New Plant Name] = MPL.[NewPlantName]
		FROM FIN.[21_FAGLL03 FINAL] FAG
			INNER JOIN FIN.[MaestroPlants] MPL ON [Profit Center] = MPL.[ProfitCenter]
		WHERE FAG.[Plant] = '' OR FAG.[Plant] IS NULL;
	
	PRINT 'Updated Plant == NULL'

	-- NEW STEP -- Update Functional Area by Account

	UPDATE [FIN].[21_FAGLL03 FINAL]
		SET [Functional Area] = MA.[FunctionalArea],
			[Description] = MA.[LongText], 
			[Group] = MFA.[Group]
		FROM [FIN].[21_FAGLL03 FINAL] FAG
		INNER JOIN [FIN].[MaestroAccounts] MA ON FAG.[Account] = MA.[G/LAcct]
		INNER JOIN [FIN].[MaestroFunctionalArea] MFA ON MA.[FunctionalArea] = MFA.[FunctionalArea]
		WHERE FAG.[Functional Area] = 'SK20'

	-- 40_Corriige GS2 x GST

	UPDATE FIN.[21_FAGLL03 FINAL] SET Type = 'GST'
		WHERE (((Type)='GS2'));

	PRINT 'Updated Type == GS2'

	-- DELETE Staging Data

	DELETE FROM FIN.[19_FAGLL03 STAGING]


END
