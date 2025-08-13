CREATE TABLE [air].[FlightCrew]
(
	[FlightId] [BIGINT] NOT NULL,
	[CrewId] [BIGINT] NOT NULL,

	CONSTRAINT [PK_FlightCrew] PRIMARY KEY CLUSTERED ([FlightId] ASC, [CrewId] ASC),
	CONSTRAINT [FK_FlightCrew_FlightId] FOREIGN KEY ([FlightId]) REFERENCES [air].[Flight] ([FlightId]),
	CONSTRAINT [FK_FlightCrew_CrewId] FOREIGN KEY ([CrewId]) REFERENCES [air].[Crew] ([CrewId])
)
