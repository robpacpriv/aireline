CREATE TABLE [archive].[FlightCrew]
(
	[FlightId] [BIGINT] NOT NULL,
	[CrewId] [BIGINT] NOT NULL,
	[PartitionKey] AS (DATEPART(YEAR,[dateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_FlightCrew_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_FlightCrew] PRIMARY key CLUSTERED ([FlightId] ASC, [PartitionKey] DESC) ON [psPartitionKeyYearMonth] ([PartitionKey])
);
GO
