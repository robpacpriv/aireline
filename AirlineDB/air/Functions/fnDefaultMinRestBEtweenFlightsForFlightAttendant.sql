CREATE FUNCTION [air].[fnDefaultMinRestBetweenFlightsForFlightAttendant]()
RETURNS INT
AS
BEGIN
    DECLARE @MinRestBetweenFlightsForFlightAttendant INT = 9

    RETURN (@MinRestBetweenFlightsForFlightAttendant)
END
GO