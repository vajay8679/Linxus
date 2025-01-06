/****** Object:  StoredProcedure [FIN].[SP_ProcessNewKE24_v1]    Script Date: 18-04-2024 21:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
ALTER PROCEDURE [FIN].[SP_ProcessNewKE24_v1]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	DELETE FROM FIN.[25_KE24]
	DELETE FROM FIN.[26_KE24_FINAL]

-- 20_Crea TB26 KB24 Final

CREATE TABLE #MCP (
	Responsible1 VARCHAR(50), 
    Responsible2 VARCHAR(50), 
    Respnsible2A VARCHAR(50), 
    Responsible3 VARCHAR(50), 
    Responisble3A VARCHAR(50), 
    Responsible4 VARCHAR(50), 
    Responsible4A VARCHAR(50),
	Country VARCHAR(50),
	PCDescription VARCHAR(50),
	ProfitCenter VARCHAR(50),
	RowNum INT
)

INSERT INTO #MCP
	SELECT
    Responsible1, 
    Responsible2, 
    Respnsible2A, 
    Responsible3, 
    Responisble3A, 
    Responsible4, 
    Responsible4A,
	Country,
	PCDescription,
	ProfitCenter,
    ROW_NUMBER() OVER (PARTITION BY [FIN].[MasterCostAndProfit].ProfitCenter ORDER BY (SELECT NULL)) AS RowNum
    FROM [FIN].[MasterCostAndProfit]

INSERT INTO FIN.[25_KE24]
SELECT 
    1 AS load, 
    'R' + CAST(Year([Posting date]) AS varchar(max)) AS Version, 
    Year([Posting date]) AS AÑO, 
    Month([Posting date]) AS MES, 
    'CTB' AS TYPE, 
    FIN.[24_KE24 STAGING].[Company Code], 
    FIN.[24_KE24 STAGING].[Posting date], 
    FIN.[24_KE24 STAGING].[Reference document], 
    FIN.[24_KE24 STAGING].[Profit Center], 
    #MCP.PCDescription, 
    #MCP.Country, 
    FIN.[24_KE24 STAGING].Plant, 
    [FIN].[MaestroPlants].[NewPlantName], 
    FIN.[24_KE24 STAGING].Customer, 
    [FIN].[MaestroCustomersUpdate].CustomerText, 
    [FIN].[MaestroCustomersUpdate].City1, 
    [FIN].[MaestroCustomersUpdate].City2, 
    [FIN].[MaestroCustomersUpdate].Country AS Country_Customer, 
    [FIN].[MaestroCustomersUpdate].Zone, 
    [FIN].[MaestroCustomersUpdate].MineralOre, 
    [FIN].[MaestroCustomersUpdate].TypeOfBusiness, 
    FIN.[24_KE24 STAGING].[Sold-to party], 
    [FIN].[MaestroCustomersUpdate].[SoldToPartyText], 
    FIN.[24_KE24 STAGING].[Ship-to party], 
    [FIN].[MaestroCustomersUpdate].[ShipToLocationText], 
    FIN.[24_KE24 STAGING].[Bill-to party], 
    [FIN].[MaestroCustomersUpdate].[BillToPartyText], 
    [FIN].[MaestroProducts].[GROUP], 
    FIN.[24_KE24 STAGING].Product, 
    [FIN].[MaestroProducts].MaterialDescription, 
    [FIN].[MaestroProducts].MatlGroup, 
    [FIN].[MaestroProducts].MatlGroupDescription, 
    [FIN].[MaestroProducts].MatlGroupDescription2, 
    [FIN].[MaestroProducts].MaterialType, 
    [FIN].[MaestroProducts].MaterialGroupDescription, 
    [FIN].[MaestroProducts].OUn, 
    [FIN].[MaestroProducts].Unit, 
    [FIN].[MaestroProducts].Unit2, 
    [FIN].[MaestroProducts].[KG/BOX0-0BAG], 
    [FIN].[MaestroProducts].[Kg/unit], 
    [FIN].[MaestroProducts].[Unit/Box], 
    [FIN].[MaestroProducts].[Unit/Rol], 
    [FIN].[MaestroProducts].Gross, 
    [FIN].[MaestroProducts].Net, 
    FIN.[24_KE24 STAGING].[Sales Order], 
    FIN.[24_KE24 STAGING].[PA Unit - Sales Tons], 
    FIN.[24_KE24 STAGING].[Sales quantity], 
    NULLIF(FIN.[24_KE24 STAGING].[Sales quantity], 0) AS [Qty Unit2], 
    FIN.[24_KE24 STAGING].[Unit Sales quantity], 
    FIN.[24_KE24 STAGING].[Con/Neg/Man Price], 
    FIN.[24_KE24 STAGING].[Base Price], 
    FIN.[24_KE24 STAGING].[Sundry & Services], 
    NULLIF(([Con/Neg/Man Price]+[Base Price]+[Sundry & Services]+[Negotiated Price]+[Transportation Recov])/NULLIF(FIN.[24_KE24 STAGING].[Sales quantity], 0), 0) AS [Price/Unit], 
    [Con/Neg/Man Price]+[Base Price]+[Sundry & Services]+[Negotiated Price]+[Transportation Recov] AS Revenue, 
    NULLIF([Stock Value]/NULLIF(FIN.[24_KE24 STAGING].[Sales quantity], 0), 0) AS [Cost/Unit], 
    FIN.[24_KE24 STAGING].[Transportation Recov], 
    FIN.[24_KE24 STAGING].[Negotiated Price], 
    FIN.[24_KE24 STAGING].[Stock Value], 
    NULLIF([Intern Road Frght]+[Road Freight]+[Storage and Handling]+[Storage/Warehouse], 0) AS Freight, 
    FIN.[24_KE24 STAGING].[Intern Road Frght], 
    FIN.[24_KE24 STAGING].[Road Freight], 
    FIN.[24_KE24 STAGING].[Storage and Handling], 
    FIN.[24_KE24 STAGING].[Storage/Warehouse], 
    [FIN].[MaestroCustomersUpdate].TypeOfBusiness2 AS [Type of Business_2], 
    [FIN].[MaestroCustomersUpdate].Controller, 
    [FIN].[MaestroCustomersUpdate].[M&SCustomerName], 
    [FIN].[MaestroCustomersUpdate].SalesManagerPerCustomer, 
    [FIN].[MaestroCustomersUpdate].ProfitCenter2, 
    [FIN].[MaestroCustomersUpdate].PCDescription2 AS PC_Description2, 
    #MCP.Responsible1, 
    #MCP.Responsible2, 
    #MCP.Respnsible2A, 
    #MCP.Responsible3, 
    #MCP.Responisble3A, 
    #MCP.Responsible4, 
    #MCP.Responsible4A 
FROM 
    FIN.[24_KE24 STAGING]
    LEFT JOIN [FIN].[MaestroCustomersUpdate] ON 
		FIN.[24_KE24 STAGING].Customer = [FIN].[MaestroCustomersUpdate].Customer 
		AND FIN.[24_KE24 STAGING].[Ship-to location] = [FIN].[MaestroCustomersUpdate].ShipToLocation 
		AND FIN.[24_KE24 STAGING].[Sold-to party] = [FIN].[MaestroCustomersUpdate].SoldToParty
    LEFT JOIN 
    #MCP ON 
        FIN.[MaestroCustomersUpdate].ProfitCenter2 = #MCP.ProfitCenter AND #MCP.RowNum = 1
    LEFT JOIN [FIN].[MaestroPlants] ON FIN.[24_KE24 STAGING].Plant = [FIN].[MaestroPlants].NewPlant
    LEFT JOIN [FIN].[MaestroProducts] ON FIN.[24_KE24 STAGING].Product = [FIN].[MaestroProducts].Material

DROP TABLE #MCP

-- 21_Convierte BOX & BAG & DR  a TO

UPDATE FIN.[25_KE24]
SET [Qty Unit2] = ([Sales quantity] * [KG_BOX_BAG]) / 1000
WHERE (
    (
        ([Unit Sales quantity] = 'BOX' OR [Unit Sales quantity] = 'BAG' OR [Unit Sales quantity] = 'DR')
        AND (Unit2 = 'TO')
        AND ([Sales quantity] <> 0)
    )
)

-- 22_Convierte BOX  a Unit

UPDATE FIN.[25_KE24]
SET 
    [Qty Unit2] = [Sales quantity] * [Unit_Box],
    Unit2 = 'Unit'
WHERE (
    (
        (Unit2 = 'Unit')
        AND ([Unit Sales quantity] = 'BOX')
        AND ([Sales quantity] <> 0)
		--AND ([Sales quantity] IS NOT NULL)
    )
    OR
    (
        (Unit2 = 'BOX')
        AND ([Unit Sales quantity] = 'BOX')
        AND ([Sales quantity] <> 0)
        AND ([Group] = 'BOOSTER')
    )
);

-- 23_Convierte EA  a TO

UPDATE FIN.[25_KE24]
SET [Qty Unit2] = ([Sales quantity] * [Kg_unit]) / 1000
WHERE (
    (
        ([Unit Sales quantity] = 'EA')
        AND (Unit2 = 'TO')
        AND ([Sales quantity] <> 0)
    )
);

-- 24_Convierte ROL  a Unit

UPDATE FIN.[25_KE24]
SET [Qty Unit2] = ([Sales quantity] * [Unit_Rol])
WHERE (
    (
        ([Unit Sales quantity] = 'ROL')
        AND (Unit2 = 'Unit')
        AND ([Sales quantity] <> 0)
    )
);

-- 25_Convierte BOX a KG

UPDATE FIN.[25_KE24]
SET [Qty Unit2] = ([Sales quantity] * [KG_BOX_BAG]) / 1000
WHERE (
    ([Unit Sales quantity] = 'BOX')
    AND (Unit2 = 'KG')
    AND ([Sales quantity] <> 0)
    AND (
        ([Group] = 'EMEX')
        OR
        ([Group] = 'EXPLOGEL')
    )
);

-- 26_Reprocesa SENSITISERS

UPDATE FIN.[25_KE24]
SET [Qty Unit2] = [PA Unit - Sales Tons]
WHERE ([Group] = 'SENSITISERS');

-- 30_Calcula Price Unit Sales quantity <>0

UPDATE FIN.[25_KE24]
SET [Price/Unit] = [Revenue] / [Qty Unit2]
WHERE ([Sales quantity] <> 0 AND ([Sales quantity] IS NOT NULL));

-- 31_Calcula Price Unit Sales quantity = 0

UPDATE FIN.[25_KE24]
SET [Price/Unit] = [Revenue]
WHERE ([Sales quantity] = 0 AND ([Sales quantity] IS NOT NULL));

-- 32_Calcula Cost Unit Sales quantity <> 0

UPDATE FIN.[25_KE24] 
SET [Cost/Unit] = [Stock Value]/[Qty Unit2]
WHERE ([Sales quantity] <> 0 AND ([Sales quantity] IS NOT NULL));

-- 33_Calcula Cost Unit Sales quantity = 0

UPDATE FIN.[25_KE24]
SET [Cost/Unit] = [Stock Value]
WHERE ([Sales quantity] = 0 AND ([Sales quantity] IS NOT NULL));

-- 41_Jeff Skinner_Responsable 2A

UPDATE FIN.[25_KE24]
SET [R2A] = 'Jeff Skinner'
WHERE (
    ([R2A] IS NULL)
    AND
    ([Profit Center2] = 'ZA08E02')
);

-- 42_Gary Austen_Responsable 2A

UPDATE FIN.[25_KE24]
SET [R2A] = 'Gary Austen'
WHERE (
    ([R2A] IS NULL)
    AND
    ([Profit Center2] = 'ZA08E01')
);

-- 43_Pieter Oosthuizen_Responsable 2A

UPDATE FIN.[25_KE24]
SET [R2A] = 'Pieter Oosthuizen'
WHERE (
    ([R2A] IS NULL)
    AND
    ([Profit Center2] = 'ZA08W02')
);


-- INSERT INTO FINAL

INSERT INTO [FIN].[26_KE24_FINAL]
	SELECT * FROM FIN.[25_KE24]

END
