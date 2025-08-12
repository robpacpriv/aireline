CREATE TABLE [air].[Continent]
(
	[ContinentId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[ContinentName] [NVARCHAR](500) NOT NULL,
	[ContinentCode] [NVARCHAR](200) NULL,
	CONSTRAINT [PK_Continent] PRIMARY KEY CLUSTERED ([ContinentId] ASC)
)
