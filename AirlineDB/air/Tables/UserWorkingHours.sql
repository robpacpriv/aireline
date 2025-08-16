CREATE TABLE [air].[UserWorkingHours]
(
	[UserWorkingHoursId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[UserId] [BIGINT] NOT NULL,
	[StartDate] DATETIME2(7) NOT NULL,
	[EndDate] DATETIME2(7) NOT NULL,
	[Date] AS  (DATEPART(YEAR,[StartDate])*(10000)+DATEPART(MONTH,[StartDate])*(100)+DATEPART(DAY,[StartDate])) PERSISTED NOT NULL,
	[PartitionKey] AS (DATEPART(YEAR,[DateCreated])*(100)+DATEPART(MONTH,[DateCreated])) PERSISTED NOT NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_UserWorkingHours_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,

	CONSTRAINT [PK_UserWorkingHours] PRIMARY key CLUSTERED ([UserWorkingHoursId] ASC, [PartitionKey] DESC) ON [psPartitionKeyYearMonth] ([PartitionKey]),
	CONSTRAINT [FK_UserWorkingHours_UserId] FOREIGN KEY ([UserId]) REFERENCES [air].[User] ([UserId]) -- during switching partition we need to remove FK from here and get them back at the end of the process
);
GO
