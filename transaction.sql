/*
A clerk creating a new ballot:
*/
START TRANSACTION;
INSERT INTO Ballots (Ballot_Name, B_ID_NUM, Question_Text, Available_Period, Answers)
VALUES ('New Ballot', 5, 'New Question?', '2024-05-10 23:59:59', 'Option1,Option2');
COMMIT;

/*
A folk registering to vote for a ballot:
*/
START TRANSACTION;
INSERT INTO Voting_Registry (Center_Name, V_ID_Num, Ballot_Name, Voting_Date)
VALUES ('Springfield Center A', 6, 'New Ballot', '2024-05-10');
COMMIT;

/*
A clerk modifying the availability period of a current ballot:
*/
START TRANSACTION;
UPDATE Ballots 
SET Available_Period = '2024-06-10 23:00:00' 
WHERE Ballot_Name = 'New Ballot';
COMMIT;

/*
A voter casting a ballot while confirming a valid voting registration by a monitor:
*/
START TRANSACTION;
-- Confirming a valid voting registration
SELECT * FROM Voting_Registry 
WHERE V_ID_Num = 6 AND Ballot_Name = 'New Ballot' AND Voting_Date = '2024-05-10';

-- If the above query returns a valid registration, proceed to cast a vote
INSERT INTO Cast_Votes (Voter_ID, Ballot_Name, Question_Text, Answer, Vote_Time)
VALUES (6, 'New Ballot', 'New Question?', 'Option1', '2024-05-10 12:30:00');
COMMIT;

/*
A staff removing a folk (and all their associated information):
This script first finds the Center_Name(s) associated with the 
folk in the voting_registry, then deletes those entries from voting_centers, 
and only then proceeds to delete the entries from voting_registry.
*/
START TRANSACTION;

-- Deleting all associated information
DELETE FROM Residencies WHERE ID_Num = 6;
DELETE FROM Email WHERE ID_Num = 6;

-- Get the Center_Name(s) for this folk
SET @centers = (SELECT GROUP_CONCAT(DISTINCT Center_Name) FROM Voting_Registry WHERE V_ID_Num = 6);

-- Delete from Voting_Centers
DELETE FROM Voting_Centers WHERE FIND_IN_SET(Center_Name, @centers) > 0;

-- Now you can safely delete from Voting_Registry
DELETE FROM Voting_Registry WHERE V_ID_Num = 6;

DELETE FROM Cast_Votes WHERE Voter_ID = 6;
DELETE FROM Election_Staff WHERE ES_ID_Num = 6;

-- Deleting the folk
DELETE FROM Folks WHERE ID_Num = 6;

COMMIT;

