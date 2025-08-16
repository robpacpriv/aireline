CREATE FUNCTION [air].[fnCalculateUserWorkingHoursByMonth]
(
	@UserId BIGINT,
	@MonthsAgo INT
)
RETURNS TABLE
--WITH SCHEMABINDING

RETURN
	(
	SELECT
		SUM([HoursWorked]) AS [HoursWorked]
		,[CW].[PartitionKey] AS [MONTH]
	FROM [air].[CrewHoursWorked] AS [CW]
	CROSS APPLY [air].[fnCalculateDateKey_inline] (DATEADD(MONTH,@MonthsAgo, SYSUTCDATETIME()), 'YYYYMM') AS [x]
	WHERE
		[CW].[PartitionKey] >= [x].[Res]
		AND [CW].[UserId] = @UserId
		GROUP BY [CW].[PartitionKey]
	);

GO