CREATE FUNCTION [air].[fnCheckIfFlightHoursFitsUserWorkingHours]
(
    @FlightId BIGINT
	,@UserId BIGINT
)
RETURNS INT
AS
BEGIN
    DECLARE @MinRestBetweenFlightsForFlightAttendant INT

	DECLARE @DepartureDateTimePlanned DATETIME2(7)
	DECLARE @ArivalDateTimePlanned DATETIME2(7)

	SELECT TOP 1
		@DepartureDateTimePlanned = [DepartureDateTimePlanned]
		,@ArivalDateTimePlanned = [ArivalDateTimePlanned]
	FROM [air].[Flight] AS [F]
	WHERE
		[F].[DeactivationDate] IS NULL
		AND [F].[FlightId] = @FlightId

    SET @MinRestBetweenFlightsForFlightAttendant =
        (
		SELECT
			[CWH].[UserWorkingHoursId]
		FROM [air].[UserWorkingHours] AS [CWH]
		WHERE
			[CWH].[UserID] = @UserId
			AND [CWH].[StartDate] <= @DepartureDateTimePlanned
			AND [CWH].[EndDate] >= @ArivalDateTimePlanned
        )

    RETURN (@MinRestBetweenFlightsForFlightAttendant)
END
GO