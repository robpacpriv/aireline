CREATE VIEW [ap].[vUserDetails]
	AS

	SELECT
		CONCAT([U].[FirstName],' ',[U].[LastName]) AS [FullName]
		,[U].[SocialSecurityNumber]

	


	FROM [air].[User] AS [U]
	LEFT JOIN [air].[FlightCrew] AS [FC]
		ON [FC].[UserId] = [U].[UserId]