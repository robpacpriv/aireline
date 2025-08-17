CREATE VIEW [ap].[vGetFlightDetails]
--WITH SCHEMABINDING
AS

SELECT
	[AR].[AirlineName]
	,[F].[FlightNumber]
	,[F].[DepartureDateTimePlanned]
	,[DepartureC].[CityName] AS [DepartureCity]
	,[F].[ArivalDateTimePlanned]
	,[ArivalC].[CityName] AS [ArivalCity]
	,DATEDIFF(MINUTE,[F].[DepartureDateTime], [F].[ArivalDateTime]) AS [FlightDuration (minutes)]
	,DATEDIFF(MINUTE,[F].[DepartureDateTimePlanned], [F].[ArivalDateTimePlanned]) AS [FlightDurationPlanned (minutes)]
	,DATEDIFF(HOUR,[F].[DepartureDateTime], [F].[ArivalDateTime]) AS [FlightDuration (hours)]
	,DATEDIFF(HOUR,[F].[DepartureDateTimePlanned], [F].[ArivalDateTimePlanned]) AS [FlightDurationPlanned (hours)]
FROM [air].[Flight] AS [F]
INNER JOIN [air].[Aircraft] AS [AC]
	ON [AC].[AircraftId] = [F].[AircraftId]
INNER JOIN [air].[Airline] AS [AR]
	ON [AR].[AirlineId] = [AC].[AirlineId]
INNER JOIN [air].[Building] AS [DepartureB]
	ON [DepartureB].[BuildingId] = [F].[DepartureAirportId]
INNER JOIN [air].[City] AS [DepartureC]
	ON [DepartureC].[CityId] = [DepartureB].[CityId]
INNER JOIN [air].[Building] AS [ArivalB]
	ON [ArivalB].[BuildingId] = [F].[ArivalAirportId]
INNER JOIN [air].[City] AS [ArivalC]
	ON [ArivalC].[CityId] = [ArivalB].[CityId]
WHERE
	[F].[DeactivationDate] IS NULL;