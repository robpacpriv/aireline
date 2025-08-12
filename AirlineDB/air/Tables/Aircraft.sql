CREATE TABLE [air].[Aircraft]
(
	[AircraftId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AircraftName] [NVARCHAR](500) NULL,
	[AircrafType] [NVARCHAR](200) NULL,
	[RegistrationNumber] [NVARCHAR](50) NULL,
	[IsActive] BIT CONSTRAINT [DF_Aircraft_IsActive] DEFAULT (0) NOT NULL,
	[CrewMaxSize] INT NOT NULL,
	[PasangersMaxSize] INT NOT NULL,
	[CargoMaxKG] INT NOT NULL,

	CONSTRAINT [PK_Aircraft] PRIMARY KEY CLUSTERED ([AircraftId] ASC)
)
