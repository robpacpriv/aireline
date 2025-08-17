CREATE FUNCTION [air].[fnCountUnderMinDefaultRestForFlightAttendant]
(
    @UserId BIGINT
)
RETURNS INT
AS
BEGIN
    DECLARE @RCountUnderMinRest INT = 0

	;WITH ForDiffInTime AS 
	(
	SELECT
		LAG([F].[ArivalDateTime]) OVER (ORDER BY [F].[ArivalDateTime] ASC) AS [PreviousArivalDateTime]
		,[F].[DepartureDateTime]
	FROM [air].[CrewHoursFlown] AS [CHF]
	--INNER JOIN [air].[User] AS [U]
	--	ON [U].[UserId] = [CHF].[UserId]
	INNER JOIN [air].[UserToTypeToSeniority] AS [UTS]
		ON [UTS].[UserId] = [CHF].[UserId]
	INNER JOIN [air].[UserType] AS [UT]
		ON [UT].[UserTypeId] = [UTS].[UserTypeId]
	INNER JOIN [air].[Flight] AS [F]
		ON [F].[FlightId] = [CHF].[FlightId]
	WHERE
		[CHF].[UserId] = @UserId
		AND [UT].[UserTypeName] = 'flight attendant'
	)
	,DiffInTime AS 
	(
	SELECT
		DATEDIFF(HOUR,[PreviousArivalDateTime], [DepartureDateTime]) AS [DiffHours]
	FROM ForDiffInTime
	)

	SELECT 
		@RCountUnderMinRest = COUNT([DiffHours])
	FROM
	DiffInTime
	WHERE
		[DiffHours] IS NOT NULL
		AND [DiffHours] < [air].[fnDefaultMinRestBEtweenFlightsForFlightAttendant]()

    RETURN (@RCountUnderMinRest)
END
GO