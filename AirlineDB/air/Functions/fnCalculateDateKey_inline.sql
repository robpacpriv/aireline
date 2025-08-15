CREATE FUNCTION [air].[fnCalculateDateKey_inline]
(
	@datetime DATETIME2(7),
	@format NVARCHAR(10)
)
RETURNS TABLE
WITH SCHEMABINDING
RETURN(
	
	SELECT
		CAST(
			REPLACE(
						REPLACE(
								REPLACE(
											REPLACE (@format, 'dd', t.DateKey),
											'mm', t.MonthKey
										),
								'yyyy',
								t.YearKey
								),
						'hh',
						t.HourKey
				) AS INT) AS Res
	FROM (
		SELECT
		DateKey		= RIGHT(CONCAT('0', DATEPART(dd, @datetime)), 2),
		MonthKey	= RIGHT(CONCAT('0', DATEPART(mm, @datetime)), 2),
		YearKey		= DATEPART(yy, @datetime),
		HourKey		= RIGHT(CONCAT('0', DATEPART(hh, @datetime)), 2)) t

);

GO