CREATE TABLE [air].[Country]
(
	[CountryId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[ContinentId] [BIGINT] NOT NULL,
	[CountryName] [NVARCHAR](500) NOT NULL,
	[CountryCode] [NVARCHAR](10) NOT NULL,
	CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([CountryId] ASC),
	CONSTRAINT [FK_Country_ContinentId] FOREIGN KEY ([ContinentId]) REFERENCES [air].[Continent] ([ContinentId])
)
