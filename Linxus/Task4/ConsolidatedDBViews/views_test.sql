CREATE VIEW [FIN].[PWBI_10_EERR_test1] (
        Fuente, 
        Version,
        AÑO, 
        MES,
        Account,
        Account_Description,
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
        Area_Description,
        [Amount in local currency],
        [Amount in loc curr 2],
        [R2A], 
        [R3A], 
        [R4A]
)
WITH SCHEMABINDING as 
    SELECT        'EERR' AS Fuente, Version, [G/L Fiscal Year] AS AÑO, [Posting period] AS MES, Account, [Long Text] AS Account_Description, Denom1, [Profit Center], [PC Description], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area], [Group] AS Area_Description, 
                         SUM([Amount in local currency]) AS [Amount in local currency], SUM([Amount in loc curr 2]) AS [Amount in loc curr 2], [R2A], [R3A], [R4A]
FROM            [FIN].[21_FAGLL03 FINAL]
GROUP BY Version, [G/L Fiscal Year], [Posting period], Account, [Long Text], Denom1, [Profit Center], [PC Description], [Cost Center], [CC Description], [Responsible 1], [Responsible 2], [Responsible 3], [Responsible 4], [Functional Area],[Group], [R3A], [R2A], [R4A]
HAVING        (SUM([Amount in local currency]) <> 0)



