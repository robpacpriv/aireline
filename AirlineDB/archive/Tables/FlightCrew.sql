CREATE TABLE [archive].[FlightCrew]
(
	[FlightId] [BIGINT] NOT NULL,
	[UserId] [BIGINT] NOT NULL,
	[PartitionKey] AS (DATEPART(YEAR,[dateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_FlightCrew_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_FlightCrew] PRIMARY key CLUSTERED ([FlightId] ASC, [UserId] ASC, [PartitionKey] DESC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_key = OFF) ON [psPartitionKeyYearMonth] ([PartitionKey])
);
GO
