/*
The count of residents is based on the unique
V_ID_Num values in the Voting_Registry table for each city. 
*/
SELECT 
    P.City, P.State, 
    COUNT(DISTINCT VR.V_ID_Num) AS Residents 
FROM 
    Places P 
JOIN 
    Voting_Centers VC ON P.Address = VC.Address 
JOIN 
    Voting_Registry VR ON VC.Center_Name = VR.Center_Name
GROUP BY 
    P.City, P.State
HAVING 
    Residents > 0 
ORDER BY 
    Residents DESC;
    
/*
The given SQL query retrieves data from the "Folks," "Residencies," "Places," and "Email" tables.
*/
SELECT 
    f.First_Name, f.Last_Name, p.City, e.email_address
FROM
    Folks f
JOIN
    Residencies r ON f.ID_Num = r.ID_Num
JOIN
    Places p ON r.Address = p.Address
JOIN
    Email e ON f.ID_Num = e.ID_Num
GROUP BY
    f.First_Name, f.Last_Name, p.City, e.email_address;
    
/*
list each state along with its number of currently inhabited places, 
including states with no inhabited places, in increasing alphabetical order.
*/
SELECT
    p.State,
    COUNT(DISTINCT p.Address) AS Num_Of_Places
FROM
    Places p
LEFT JOIN
    Residencies r ON p.Address = r.Address
GROUP BY
    p.State
ORDER BY
    p.State ASC;
    
/*
This query will return the distinct identifiers (V_ID_Num) of
the folks who registered at 'Springfield Center A' between 
'2023-05-10' and '2023-06-10'. 
*/
SELECT DISTINCT V.V_ID_Num
FROM Voting_Registry V
WHERE V.Center_Name = 'Springfield Center A' AND V.Voting_Date BETWEEN '2023-05-10' AND '2023-06-10';


/*
Springfield A are megapolis centers, Springfield center B are the ones 
within 5 miles and Greenville has the excluded centers.
*/
SELECT COUNT(DISTINCT VR.V_ID_Num) AS Unique_Registrations
FROM Voting_Registry VR
JOIN Voting_Centers VC ON VR.Center_Name = VC.Center_Name
JOIN Places P ON VC.Address = P.Address
WHERE MONTH(VR.Voting_Date) = 5 AND YEAR(VR.Voting_Date) = 2023
AND (VC.Center_Name = 'Springfield Center A' OR VC.Center_Name = 'Springfield Center B')
AND VC.Center_Name NOT LIKE 'Greenville%';
   
/*
 Below is a possible MySQL query that could be used to find the most popular 
 voting center(s) (in terms of total number of registrations) in a given time 
 period among those in a random city from the loaded data.
*/
SELECT 
    VC.Center_Name, 
    COUNT(VR.V_ID_Num) AS Total_Registrations,
    P.City
FROM 
    Voting_Registry VR
    JOIN Voting_Centers VC ON VR.Center_Name = VC.Center_Name
    JOIN Places P ON VC.Address = P.Address
WHERE 
    VR.Voting_Date BETWEEN '2023-05-10' AND '2023-06-19'
GROUP BY 
    VC.Center_Name, P.City
ORDER BY 
    Total_Registrations DESC
LIMIT 1;

/*
Combines multiple JOINs, a GROUP BY clause, and a HAVING clause to find 
unique folks that have valid registrations with every voting center in a given state.
*/
SELECT 
    F.First_Name, F.Last_Name 
FROM 
    Folks F
JOIN 
    Voting_Registry VR ON F.ID_Num = VR.V_ID_Num
JOIN 
    Voting_Centers VC ON VR.Center_Name = VC.Center_Name
JOIN 
    Places P ON VC.Address = P.Address
WHERE 
    P.State = 'Megapolis'
GROUP BY 
    F.ID_Num, F.First_Name, F.Last_Name
HAVING 
    COUNT(DISTINCT VC.Center_Name) = (
        SELECT 
            COUNT(DISTINCT VC.Center_Name) 
        FROM 
            Voting_Centers VC
        JOIN 
            Places P ON VC.Address = P.Address
        WHERE 
            P.State = 'Megapolis'
    );

/*
Calculate the distance to all voting centers and find the closest one using a self join.
*/
SELECT 
    F.ID_Num, F.First_Name, F.Last_Name, VR.Center_Name AS Registered_Center, VC1.Center_Name AS Closest_Center
FROM 
    Folks F
JOIN 
    Residencies R ON F.ID_Num = R.ID_Num
JOIN 
    Places P ON R.Address = P.Address
JOIN 
    Voting_Registry VR ON F.ID_Num = VR.V_ID_Num
JOIN 
    Voting_Centers VC1 ON VR.Center_Name = VC1.Center_Name
JOIN 
    Voting_Centers VC2 ON VC2.Center_Name = (
        SELECT 
            Center_Name 
        FROM 
            Voting_Centers 
        ORDER BY 
            ST_Distance(P.XY_Coordinates, XY_Coordinates) ASC 
        LIMIT 1
    )
WHERE 
    ST_Distance(P.XY_Coordinates, VC1.XY_Coordinates) > ST_Distance(P.XY_Coordinates, VC2.XY_Coordinates)
ORDER BY 
    VC1.Center_Name ASC;

/*
This function will now return the acronym of the center closest to the given
folk's residence that is operating at the given date and time. If no such 
center exists, it will return NULL.
*/
DELIMITER //
CREATE FUNCTION GetClosestCenter(folk_id INT, given_date DATE) RETURNS VARCHAR(50)
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE closest_center_acronym VARCHAR(50);

  SELECT VC.Center_Name
  INTO closest_center_acronym
  FROM Residencies R
  JOIN Places P ON R.Address = P.Address
  JOIN Voting_Centers VC ON ST_Distance(P.XY_Coordinates, VC.XY_Coordinates) > 0
  JOIN Ballots B ON VC.Center_Name = B.Ballot_Name
  WHERE R.ID_Num = folk_id AND
        TIME(given_date) BETWEEN VC.Time AND TIME(B.Available_Period)
  ORDER BY ST_Distance(P.XY_Coordinates, VC.XY_Coordinates) ASC, VC.Center_Name ASC
  LIMIT 1;

  RETURN closest_center_acronym;
END //
DELIMITER ;

/*
This procedure will create a dynamic pivot table that shows the 
number of votes for each option of the given ballot, broken down
by voting center.
*/
DELIMITER //
CREATE PROCEDURE BallotCrossTabulation(IN ballot_name VARCHAR(50))
BEGIN
    SET @sql = NULL;

    SELECT GROUP_CONCAT(DISTINCT
        CONCAT(
            'SUM(IF(CV.Answer = ''',
            Answer,
            ''', 1, 0)) AS ',
            REPLACE(Answer, ' ', '_')
        )
    ) INTO @sql
    FROM Cast_Votes CV
    WHERE CV.Ballot_Name = ballot_name;

    IF @sql IS NOT NULL THEN
        SET @sql = CONCAT('SELECT VC.Center_Name, ', @sql, ' 
                          FROM Cast_Votes CV
                          JOIN Voting_Registry VR ON VR.V_ID_Num = CV.Voter_ID
                          JOIN Voting_Centers VC ON VC.Center_Name = VR.Center_Name
                          WHERE CV.Ballot_Name = ''', ballot_name, '''
                          AND TIME(CV.Vote_Time) = VC.Time
                          GROUP BY VC.Center_Name');

        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END //
DELIMITER ;



