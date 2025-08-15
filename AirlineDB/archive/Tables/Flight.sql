CREATE TABLE [archive].[Flight]
(
	[FlightId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AircraftId] [BIGINT] NOT NULL,
	[FlightNumber] [NVARCHAR](200) NOT NULL,
	[DepartueAirportId] [BIGINT] NOT NULL,
	[ArivalAirportId] [BIGINT] NOT NULL,
	[DepartueDateTime] DATETIME2(7) NULL,
	[ArivalDateTime] DATETIME2(7) NULL,
	[DepartueDateTimePlanned] DATETIME2(7) NOT NULL,
	[ArivalDateTimePlanned] DATETIME2(7) NOT NULL,
	[DeactivationDate] DATETIME2(7) NULL,
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_Flight_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_Flight] PRIMARY key CLUSTERED ([FlightId] ASC, [PartitionKey] DESC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_key = OFF) ON [psPartitionKeyYearMonth] ([PartitionKey])
);
GO

CREATE NONCLUSTERED INDEX [IX_Flight_FlightNumber] ON [archive].[Flight] ([FlightNumber], [DeactivationDate], [PartitionKey] DESC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_key = OFF) ON psPartitionKeyYearMonth([PartitionKey])
GO
