CREATE VIEW [ap].[vGetUserWorkedHoursPerMonth_5]
--WITH SCHEMABINDING
	AS

SELECT
	CONCAT([U].[FirstName],' ',[U].[LastName]) AS [FullName]
	,[U].[SocialSecurityNumber]
	,[UT].[UserTypeName] AS [CrewType]
	,[US].[UserSeniorityName]
	,[U].[DeactivationDate] AS [UserDeactivationDate]
	,[X].[HoursFlown]
	,[X].[Month]
FROM [air].[User] AS [U]
CROSS APPLY [air].[fnCalculateUserWorkingHoursByMonth] ( [U].[UserId], -1) AS [X]
INNER JOIN [air].[UserToTypeToSeniority] AS [UTS]
	ON [UTS].[UserId] = [U].[UserId]
INNER JOIN [air].[UserType] AS [UT]
	ON [UT].[UserTypeId] = [UTS].[UserTypeId]
INNER JOIN [air].[UserSeniority] AS [US]
	ON [US].[UserSeniorityId] = [UTS].[UserSeniorityId];