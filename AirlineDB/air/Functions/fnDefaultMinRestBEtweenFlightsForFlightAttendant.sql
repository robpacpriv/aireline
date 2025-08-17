CREATE FUNCTION [air].[fnDefaultMinRestBEtweenFlightsForFlightAttendant]()
RETURNS INT
AS
BEGIN
    DECLARE @MinRestBEtweenFlightsForFlightAttendant INT = 9

    RETURN (@MinRestBEtweenFlightsForFlightAttendant)
END
GO