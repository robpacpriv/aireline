CREATE VIEW [ap].[vGetUserNotFollowingRules]
--WITH SCHEMABINDING
AS

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
FROM [air].[User] AS [U]
INNER JOIN [air].[UserToTypeToSeniority] AS [UTS]
	ON [UTS].[UserId] = [U].[UserId]
INNER JOIN [air].[UserType] AS [UT]
	ON [UT].[UserTypeId] = [UTS].[UserTypeId]
INNER JOIN [air].[UserSeniority] AS [US]
	ON [US].[UserSeniorityId] = [UTS].[UserSeniorityId]
--ORDER BY
--	[FlownInLast672Hours (Limit 100)] DESC
--	,[FlownInLast365Days (Limit 1000)] DESC
--	,[FlownInLast168ConsecutiveHours (Limit 60)] DESC
--	,[FlownInLast365ConsecutiveHoursDays (Limit 190)] DESC
--	,[CountOverMaxDefaultDomesticFlightDutyForFlightAttendant] DESC
--	,[CountOverMaxDefaultInternationalFlightDutyForFlightAttendant] DESC
--	,[CountUnderMinDefaultRestForFlightAttendant] DESC