CREATE TABLE [air].[Flight]
(
	[FlightId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AircraftId] [BIGINT] NOT NULL,
	[FlightNumber] [NVARCHAR](200) NOT NULL,
	[DepartureAirportId] [BIGINT] NOT NULL,
	[ArivalAirportId] [BIGINT] NOT NULL,
	[DepartureDateTime] DATETIME2(7) NULL,
	[ArivalDateTime] DATETIME2(7) NULL,
	[DepartureDateTimePlanned] DATETIME2(7) NOT NULL,
	[ArivalDateTimePlanned] DATETIME2(7) NOT NULL,
	--[IsDeleted] bit CONSTRAINT [DF_air_Flight_isDeleted] DEFAULT 0 NOT NULL,
	[DeactivationDate] DATETIME2(7) NULL, -- when it is set, than by night it will be deleted
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_Flight_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_Flight] PRIMARY key CLUSTERED ([FlightId] ASC, [PartitionKey] DESC) ON [psPartitionKeyYearMonth] ([PartitionKey]),
	CONSTRAINT [FK_Flight_Aircraft] FOREIGN KEY ([AircraftId]) REFERENCES [air].[Aircraft] ([AircraftId]),
	CONSTRAINT [FK_Flight_DepartureAirportId] FOREIGN KEY ([DepartureAirportId]) REFERENCES [air].[Building] ([BuildingId]),
	CONSTRAINT [FK_Flight_ArivalAirportId] FOREIGN KEY ([ArivalAirportId]) REFERENCES [air].[Building] ([BuildingId])
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_air_Flight_FlightNumber] ON [air].[Flight] ([FlightNumber], [DeactivationDate], [PartitionKey] DESC)
WITH (ONLINE = ON) ON psPartitionKeyYearMonth([PartitionKey])
GO
