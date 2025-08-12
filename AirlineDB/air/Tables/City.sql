CREATE TABLE [air].[City]
(
	[CityId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[CountryId] [BIGINT] NOT NULL,
	[CityName] [NVARCHAR](500) NOT NULL,
	[CityCode] [NVARCHAR](10) NOT NULL,
	CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED ([CityId] ASC),
	CONSTRAINT [FK_City_CountryId] FOREIGN KEY ([CountryId]) REFERENCES [air].[Country] ([CountryId])
)
