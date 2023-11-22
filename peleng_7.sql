CREATE PROCEDURE CalculateCoachRank
AS
BEGIN
    WITH coach_rank AS (
        SELECT 
            c.CoachId,
            DENSE_RANK() OVER (PARTITION BY r.CompetitionId ORDER BY r.DeclaredTime DESC) AS rank_time
        FROM 
            RESULT r 
        INNER JOIN 
            Swimmer s ON r.SwimmerId = s.SwimmerId 
        INNER JOIN 
            Coach c ON s.CoachId = c.CoachId
    )
    SELECT 
        CoachId,
        SUM(rank_time) AS total_rank
    FROM 
        coach_rank
    WHERE 
        rank_time <= 3
    GROUP BY 
        CoachId
END;

EXEC CalculateCoachRank;


