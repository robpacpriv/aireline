CREATE TABLE [air].[BuildingType]
(
	[BuildingTypeId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[BuildingTypeName] [NVARCHAR](500) NOT NULL, -- airplane, house, flat

	CONSTRAINT [PK_BuildingType] PRIMARY KEY CLUSTERED ([BuildingTypeId] ASC),
)
