CREATE TABLE [air].[AircraftInspection]
(
	[AircraftInspectionId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[InspectionType] [NVARCHAR](200) NULL,
	[InspectionDescryption] [NVARCHAR](500) NULL,
	[Interval] [NVARCHAR](50) NULL,

	CONSTRAINT [PK_AircraftInspection] PRIMARY KEY CLUSTERED ([AircraftInspectionId] ASC)
)
