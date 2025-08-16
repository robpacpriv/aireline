CREATE TABLE [air].[FlightType]
(
	[FlightTypeId] [INT] IDENTITY(1,1) NOT NULL,
	[FlightTypeName] [NVARCHAR](500) NOT NULL, -- domestic, international

	CONSTRAINT [PK_FlightType] PRIMARY KEY CLUSTERED ([FlightTypeId] ASC),
)
