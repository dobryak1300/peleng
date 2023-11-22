--Решил, что рангом тренера будет показатель лучшего места его пловцов


WITH coach_rank AS (
    SELECT 
        c.CoachId,
        c.FirstName,
        c.LastName,
        DENSE_RANK() OVER (PARTITION BY r.CompetitionId ORDER BY r.DeclaredTime ASC) AS rank_time
    FROM 
        RESULT r 
    INNER JOIN 
        Swimmer s ON r.SwimmerId = s.SwimmerId 
    INNER JOIN 
        Coach c ON s.CoachId = c.CoachId
)
SELECT 
    CoachId,
    CONCAT(FirstName, ' ', LastName) AS Coach,
    MIN(rank_time) AS CoachRank
FROM 
    coach_rank
GROUP BY 
    CoachId, FirstName, LastName
