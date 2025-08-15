CREATE TABLE [air].[UserSeniority]
(
	[UserSeniorityId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[UserSeniorityLevel] [TINYINT] NOT NULL,
	[UserSeniorityName] [NVARCHAR](500) NOT NULL, -- flight attendant / journeyman / senior

	CONSTRAINT [PK_CrewType] PRIMARY KEY CLUSTERED ([UserSeniorityId] ASC)
);
GO
