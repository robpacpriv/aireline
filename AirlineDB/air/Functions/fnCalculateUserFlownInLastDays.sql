CREATE FUNCTION [air].[fnCalculateUserFlownInLastDays]
(	
	@UserId BIGINT,
	@DaysAgo INT
)
RETURNS INT
AS
BEGIN
	DECLARE
		@CurrentUTCTime DATETIME2(7) = SYSUTCDATETIME(),
		@FlownHours INT

	SET @DaysAgo = @DaysAgo * -1;
	SET @FlownHours = (SELECT SUM([HoursWorked]) FROM [air].[CrewHoursWorked] AS [CW] CROSS APPLY [air].[fnCalculateDateKey_inline] (DATEADD(DAY,-1, SYSDATETIME()), 'YYYYMM') x WHERE [CW].[UserId] = @UserId AND [CW].[DateCreated] > DATEADD(HOUR, @DaysAgo, @CurrentUTCTime) AND [CW].[PartitionKey] >= [x].[Res] )

	RETURN (@FlownHours);

END

GO