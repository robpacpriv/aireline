CREATE TABLE [archive].[UserWorkingHours]
(
	[UserWorkingHoursId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[UserId] [BIGINT] NOT NULL,
	[StartDate] DATETIME2(7) NOT NULL,
	[EndDate] DATETIME2(7) NOT NULL,
	[Date] AS  (DATEPART(YEAR,[StartDate])*(10000)+DATEPART(MONTH,[StartDate])*(100)+DATEPART(DAY,[StartDate])) PERSISTED NOT NULL,
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_archive_UserWorkingHours_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_UserWorkingHours] PRIMARY key CLUSTERED ([UserWorkingHoursId] ASC, [PartitionKey] DESC) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_key = OFF) ON [psPartitionKeyYearMonth] ([PartitionKey])
);
GO
