CREATE TABLE [air].[UserToTypeToSeniority]
(
	[UserId] [BIGINT] NOT NULL,
	[UserTypeId] [BIGINT] NOT NULL,
	[UserSeniorityId] [BIGINT] NOT NULL,

	CONSTRAINT [PK_UserToTypeToSeniority] PRIMARY KEY CLUSTERED ([UserId] ASC, [UserTypeId] ASC, [UserSeniorityId] ASC),
	CONSTRAINT [FK_UserToTypeToSeniority_UserId] FOREIGN KEY ([UserId]) REFERENCES [air].[User] ([UserId]),
	CONSTRAINT [FK_UserToTypeToSeniority_UserTypeId] FOREIGN KEY ([UserTypeId]) REFERENCES [air].[UserType] ([UserTypeId]),
	CONSTRAINT [FK_UserToTypeToSeniority_UserSeniorityId] FOREIGN KEY ([UserSeniorityId]) REFERENCES [air].[UserSeniority] ([UserSeniorityId])
);
GO
