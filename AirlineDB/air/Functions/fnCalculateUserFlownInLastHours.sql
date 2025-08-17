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

	SET @HoursAgo = @HoursAgo * -1;
	SET @FlownHours = (
						SELECT
							SUM([HoursFlown])
						FROM [air].[CrewHoursFlown] AS [CW]
						CROSS APPLY [air].[fnCalculateDateKey_inline] (DATEADD(HOUR,@HoursAgo, SYSUTCDATETIME()), 'YYYYMM') AS [x]
						WHERE
							[CW].[UserId] = @UserId
							AND [CW].[DateCreated] > DATEADD(HOUR, @HoursAgo, @CurrentUTCTime)
							AND [CW].[PartitionKey] >= [x].[Res]
						)

	IF @FlownHours IS NULL
		SET @FlownHours = 0;

	RETURN (@FlownHours);

END

GO