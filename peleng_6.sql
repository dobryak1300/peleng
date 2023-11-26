CREATE OR ALTER PROCEDURE GetWinners
    @CompetitionName NVARCHAR(50) = NULL,
    @YearComp INT = NULL
AS
BEGIN
    DECLARE @ResultTable TABLE (
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        CompetitionName NVARCHAR(50),
        YearComp INT,
        WinnerComp INT,
        WinnerYear INT
    )

    DECLARE @CurrentCompetitionId INT
    DECLARE @CurrentSwimmerId INT
    DECLARE @CurrentYearComp INT
    DECLARE @Rank INT

    DECLARE CompetitionCursor CURSOR FOR
    SELECT
        C.CompetitionId,
        S.SwimmerId,
        YEAR(C.StartDate) as YearComp,
        DENSE_RANK() OVER (PARTITION BY R.Distanse, R.Style, R.CompetitionID ORDER BY R.DeclaredTime) AS Rank
    FROM 
        Result R 
    JOIN Competition C
        ON R.CompetitionId = C.CompetitionId
    JOIN Swimmer S
        ON R.SwimmerId = S.SwimmerId
    WHERE
        (@CompetitionName IS NULL OR C.CompetitionName = @CompetitionName)
        AND (@YearComp IS NULL OR YEAR(C.StartDate) = @YearComp)

    OPEN CompetitionCursor
    FETCH NEXT FROM CompetitionCursor INTO @CurrentCompetitionId, @CurrentSwimmerId, @CurrentYearComp, @Rank

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @Rank <= 3
        BEGIN
            INSERT INTO @ResultTable
            SELECT
                S.FirstName,
                S.LastName,
                C.CompetitionName,
                @CurrentYearComp as YearComp,
                @Rank as WinnerComp,
                @Rank as WinnerYear
            FROM 
                Competition C
            JOIN Swimmer S
                ON S.SwimmerId = @CurrentSwimmerId
            WHERE
                C.CompetitionId = @CurrentCompetitionId
        END

        FETCH NEXT FROM CompetitionCursor INTO @CurrentCompetitionId, @CurrentSwimmerId, @CurrentYearComp, @Rank
    END

    CLOSE CompetitionCursor
    DEALLOCATE CompetitionCursor

	SELECT FirstName,
           LastName,
           CompetitionName,
           YearComp,
           WinnerComp,
           WinnerYear
	FROM (
			SELECT ROW_NUMBER() OVER (PARTITION BY CompetitionName, YearComp, WinnerComp ORDER BY WinnerComp, WinnerYear) as num, * 
			FROM @ResultTable 
		  )A
	WHERE A.num = 1
END
