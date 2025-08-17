CREATE FUNCTION [air].[fnCalculateUserFlownInLastConsecutiveHours]
(	
	@UserId BIGINT,
	@ConsecutiveHoursAgo INT
)
RETURNS INT
AS
BEGIN

	DECLARE @i INT = 1;
	DECLARE @MaxI INT = 0;
	DECLARE @SumHours DECIMAL(10,2) = 0;
	DECLARE @GetUTCDateTime DATETIME2(7) = SYSUTCDATETIME();
	DECLARE @FoundStartDate DATETIME2(7);
	DECLARE @FoundEndDate DATETIME2(7);
	DECLARE @FoundDate DATETIME2(7);
	DECLARE @FlownConsecutiveHours INT;

	DECLARE @WorkTable AS TABLE ([StartDate] DATETIME2(7), [EndDate] DATETIME2(7), [DurationHours] DECIMAL(10,2), [Position] BIGINT);
	DECLARE @FinalTable AS TABLE ([DepartureDateTime] DATETIME2(7), [ArivalDateTime] DATETIME2(7))

		INSERT INTO @WorkTable ([StartDate], [EndDate], [DurationHours], [Position])
		SELECT
			[UWH].[StartDate],
			CASE WHEN [UWH].[EndDate] > @GetUTCDateTime THEN @GetUTCDateTime ELSE [UWH].[EndDate] END AS [EndDate]
			,DATEDIFF(HOUR, [UWH].[StartDate], COALESCE([UWH].[EndDate], @GetUTCDateTime)) AS [DurationHours]
			,ROW_NUMBER() OVER (PARTITION BY [UWH].[UserId] ORDER BY [UWH].[EndDate] DESC) AS [Position]
		FROM [air].[UserWorkingHours] AS [UWH]
		WHERE
			[UWH].[StartDate] <= @GetUTCDateTime
			AND [UWH].[UserId] = @UserId

	SET @MaxI = (SELECT MAX([Position]) FROM @WorkTable);

	WHILE @i <= @MaxI
	BEGIN
		SET @SumHours = @SumHours + ISNULL((SELECT [DurationHours] FROM @WorkTable WHERE [Position] = @i),0)

		SELECT
			@FoundStartDate = [StartDate]
			,@FoundEndDate = [EndDate]
		FROM @WorkTable
		WHERE
			[Position] = @i

		SET @i = @i + 1;
	END

	SET @FoundDate = (SELECT DATEADD(HOUR, (@SumHours-@ConsecutiveHoursAgo) ,@FoundStartDate))

	INSERT INTO @FinalTable ([DepartureDateTime], [ArivalDateTime])
	SELECT 
		CASE
			WHEN @FoundDate >= [F].[DepartureDateTime] AND @FoundDate < [F].[ArivalDateTime] THEN @FoundDate
			ELSE [F].[DepartureDateTime]
		END AS [DepartureDateTime]
		,[F].[ArivalDateTime]
	FROM [air].[CrewHoursFlown] AS [CHF]
	CROSS APPLY [air].[fnCalculateDateKey_inline] ( DATEADD(DAY,-@ConsecutiveHoursAgo, SYSUTCDATETIME()) , 'YYYYMM') AS [X]
	INNER JOIN [air].[Flight] AS [F]
		ON [F].[FlightId] = [CHF].[FlightId]
	WHERE
		[F].[PartitionKey] >= [X].[Res]
		AND [CHF].[UserId] = @UserId
		AND [F].[ArivalDateTime] >= @FoundDate
		AND [F].[DeactivationDate] IS NULL
		AND [F].[DepartureDateTime] IS NOT NULL
		AND [F].[ArivalDateTime] IS NOT NULL;

	SET @FlownConsecutiveHours = (SELECT  SUM(DATEDIFF(HOUR,[DepartureDateTime], [ArivalDateTime])) FROM @FinalTable);

	RETURN (@FlownConsecutiveHours);

END

GO
