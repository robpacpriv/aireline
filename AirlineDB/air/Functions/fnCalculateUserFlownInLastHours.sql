CREATE FUNCTION [air].[fnCalculateUserFlownInLastHours]
(	
	@UserId BIGINT,
	@HoursAgo INT
)
RETURNS INT
AS
BEGIN
	DECLARE
		@CurrentUTCTime DATETIME2(7) = SYSUTCDATETIME(),
		@FlownHours INT

	SET @FlownHours = (SELECT SUM([HoursWorked]) FROM [air].[CrewHoursWorked] AS [CW] CROSS APPLY [air].[fnCalculateDateKey_inline] (DATEADD(HOUR,-1, SYSDATETIME()), 'YYYYMM') x WHERE [CW].[UserId] = @UserId AND [CW].[DateCreated] > DATEADD(HOUR, @HoursAgo, @CurrentUTCTime) AND [CW].[PartitionKey] >= [x].[Res] )

	RETURN (@FlownHours);

END

GO