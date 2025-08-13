CREATE TABLE [air].[Building]
(
	[BuildingId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[CityId] [BIGINT] NOT NULL,
	[ZipCode] [NVARCHAR](100) NOT NULL,
	[BuildingName] [NVARCHAR](500) NULL,
	[BuildingCode] [NVARCHAR](200) NULL,
	[StreetNameAndNo] [NVARCHAR](200) NOT NULL,
	[BuildingTypeId] [BIGINT] NULL,
	[DeactivationDate] DATETIME2(7) NULL,

	CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED ([BuildingId] ASC),
	CONSTRAINT [FK_Building_CityId] FOREIGN KEY ([CityId]) REFERENCES [air].[City] ([CityId]),
	CONSTRAINT [FK_Building_BuildingTypeId] FOREIGN KEY ([BuildingTypeId]) REFERENCES [air].[BuildingType] ([BuildingTypeId])
)
