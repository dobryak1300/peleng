--Создайте объект для нахождения всех пловцов-победителей (1, 2 и 3 место) по двум параметрам – имя соревнования или год соревнования.  
--Понял условие как имя И год, т.к. значение CompetitionName не меняется от года и по нему невозможно установить конкретное соревнование




CREATE PROCEDURE GetWinnersByCompetitionOrYear
    @CompetitionName NVARCHAR(100) = NULL,
    @CompetitionYear INT = NULL
AS
BEGIN
    SELECT TOP 3
        r.SwimmerId 
    FROM 
        [Result] r
    LEFT JOIN Competition c ON r.CompetitionId=c.CompetitionId 
    WHERE
        (@CompetitionName IS NULL OR c.CompetitionName = @CompetitionName)
        AND (@CompetitionYear IS NULL OR YEAR(r.StartDate) = @CompetitionYear)
    ORDER BY
        DeclaredTime ASC;
END;


EXEC GetWinnersByCompetitionOrYear @CompetitionName = 'Summer Olympic Games', @CompetitionYear = 1976;
