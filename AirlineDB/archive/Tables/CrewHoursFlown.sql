CREATE TABLE [archive].[CrewHoursFlown]
(
	[CrewHoursFlownId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[FlightId] [BIGINT] NOT NULL,
	[UserId] [BIGINT] NOT NULL,
	[HoursWorked] [INT] NULL,
	--[DepartureDateTime] DATETIME2(7) NULL,
	--[ArivalDateTime] DATETIME2(7) NULL,
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_archive_CrewHoursFlown_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_CrewHoursFlown] PRIMARY key CLUSTERED ([CrewHoursFlownId] ASC, [PartitionKey] DESC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_key = OFF) ON [psPartitionKeyYearMonth] ([PartitionKey])
);
GO
