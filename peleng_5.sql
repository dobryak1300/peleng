SELECT 
    R.DeclaredTime,
    R.Distanse,
    R.Style,
    BSC.SwimmerID,
    R.CompetitionId,
    C.CoachId,
    C.FirstName,
    C.LastName,
    DENSE_RANK() OVER (PARTITION BY R.Distanse, R.Style, R.CompetitionID ORDER BY R.DeclaredTime) AS Result,
    CONCAT(C.FirstName, ' ', C.LastName) AS Coach
FROM 
    Coach C
JOIN 
    (SELECT * FROM BridgeSwimmerCoach GROUP BY CoachID, SwimmerID) BSC																		-- THE TABLE ISN'T CORRECT BECAUSE OF A LOT OF DUPLICATES
    ON C.CoachId = BSC.CoachID
JOIN 
    Result R 
    ON BSC.SwimmerID = R.SwimmerId
ORDER BY 
    R.CompetitionId,
    R.Style,
    R.Distanse,
    Result;
