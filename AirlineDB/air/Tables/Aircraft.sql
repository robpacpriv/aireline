CREATE TABLE [air].[Aircraft]
(
	[AircraftId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AirlineId] [BIGINT] NOT NULL,
	[AircraftName] [NVARCHAR](500) NULL,
	[AircrafType] [NVARCHAR](200) NULL,
	[RegistrationNumber] [NVARCHAR](50) NULL,
	--[IsActive] BIT CONSTRAINT [DF_Aircraft_IsActive] DEFAULT (0) NOT NULL,
	[PilotCount] INT NOT NULL,
	[CrewCount] INT NOT NULL,
	[PasangersMaxSize] INT NOT NULL,
	[CargoMaxKG] INT NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_Aircraft_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,
	[DateUpdated] DATETIME2(7) NULL,
	[DeactivationDate] DATETIME2(7) NULL,

	CONSTRAINT [PK_Aircraft] PRIMARY KEY CLUSTERED ([AircraftId] ASC),
	CONSTRAINT [FK_Aircraft_AirlineId] FOREIGN KEY ([AirlineId]) REFERENCES [air].[Airline] ([AirlineId]),
);
GO