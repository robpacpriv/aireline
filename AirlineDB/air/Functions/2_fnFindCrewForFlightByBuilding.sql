CREATE FUNCTION [air].[fnFindCrewForFlightByBuilding]
(	
	@FlightId BIGINT,
	@BuildingId BIGINT
)
RETURNS TABLE
--WITH SCHEMABINDING

RETURN
	(

	SELECT
		[U].[UserId]
		,CONCAT([U].[FirstName],' ',[U].[LastName]) AS [FullName]
		,[U].[SocialSecurityNumber]
		,[UT].[UserTypeName] AS [CrewType]
		,[US].[UserSeniorityName]
		,[U].[DeactivationDate]
		,[air].[fnCalculateUserFlownInLastHours] ([U].[UserId], 672) AS [FlownInLast672Hours (Limit 100)]
		,[air].[fnCalculateUserFlownInLastDays] ([U].[UserId], 365) AS [FlownInLast365Days (Limit 1000)]
		,[air].[fnCalculateUserFlownInLastConsecutiveHours] ([U].[UserId], 168) AS [FlownInLast168ConsecutiveHours (Limit 60)]
		,[air].[fnCalculateUserFlownInLastConsecutiveHours] ([U].[UserId], 672) AS [FlownInLast365ConsecutiveHoursDays (Limit 190)]
		,[air].[fnCountOverMaxDefaultFlightDutyForFlightAttendant] ([U].[UserId], 'domestic') AS [CountOverMaxDefaultDomesticFlightDutyForFlightAttendant]
		,[air].[fnCountOverMaxDefaultFlightDutyForFlightAttendant] ([U].[UserId], 'international') AS [CountOverMaxDefaultInternationalFlightDutyForFlightAttendant]
		,[air].[fnCountUnderMinDefaultRestForFlightAttendant] ([U].[UserId]) AS [CountUnderMinDefaultRestForFlightAttendant]
		,[air].[fnCountUserRestByFlight] (@FlightId,[U].[UserId]) AS [RestInHoursFromLastFlight]
	FROM [air].[User] AS [U]
	INNER JOIN [air].[UserToTypeToSeniority] AS [UTS]
		ON [UTS].[UserId] = [U].[UserId]
	INNER JOIN [air].[UserType] AS [UT]
		ON [UT].[UserTypeId] = [UTS].[UserTypeId]
	INNER JOIN [air].[UserSeniority] AS [US]
		ON [US].[UserSeniorityId] = [UTS].[UserSeniorityId]
	WHERE
		[U].[BuildingId] = @BuildingId
		AND
			(
			[air].[fnCalculateUserFlownInLastHours] ([U].[UserId], 672) < 100
			OR [air].[fnCalculateUserFlownInLastDays] ([U].[UserId], 365) < 1000
			OR [air].[fnCalculateUserFlownInLastConsecutiveHours] ([U].[UserId], 168) < 60
			OR [air].[fnCalculateUserFlownInLastConsecutiveHours] ([U].[UserId], 672) < 190
			OR [air].[fnCheckIfFlightHoursFitsUserWorkingHours] (@FlightId,[U].[UserId]) > 0
			OR [air].[fnCountUserRestByFlight] (@FlightId,[U].[UserId]) >= [air].[fnDefaultMinRestBetweenFlightsForFlightAttendant]()
			)

	);

GO