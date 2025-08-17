CREATE FUNCTION [air].[fnCountOverMaxDefaultFlightDutyForFlightAttendant]
(
    @UserId BIGINT
    ,@FlightType NVARCHAR(500)
)
RETURNS INT
AS
BEGIN
    DECLARE @RCountOverMaxFlightDuty INT = 0

	SELECT
		@RcountOverMaxFlightDuty = COUNT(CrewHoursFlownId)
	FROM [air].[CrewHoursFlown] AS [CHF]
	INNER JOIN [air].[UserToTypeToSeniority] AS [UTS]
		ON [UTS].[UserId] = [CHF].[UserId]
	INNER JOIN [air].[UserType] AS [UT]
		ON [UT].[UserTypeId] = [UTS].[UserTypeId]
	INNER JOIN [air].[Flight] AS [F]
		ON [F].[FlightId] = [CHF].[FlightId]
	INNER JOIN [air].[FlightType] AS [FT]
		ON [FT].[FlightTypeId] = [F].[FlightTypeId]
	WHERE
		[CHF].[UserId] = @UserId
		AND [UT].[UserTypeName] = 'flight attendant'
		AND [FT].[FlightTypeName] = @FlightType
		AND [CHF].[HoursFlown] > [air].[fnDefaultMaxFlightDutyForFlightAttendant](@FlightType)

    RETURN (@RCountOverMaxFlightDuty)
END
GO