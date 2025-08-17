CREATE VIEW [ap].[vGetUserDetails]
--WITH SCHEMABINDING
	AS

SELECT
	CONCAT([U].[FirstName],' ',[U].[LastName]) AS [FullName]
	,[U].[SocialSecurityNumber]
	,[air].[fnCalculateUserFlownInLastHours] ([U].[UserId], 40) AS [FlownInLast40Hours]
	,[air].[fnCalculateUserFlownInLastDays] ([U].[UserId], 7) AS [FlownInLast7Days]
	,[air].[fnCalculateUserFlownInLastDays] ([U].[UserId], 28) AS [FlownInLast28Days]
	,[UT].[UserTypeName] AS [CrewType]
	,[US].[UserSeniorityName]
	,[U].[DeactivationDate]
FROM [air].[User] AS [U]
INNER JOIN [air].[UserToTypeToSeniority] AS [UTS]
	ON [UTS].[UserId] = [U].[UserId]
INNER JOIN [air].[UserType] AS [UT]
	ON [UT].[UserTypeId] = [UTS].[UserTypeId]
INNER JOIN [air].[UserSeniority] AS [US]
	ON [US].[UserSeniorityId] = [UTS].[UserSeniorityId];