CREATE OR ALTER PROCEDURE TopCoachRank
AS
BEGIN
    WITH Rating AS (
        SELECT
            Coach,
            SUM(CASE WHEN Rnk = 1 THEN 3
                     WHEN Rnk = 2 THEN 2
                     WHEN Rnk = 3 THEN 1
                     ELSE 0 END) AS RatingSum
        FROM (
            SELECT
                CONCAT(C.FirstName, ' ', C.LastName) AS Coach,
                ROW_NUMBER() OVER (PARTITION BY R.CompetitionID, R.Style, R.Distanse ORDER BY R.DeclaredTime) AS Rnk
            FROM
                Coach C
            JOIN 
                (SELECT * FROM BridgeSwimmerCoach GROUP BY CoachID, SwimmerID) BSC 
                ON C.CoachId = BSC.CoachID
            JOIN
                Result R 
                ON BSC.SwimmerID = R.SwimmerId
        ) a
        GROUP BY
            Coach
    )
    SELECT TOP 10
        Coach,
        RatingSum
    FROM
        Rating
    ORDER BY
        RatingSum DESC, Coach;
END;

--EXEC TopCoachRank
