CREATE TABLE [air].[CrewType]
(
	[CrewTypeId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[CrewTypeName] [NVARCHAR](500) NOT NULL, -- flight attendant / journeyman / senior
	[CrewSeniority] [NVARCHAR](500) NOT NULL, -- trainee / pilot

	CONSTRAINT [PK_CrewType] PRIMARY KEY CLUSTERED ([CrewTypeId] ASC),
)
