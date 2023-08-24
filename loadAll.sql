-- Insert 12 folks
INSERT INTO Folks (ID_Num, First_Name, Last_Name, Nickname, DOB, Phone_Number)
VALUES (1, 'John', 'Doe', 'Johnny', '1985-03-15', '555-123-4567'),
(2, 'Jane', 'Doe', 'Janey', '1990-07-30', '555-987-6543'),
(3, 'Michael', 'Smith', 'Mike', '1975-12-25', '555-555-5555'),
(4, 'Sarah', 'Johnson', 'Sar', '1995-06-01', '555-444-3333'),
(5, 'William', 'Brown', 'Will', '1980-09-14', '555-111-2222'),
(6, 'Emma', 'Davis', 'Em', '1989-01-22', '555-888-9999'),
(7, 'James', 'Miller', 'Jim', '1987-04-20', '555-666-7777'),
(8, 'Olivia', 'Wilson', 'Liv', '1998-11-12', '555-333-1111'),
(9, 'Lucas', 'Taylor', 'Luke', '2000-10-05', '555-222-4444'),
(10, 'Ava', 'Thomas', 'Av', '1999-05-03', '555-999-8888'),
(11, 'Ethan', 'Moore', 'E', '1992-06-15', '555-777-6666'),
(12, 'Mia', 'Jackson', 'Mimi', '1997-02-28', '555-555-5555');

-- Insert 6 staff
INSERT INTO Election_Staff (ES_ID_Num, Clerks, Monitors)
VALUES (1, 'Clerk 1', 'Monitor 1'),
(2, 'Clerk 2', 'Monitor 2'),
(3, 'Clerk 3', 'Monitor 3'),
(4, 'Clerk 4', 'Monitor 4'),
(5, 'Clerk 5', 'Monitor 5'),
(6, 'Clerk 6', 'Monitor 6');

-- Insert 6 places
INSERT INTO Places (Address, Street_Number, Street_Name, City, State, Zip_Code, XY_Coordinates)
VALUES
  ('A0001', '123', 'Main St', 'Springfield', 'Megapolis', '10001', ST_GeomFromText('POINT(40.7128 -74.0060)')),
  ('A0002', '456', 'Market St', 'Springfield', 'Megapolis', '10002', ST_GeomFromText('POINT(40.7130 -74.0072)')),
  ('A0003', '789', 'Broadway', 'Springfield', 'Megapolis', '10003', ST_GeomFromText('POINT(40.7132 -74.0084)')),
  ('A0004', '321', 'Oak St', 'Greenville', 'Mayorca', '20001', ST_GeomFromText('POINT(32.7767 -96.7970)')),
  ('A0005', '654', 'Pine St', 'Greenville', 'Mayorca', '20002', ST_GeomFromText('POINT(32.7769 -96.7972)')),
  ('A0006', '987', 'Elm St', 'Greenville', 'Mayorca', '20003', ST_GeomFromText('POINT(32.7771 -96.7974)'));

  
  -- Insert 24 voting registrations into 3 ballots
INSERT INTO Voting_Registry (Center_Name, V_ID_Num, Ballot_Name, Voting_Date)
VALUES
  -- Center A in Springfield
  ('Springfield Center A', 1, 'Ballot 1', '2023-05-10'),
  ('Springfield Center A', 2, 'Ballot 1', '2023-05-10'),
  ('Springfield Center A', 3, 'Ballot 1', '2023-05-12'),
  ('Springfield Center A', 4, 'Ballot 1', '2023-05-11'),
  ('Springfield Center A', 5, 'Ballot 2', '2023-05-13'),
  ('Springfield Center A', 6, 'Ballot 2', '2023-05-14'),
  ('Springfield Center A', 7, 'Ballot 3', '2023-05-15'),
  ('Springfield Center A', 8, 'Ballot 3', '2023-05-17'),
  
  -- Center B in Springfield
  ('Springfield Center B', 9, 'Ballot 1', '2023-06-10'),
  ('Springfield Center B', 10, 'Ballot 1', '2023-06-11'),
  ('Springfield Center B', 11, 'Ballot 1', '2023-06-14'),
  ('Springfield Center B', 12, 'Ballot 2', '2023-06-13'),
  ('Springfield Center B', 1, 'Ballot 2', '2023-06-12'),
  ('Springfield Center B', 2, 'Ballot 2', '2023-06-19'),
  ('Springfield Center B', 3, 'Ballot 3', '2023-06-18'),
  ('Springfield Center B', 4, 'Ballot 3', '2023-06-10'),
  
  -- Center A in Greenville
  ('Greenville Center A', 5, 'Ballot 1', '2023-05-10'),
  ('Greenville Center A', 6, 'Ballot 1', '2023-05-13'),
  ('Greenville Center A', 7, 'Ballot 1', '2023-05-14'),
  ('Greenville Center A', 8, 'Ballot 2', '2023-05-15'),
  ('Greenville Center A', 9, 'Ballot 2', '2023-05-16'),
  ('Greenville Center A', 10, 'Ballot 2', '2023-05-17'),
  ('Greenville Center A', 11, 'Ballot 3', '2023-05-19'),
  ('Greenville Center A', 12, 'Ballot 3', '2023-05-12');

