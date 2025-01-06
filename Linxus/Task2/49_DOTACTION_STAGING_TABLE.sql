use ENAEX_FIN_PRD;

create Table [FIN].[49_DOTACTION STAGING] (
   [Employee Nr] INT null,
   [Employment status] VARCHAR(50) NULL,
   [Last Name] VARCHAR(50) NULL,
   [Known As] VARCHAR(50) NULL,
   Gender VARCHAR(50) NULL,
   [ID number] VARCHAR(50) NULL,  -- changed datatype to - folat
   Nationality VARCHAR(50) NULL,
   [Employee subgroup] VARCHAR(50) NULL,
   [Personnel area] VARCHAR(50) NULL,
   [PA Text] VARCHAR(50) NULL,
   [Cost Centre] VARCHAR(50) NULL,
   [Cost Center Name] VARCHAR(50) NULL,
   Position VARCHAR(50) NULL,
   Position_TEXT VARCHAR(50) NULL,
   [Role Category] VARCHAR(50) NULL,
   [Role Category Code] VARCHAR(50) NULL,
   birdate DATETIME NULL, -- changed datatype to - varchar
   [Joined Group] DATETIME NULL, -- changed datatype to - varchar
   Separation DATETIME NULL -- changed datatype to - varchar
);



