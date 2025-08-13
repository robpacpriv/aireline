CREATE TABLE [logging].[LogStoredProcedure]
	(
	[LogStoredProcedureId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[Name] [NVARCHAR](500) NULL,
	[SqlText] [NVARCHAR](4000) NULL,
	[ExecutedBy] [NVARCHAR](500) NULL,
	[MessageText] [NVARCHAR](4000) NULL,
	[ReturnValue] [INT] NULL,
	[StartTime] [DATETIME2](7) NULL,
	[StopTime] [DATETIME2](7) NULL,
	[PartitionKey] [INT] NULL,
	[DateCreated] [DATETIME2](7) NOT NULL,
	[SessionId] [SMALLINT] NULL,
	[ApplicationName] [NVARCHAR](128) NULL
) ON [psPartitionKeyDateHour]([PartitionKey])
;

GO
ALTER TABLE [logging].[LogStoredProcedure] ADD  CONSTRAINT [DF_LogStoredPorcedure_ApplicationName] DEFAULT (app_name()) FOR [ApplicationName];

GO
ALTER TABLE [logging].[LogStoredProcedure] ADD  CONSTRAINT [DF_LogStoredPorcedure_DateCreated]  DEFAULT (sysutcdatetime()) FOR [DateCreated];

GO
ALTER TABLE [logging].[LogStoredProcedure] ADD  CONSTRAINT [DF_LogStoredPorcedure_SessionId] DEFAULT (@@spid) FOR [SessionId];