CREATE TABLE [air].[CrewHoursFlown]--[air].[CrewHoursWorked]
(
	[CrewHoursFlownId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[FlightId] [BIGINT] NOT NULL,
	[UserId] [BIGINT] NOT NULL,
	[HoursFlown] [DECIMAL] (5,2) NULL,
	--[DepartureDateTime] DATETIME2(7) NULL,
	--[ArivalDateTime] DATETIME2(7) NULL,
	[Date] AS  (DATEPART(YEAR,[DateCreated])*(10000)+DATEPART(MONTH,[DateCreated])*(100)+DATEPART(DAY,[DateCreated])) PERSISTED NOT NULL,
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_CrewHoursFlown_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_CrewHoursFlown] PRIMARY key CLUSTERED ([CrewHoursFlownId] ASC, [PartitionKey] DESC) ON [psPartitionKeyYearMonth] ([PartitionKey]),
	CONSTRAINT [FK_CrewHoursFlown_FlightId] FOREIGN KEY ([FlightId],[PartitionKey]) REFERENCES [air].[Flight] ([FlightId],[PartitionKey]), -- during switching partition we need to remove FK from here and get them back at the end of the process
	CONSTRAINT [FK_CrewHoursFlown_UserId] FOREIGN KEY ([UserId]) REFERENCES [air].[User] ([UserId]) -- during switching partition we need to remove FK from here and get them back at the end of the process
);
GO
