USE [ENAEX_FIN_PRD]
GO

INSERT INTO [FIN].[49_DOTACTION STAGING]
           ([Employee Nr]
           ,[Employment status]
           ,[Last Name]
           ,[Known As]
           ,[Gender]
           ,[ID number]
           ,[Nationality]
           ,[Employee subgroup]
           ,[Personnel area]
           ,[PA Text]
           ,[Cost Centre]
           ,[Cost Center Name]
           ,[Position]
           ,[Position_TEXT]
           ,[Role Category]
           ,[Role Category Code]
           ,[birdate]
           ,[Joined Group]
           ,[Separation])
     VALUES
           (<Employee Nr, int,>
           ,<Employment status, varchar(50),>
           ,<Last Name, varchar(50),>
           ,<Known As, varchar(50),>
           ,<Gender, varchar(50),>
           ,<ID number, varchar(50),>
           ,<Nationality, varchar(50),>
           ,<Employee subgroup, varchar(50),>
           ,<Personnel area, varchar(50),>
           ,<PA Text, varchar(50),>
           ,<Cost Centre, varchar(50),>
           ,<Cost Center Name, varchar(50),>
           ,<Position, varchar(50),>
           ,<Position_TEXT, varchar(50),>
           ,<Role Category, varchar(50),>
           ,<Role Category Code, varchar(50),>
           ,<birdate, datetime,>
           ,<Joined Group, datetime,>
           ,<Separation, datetime,>)
GO


="INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status], [Last Name], [Known As], [Gender], [ID number], [Nationality], [Employee subgroup], [Personnel area], [PA Text], [Cost Centre], [Cost Center Name], [Position],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation], [Position_TEXT], [Role Category], [Role Category Code], [birdate], [Joined Group], [Separation]) VALUES (" & A1 & ", '" & B1 & "', '" & C1 & "', '" & E1 & "', '" & H1 & "', '" & I1 & "', '" & J1 & "', '" & M1 & "', '" & P1 & "', '" & Q1 & "', '" & W1 & "', '" & X1 & "', '" & Y1 & "', '" & AA1 & "', '" & AG1 & "', '" & AH1 & "', '" & TEXT(AK1, "YYYY-MM-DD") & "', '" & TEXT(AN1, "YYYY-MM-DD") & "', '" & TEXT(AO1, "YYYY-MM-DD") & "');"



INSERT INTO [FIN].[49_DOTACTION STAGING] ([Position_TEXT], [Role Category], [Role Category Code], [birdate], [Joined Group], [Separation]) VALUES ('Marketing & Sales Director', '6', '0006 - Specialisation', '3/23/1984 0:00', '2008-01-06', '1899-12-30');

