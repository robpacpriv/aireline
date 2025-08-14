CREATE TABLE [air].[FlightCrew]
(
	[FlightId] [BIGINT] NOT NULL,
	[UserId] [BIGINT] NOT NULL,
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_FlightCrew_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_FlightCrew] PRIMARY key CLUSTERED ([FlightId] ASC, [PartitionKey] DESC) ON [psPartitionKeyYearMonth] ([PartitionKey]),
	CONSTRAINT [FK_FlightCrew_FlightId] FOREIGN KEY ([FlightId],[PartitionKey]) REFERENCES [air].[Flight] ([FlightId],[PartitionKey]),
	CONSTRAINT [FK_FlightCrew_UserId] FOREIGN KEY ([UserId]) REFERENCES [air].[User] ([UserId])
);
GO
