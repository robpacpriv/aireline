CREATE FUNCTION [air].[fnDefaultMaxFlightDutyForFlightAttendant]
(
    @FlightType NVARCHAR(500)
)
RETURNS INT
AS
BEGIN
    DECLARE @MaxFlightDutyHours INT = 0

    IF @FlightType = 'domestic'
        SET @MaxFlightDutyHours = 14
    IF @FlightType = 'international'
        SET @MaxFlightDutyHours = 20

    RETURN (@MaxFlightDutyHours)
END
GO