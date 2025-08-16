CREATE TABLE [air].[User]
(
	[UserId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AirlineId] [BIGINT] NOT NULL,
	[BuildingId] [BIGINT] NULL,
	[Identifier] [NVARCHAR](150) NOT NULL,
	[FirstName] [NVARCHAR](500) NOT NULL,
	[SecoundName] [NVARCHAR](500) NULL,
	[LastName] [NVARCHAR](500) NOT NULL,
	[Email] [NVARCHAR](150) NOT NULL,
	[SocialSecurityNumber] [NVARCHAR](500) NULL,
	[DeactivationDate] DATETIME2(7) NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_User_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,
	[DateUpdated] DATETIME2(7) NULL,

	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([UserId] ASC),
	CONSTRAINT [FK_User_Airline] FOREIGN KEY ([AirlineId]) REFERENCES [air].[Airline] ([AirlineId]),
	CONSTRAINT [FK_User_Building] FOREIGN KEY ([BuildingId]) REFERENCES [air].[Building] ([BuildingId])
);
GO
