CREATE VIEW [air].[vCrew]
	AS

	SELECT
		CONCAT([C].[Name],' ',[C].[LastName]) AS [FullName]
		,[C].[SocialSecurityNumber]

	


	FROM [air].[Crew] AS [C]