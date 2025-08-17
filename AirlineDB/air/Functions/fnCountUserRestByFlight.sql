CREATE FUNCTION [air].[fnCountUserRestByFlight]
(
    @FlightId BIGINT
	,@UserId BIGINT
)
RETURNS INT
AS
BEGIN
    DECLARE @CountUserRestByFlight INT = 0

	DECLARE @PreviousArivalDateTime DATETIME2(7)

	SET @PreviousArivalDateTime = 
		(
		SELECT
			TOP 1 [F].[ArivalDateTime]
		FROM [air].[Flight] AS [F]
		INNER JOIN [air].[CrewHoursFlown] AS [CHF]
			ON [CHF].[FlightId] = [F].[FlightId]
		WHERE [CHF].[UserId] = @UserId
		)
	
	SET @CountUserRestByFlight =
		(
		SELECT
			ISNULL(DATEDIFF(HOUR, @PreviousArivalDateTime, [F].[DepartureDateTime]),[air].[fnDefaultMinRestBetweenFlightsForFlightAttendant]())
		FROM [air].[Flight] AS [F]
		WHERE
			[F].[FlightId] = @FlightId
		)

    RETURN (@CountUserRestByFlight)
END
GO