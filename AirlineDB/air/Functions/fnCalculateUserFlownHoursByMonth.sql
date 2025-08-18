CREATE FUNCTION [air].[fnCalculateUserFlownHoursByMonth]
(
	@UserId BIGINT,
	@MonthsAgo INT
)
RETURNS TABLE
--WITH SCHEMABINDING

RETURN
	(
	SELECT
		SUM([HoursFlown]) AS [HoursFlown]
		,[CW].[PartitionKey] AS [Month]
	FROM [air].[CrewHoursFlown] AS [CW]
	CROSS APPLY [air].[fnCalculateDateKey_inline] (DATEADD(MONTH,@MonthsAgo, SYSUTCDATETIME()), 'YYYYMM') AS [x]
	WHERE
		[CW].[PartitionKey] >= [x].[Res]
		AND [CW].[UserId] = @UserId
	GROUP BY [CW].[PartitionKey]
	);

GO