CREATE TABLE [air].[AircraftInspection]
(
	[AircraftInspectionId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[InspectionType] [NVARCHAR](200) NULL,
	[InspectionDetails] [NVARCHAR](500) NULL,
	--[Interval] [NVARCHAR](50) NULL,
	[InspectionValidToDate] DATETIME2(7) NULL,
	[InspectionFailed] bit,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_AircraftInspection_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,
	[DateUpdated] DATETIME2(7) NULL

	CONSTRAINT [PK_AircraftInspection] PRIMARY KEY CLUSTERED ([AircraftInspectionId] ASC)
)
