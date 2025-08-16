CREATE TABLE [air].[CrewHoursWorked]
(
	[CrewHoursWorkedId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[FlightId] [BIGINT] NOT NULL,
	[UserId] [BIGINT] NOT NULL,
	[HoursWorked] [INT] NULL,
	--[DepartureDateTime] DATETIME2(7) NULL,
	--[ArivalDateTime] DATETIME2(7) NULL,
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_CrewHoursWorked_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_CrewHoursWorked] PRIMARY key CLUSTERED ([CrewHoursWorkedId] ASC, [PartitionKey] DESC) ON [psPartitionKeyYearMonth] ([PartitionKey]),
	CONSTRAINT [FK_CrewHoursWorked_FlightId] FOREIGN KEY ([FlightId],[PartitionKey]) REFERENCES [air].[Flight] ([FlightId],[PartitionKey]), -- during switching partition we need to remove FK from here and get them back at the end of the process
	CONSTRAINT [FK_CrewHoursWorked_UserId] FOREIGN KEY ([UserId]) REFERENCES [air].[User] ([UserId]) -- during switching partition we need to remove FK from here and get them back at the end of the process
);
GO