-- Insert data into Voting_Centers
INSERT INTO Voting_Centers (XY_Coordinates, Center_Name, Address, Time)
VALUES
  (ST_GeomFromText('POINT(39.764 -104.872)'), 'Springfield Center A', 'A0001', '08:00:00'),
  (ST_GeomFromText('POINT(39.764 -104.873)'), 'Springfield Center A', 'A0001', '12:00:00'),
  (ST_GeomFromText('POINT(39.764 -104.874)'), 'Springfield Center A', 'A0001', '16:00:00'),
  (ST_GeomFromText('POINT(39.764 -104.875)'), 'Springfield Center A', 'A0001', '20:00:00'),

  (ST_GeomFromText('POINT(39.765 -104.876)'), 'Springfield Center B', 'A0002', '08:00:00'),
  (ST_GeomFromText('POINT(39.765 -104.877)'), 'Springfield Center B', 'A0002', '12:00:00'),
  (ST_GeomFromText('POINT(39.765 -104.878)'), 'Springfield Center B', 'A0002', '16:00:00'),
  (ST_GeomFromText('POINT(39.765 -104.879)'), 'Springfield Center B', 'A0002', '20:00:00'),

  (ST_GeomFromText('POINT(39.766 -104.880)'), 'Greenville Center A', 'A0004', '08:00:00'),
  (ST_GeomFromText('POINT(39.766 -104.881)'), 'Greenville Center A', 'A0004', '12:00:00'),
  (ST_GeomFromText('POINT(39.766 -104.882)'), 'Greenville Center A', 'A0004', '16:00:00'),
  (ST_GeomFromText('POINT(39.766 -104.883)'), 'Greenville Center A', 'A0004', '20:00:00');


  
-- Insert 4 ballots
INSERT INTO Ballots (Ballot_Name, B_ID_NUM, Question_Text, Available_Period, Answers)
VALUES
  ('Ballot 1', 1, 'What is your chosen party?', '2023-05-10 23:59:59', 'NPC,RDP,APP'),
  ('Ballot 2', 2, 'Who is your candidate?', '2023-05-10 23:00:00', 'John B,Joe G,Franklin S'),
  ('Ballot 3', 3, 'What is your Gender?', '2023-05-10 22:00:00', 'Male,Female,Other'),
  ('Ballot 4', 4, 'What is your age range?', '2023-05-10 21:00:00', '18-35,36-50,50+');
  
  
  -- This will insert 18 cast votes for 2 different ballots,
  INSERT INTO Cast_Votes (Voter_ID, Ballot_Name, Question_Text, Answer, Vote_Time)
VALUES
  (1, 'Ballot 1', 'What is your chosen party?', 'NPC', '2023-05-10 12:30:00'),
  (2, 'Ballot 1', 'What is your chosen party?', 'RDP', '2023-05-10 13:15:00'),
  (3, 'Ballot 1', 'What is your chosen party?', 'APP', '2023-05-10 14:45:00'),
  (4, 'Ballot 1', 'What is your chosen party?', 'NPC', '2023-05-10 16:30:00'),
  (5, 'Ballot 1', 'What is your chosen party?', 'RDP', '2023-05-10 17:00:00'),
  (6, 'Ballot 1', 'What is your chosen party?', 'APP', '2023-05-10 18:20:00'),
  (7, 'Ballot 1', 'What is your chosen party?', 'NPC', '2023-05-10 19:10:00'),
  (8, 'Ballot 1', 'What is your chosen party?', 'RDP', '2023-05-10 19:45:00'),
  (9, 'Ballot 1', 'What is your chosen party?', 'APP', '2023-05-10 20:30:00'),

  (1, 'Ballot 2', 'Who is your candidate?', 'John B', '2023-05-10 12:35:00'),
  (2, 'Ballot 2', 'Who is your candidate?', 'Joe G', '2023-05-10 13:20:00'),
  (3, 'Ballot 2', 'Who is your candidate?', 'Franklin S', '2023-05-10 14:50:00'),
  (4, 'Ballot 2', 'Who is your candidate?', 'John B', '2023-05-10 16:35:00'),
  (5, 'Ballot 2', 'Who is your candidate?', 'Joe G', '2023-05-10 17:05:00'),
  (6, 'Ballot 2', 'Who is your candidate?', 'Franklin S', '2023-05-10 18:25:00'),
  (7, 'Ballot 2', 'Who is your candidate?', 'John B', '2023-05-10 19:15:00'),
  (8, 'Ballot 2', 'Who is your candidate?', 'Joe G', '2023-05-10 19:50:00'),
  (9, 'Ballot 2', 'Who is your candidate?', 'Franklin S', '2023-05-10 20:35:00');

  -- Insert data into Residencies
INSERT INTO Residencies (ID_Num, Address)
VALUES
  (1, 'A0001'),
  (2, 'A0002'),
  (3, 'A0003'),
  (4, 'A0004');

-- Insert data into Email
INSERT INTO Email (ID_Num, email_address)
VALUES
  (1, 'john.doe@email.com'),
  (2, 'jane.doe@email.com'),
  (3, 'michael.smith@email.com'),
  (4, 'sarah.johnson@email.com');
