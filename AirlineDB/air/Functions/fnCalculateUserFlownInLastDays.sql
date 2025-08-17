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
		@FlownDays INT

	SET @DaysAgo = @DaysAgo * -1;
	SET @FlownDays = (
						SELECT
							SUM([HoursFlown])
						FROM [air].[CrewHoursFlown] AS [CW]
						CROSS APPLY [air].[fnCalculateDateKey_inline] (DATEADD(DAY,@DaysAgo, SYSUTCDATETIME()), 'YYYYMM') AS [x]
						WHERE
							[CW].[UserId] = @UserId
							AND [CW].[DateCreated] > DATEADD(DAY, @DaysAgo, @CurrentUTCTime)
							AND [CW].[PartitionKey] >= [x].[Res]
					)

	RETURN (@FlownDays);

END

GO