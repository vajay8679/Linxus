use ENAEX_FIN_PRD;

create Table [FIN].[50_DOTACTION] (
    Version VARCHAR(50) NULL,
    [G/L Fiscal Year] INT null, -- doubt
    [Posting period] INT null, -- doubt
    Type VARCHAR(50) NULL,  -- doubt
    LOAD INT null,  -- doubt
    [Profit Center] VARCHAR(50) NULL,
    [PC Description] VARCHAR(50) NULL,
    Country VARCHAR(50) NULL,
    [Company Code] VARCHAR(50) NULL,
    [Cost Center] VARCHAR(50) NULL,
    [CC Description] VARCHAR(50) NULL,
    [Responsible 1] VARCHAR(50) NULL,
    [Responsible 2] VARCHAR(50) NULL,
    [Responsible 3] VARCHAR(50) NULL,
    [Responsible 4] VARCHAR(50) NULL,
    [Functional area] VARCHAR(50) NULL,
    Description VARCHAR(50) NULL,
    [Group] VARCHAR(50) NULL,
    [Employee Nr] INT null,  --yes
    [Last Name] VARCHAR(50) NULL, --yes
    Name VARCHAR(50) NULL,
    [Employee Name] VARCHAR(50) NULL,
    Gender VARCHAR(50) NULL, --yes
    Position VARCHAR(50) NULL, --yes
    Position_TEXT VARCHAR(50) NULL,--yes
    [Role Category] VARCHAR(50) NULL,--yes
    [Role Category Code] VARCHAR(50) NULL,--yes
    Status VARCHAR(50) NULL,
    Dotacion INT NULL,
    Valor INT NULL,
    TEXT1 VARCHAR(50) NULL,
    USUARIO VARCHAR(50) NULL,
    [Employee subgroup] VARCHAR(50) NULL,--yes
    [ID number] VARCHAR(50) NULL, --yes
    Nationality VARCHAR(50) NULL, --yes
    [Personnel area] VARCHAR(50) NULL, --yes
    [PA Text] VARCHAR(50) NULL, --yes
    birdate DATETIME NULL, --yes
    [Joined Group] DATETIME NULL, --yes
    Separation DATETIME NULL, --yes
    [Employment status] VARCHAR(50) NULL -- yes
    );