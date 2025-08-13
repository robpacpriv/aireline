CREATE TABLE [air].[Airline]
(
	[AirlineId] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AirlineName] [NVARCHAR](500) NULL,
	[DeactivationDate] DATETIME2(7) NULL,

	CONSTRAINT [PK_Airline] PRIMARY KEY CLUSTERED ([AirlineId] ASC)
)
