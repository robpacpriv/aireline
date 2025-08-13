CREATE TABLE [air].[Flight]
(
	[FlightId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AirlineId] [BIGINT] NOT NULL,
	[FlightNumber] [NVARCHAR](200) NOT NULL,
	[DepartueAirportId] [BIGINT] NOT NULL,
	[ArivalAirportId] [BIGINT] NOT NULL,
	[DepartueDateTime] DATETIME2(7) NULL,
	[ArivalDateTime] DATETIME2(7) NULL,
	[DepartueDateTimePlanned] DATETIME2(7) NOT NULL,
	[ArivalDateTimePlanned] DATETIME2(7) NOT NULL,
	--[IsDeleted] bit CONSTRAINT [DF_air_Flight_isDeleted] DEFAULT 0 NOT NULL,
	[DeactivationDate] DATETIME2(7) NULL,
	[partitionKey] AS (DATEPART(YEAR,[dateCreated])*(100)+DATEPART(MONTH,[dateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_Flight_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_Flight] PRIMARY KEY CLUSTERED ([FlightId] ASC),
	CONSTRAINT [FK_Flight_DepartueAirportId] FOREIGN KEY ([DepartueAirportId]) REFERENCES [air].[Building] ([BuildingId]),
	CONSTRAINT [FK_Flight_ArivalAirportId] FOREIGN KEY ([ArivalAirportId]) REFERENCES [air].[Building] ([BuildingId])
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UIX_air_Flight_FlightNumber] ON [air].[Flight] ([FlightNumber], [DeactivationDate], [partitionKey] DESC)
WITH (ONLINE = ON) ON psPartitionKeyYearMonth([partitionKey])
GO
