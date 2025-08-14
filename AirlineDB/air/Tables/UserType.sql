CREATE TABLE [air].[UserType]
(
	[UserTypeId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[UserTypeName] [NVARCHAR](500) NOT NULL, -- trainee / pilot / manager / superManager

	CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED ([UserTypeId] ASC)
);
GO