INSERT INTO [FIN].[49_DOTACTION STAGING] ([Position_TEXT], [Role Category], [Role Category Code], [birdate], [Joined Group], [Separation]) VALUES ('Marketing & Sales Director', '6', '0006 - Specialisation', '3/23/1984 0:00', '2008-01-06', IF(S1 <> ", '1899-12-30', NULL));

INSERT INTO [FIN].[49_DOTACTION STAGING] ([Position_TEXT], [Role Category], [Role Category Code], [birdate], [Joined Group], [Separation]) VALUES ('Marketing & Sales Director', '6', '0006 - Specialisation', '3/23/1984 0:00', '2008-01-06', IF(S1 <> ", '1899-12-30', NULL));

="INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status]) VALUES (" & A1 & ", '" & B1 & "');"


INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status]) VALUES (1015968, 'Active');


="INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status], [Last Name], [Known As], [Gender], [ID number], [Nationality], [Employee subgroup], [Personnel area], [PA Text], [Cost Centre], [Cost Center Name], [Position],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation]) VALUES (" & A1 & ", '" & B1 & "', '" & C1 & "', '" & E1 & "', '" & H1 & "', '" & I1 & "', '" & J1 & "', '" & M1 & "', '" & P1 & "', '" & Q1 & "', '" & W1 & "', '" & X1 & "', '" & Y1 & "');"


="INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status], [Last Name], [Known As], [Gender], [ID number], [Nationality], [Employee subgroup], [Personnel area], [PA Text], [Cost Centre], [Cost Center Name], [Position],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation]) VALUES (" & A1 & ", '" & B1 & "', '" & C1 & "', '" & E1 & "', '" & H1 & "', '" & I1 & "', '" & J1 & "', '" & M1 & "', '" & P1 & "', '" & Q1 & "', '" & W1 & "', '" & X1 & "', '" & Y1 & "');"


="INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status], [Last Name], [Known As], [Gender], [ID number], [Nationality], [Employee subgroup], [Personnel area], [PA Text], [Cost Centre], [Cost Center Name], [Position],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation], [Position_TEXT], [Role Category], [Role Category Code], [birdate], [Joined Group], [Separation]) VALUES (" & A1 & ", '" & B1 & "', '" & C1 & "', '" & D1 & "', '" & E1 & "', '" & F1 & "', '" & G1 & "', '" & H1 & "', '" & I1 & "', '" & J1 & "', '" & K1 & "', '" & L1 & "', '" & M1 & "', '" & N1 & "', '" & O1 & "', '" & P1 & "', '" & TEXT(Q1, "YYYY-MM-DD") & "', '" & TEXT(R1, "YYYY-MM-DD") & "', '" & TEXT(S1, "YYYY-MM-DD") & "');"


INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status], [Last Name], [Known As], [Gender], [ID number], [Nationality], [Employee subgroup], [Personnel area], [PA Text], [Cost Centre], [Cost Center Name], [Position],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation]) VALUES (Personnel Number, 'Employement Status', 'Last Name', 'Known As', 'Gender', 'ID Number', 'Nationality', 'Employe subgroup', 'Personal area', 'PA Text', 'Cost Centre', 'Cost Centre Text', 'Position');



INSERT INTO [FIN].[49_DOTACTION STAGING] ([Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation]) VALUES ('Explosives Operator Gr 1', '11', '0011 - Operations','1987-01-29', '2020-07-01', '2024-01-03');

INSERT INTO [FIN].[49_DOTACTION STAGING] ([Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation]) VALUES ('', '11', '0011 - Operations','1958-12-27', '2000-04-25', '2023-12-31');

="INSERT INTO [FIN].[49_DOTACTION STAGING] ([Position_TEXT], [Role Category], [Role Category Code], [birdate], [Joined Group], [Separation]) VALUES ('" & N1 & "', '" & O1 & "', '" & P1 & "', '" & TEXT(Q1, "YYYY-MM-DD") & "', '" & TEXT(R1, "YYYY-MM-DD") & "', " & IF(ISBLANK(S1), "NULL", "'" & TEXT(S1, "MM/DD/YYYY") & "'") & ");"

----------------------------------------------------------------------------------------------------------------

INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status], [Last Name], [Known As], [Gender], [ID number], [Nationality], [Employee subgroup], [Personnel area], [PA Text], [Cost Centre], [Cost Center Name], [Position],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation]) VALUES (Personnel Number, 'Employement Status', 'Last Name', 'Known As', 'Gender', 'ID Number', 'Nationality', 'Employe subgroup', 'Personal area', 'PA Text', 'Cost Centre', 'Cost Centre Text', 'Position');
INSERT INTO [FIN].[49_DOTACTION STAGING] ([Employee Nr], [Employment status], [Last Name], [Known As], [Gender], [ID number], [Nationality], [Employee subgroup], [Personnel area], [PA Text], [Cost Centre], [Cost Center Name], [Position],[Position_TEXT], [Role Category], [Role Category Code],[birdate], [Joined Group], [Separation]) VALUES (1015968, 'Active', 'Mathenjwa', 'Mguneni Comfort', 'M', '8403235669080', 'South Africa', 'Permanent', 'PERSONNEL_AREA', 'MZ20 - M&S Explosives', 'ZA08Z01C04', 'ZA08Z01C04 - SM Sales Sub Saharan', 'M03600001');
