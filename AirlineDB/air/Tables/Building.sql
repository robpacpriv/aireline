CREATE TABLE [air].[Building]
(
	[BuildingId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[CityId] [BIGINT] NOT NULL,
	[ZipCode] [NVARCHAR](100) NOT NULL,
	[BuildingName] [NVARCHAR](500) NULL,
	[BuildingCode] [NVARCHAR](200) NULL,

	[StreetNameAndNo] [NVARCHAR](200) NOT NULL,


	CONSTRAINT [PK_BuildingI] PRIMARY KEY CLUSTERED ([BuildingId] ASC),
	CONSTRAINT [FK_BuildingId_CityId] FOREIGN KEY ([CityId]) REFERENCES [air].[City] ([CityId])
)
