CREATE TABLE [air].[Crew]
(
	[CrewId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[Name] [NVARCHAR](500) NOT NULL,
	[SecoundName] [NVARCHAR](500) NULL,
	[LastName] [NVARCHAR](500) NOT NULL,
	[SocialSecurityNumber] [NVARCHAR](500) NULL,
	[CrewTypeId] [BIGINT] NULL,
	[DeactivationDate] DATETIME2(7) NULL,
	[DateCreated] DATETIME2(7) CONSTRAINT [DF_air_Crew_DateCreated] DEFAULT (SYSUTCDATETIME()) NOT NULL,
	[DateUpdated] DATETIME2(7) NULL

	CONSTRAINT [PK_Crew] PRIMARY KEY CLUSTERED ([CrewId] ASC),
	CONSTRAINT [FK_Crew_CrewTypeId] FOREIGN KEY ([CrewTypeId]) REFERENCES [air].[CrewType] ([CrewTypeId])
)
