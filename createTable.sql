CREATE TABLE Folks (
  ID_Num INT PRIMARY KEY,
  First_Name VARCHAR(50),
  Last_Name VARCHAR(50),
  Nickname VARCHAR(50),
  DOB DATE,
  Phone_Number VARCHAR(20)
);

CREATE TABLE Email (
  ID_Num INT,
  email_address VARCHAR(100),
  FOREIGN KEY (ID_Num)
  REFERENCES Folks(ID_Num)
);

CREATE TABLE Election_Staff (
  ES_ID_Num INT,
  Clerks VARCHAR(50),
  Monitors VARCHAR(50),
  PRIMARY KEY(ES_ID_NUM),
  FOREIGN KEY (ES_ID_Num)
   REFERENCES Folks(ID_Num)
);

CREATE TABLE Ballots (
  Ballot_Name VARCHAR(50) PRIMARY KEY,
  B_ID_NUM INT,
  Question_Text TEXT,
  Available_Period DATETIME,
  Answers VARCHAR(200),
  FOREIGN KEY (B_ID_NUM)
	REFERENCES FOLKS(ID_NUM)
);

CREATE TABLE Voting_Registry (
    Registry_ID INT PRIMARY KEY AUTO_INCREMENT, -- stores unique identifiers for each row
    Center_Name VARCHAR(255),
    V_ID_Num INT,
    Ballot_Name VARCHAR(50),
    Voting_Date DATE,
    INDEX (Center_Name), -- adding an index to the Center_Name column
    FOREIGN KEY (V_ID_Num) REFERENCES Folks(ID_Num)
);

CREATE TABLE Places (
  Address VARCHAR(10) PRIMARY KEY,
  Street_Number VARCHAR(10),
  Street_Name VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(50),
  Zip_Code VARCHAR(10),
  XY_Coordinates POINT
);

CREATE TABLE Voting_Centers (
  Voting_Center_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  XY_Coordinates POINT NOT NULL,
  Center_Name VARCHAR(50) NOT NULL,
  Address VARCHAR(10) NOT NULL,
  Time TIME,
  FOREIGN KEY (Address) REFERENCES Places(Address),
  FOREIGN KEY (Center_Name) REFERENCES Voting_Registry(Center_Name)
);

CREATE TABLE Cast_Votes (
  Vote_ID INT NOT NULL AUTO_INCREMENT,
  Voter_ID INT NOT NULL,
  Ballot_Name VARCHAR(50) NOT NULL,
  Question_Text VARCHAR(255) NOT NULL,
  Answer VARCHAR(255) NOT NULL,
  Vote_Time DATETIME NOT NULL,
  PRIMARY KEY (Vote_ID),
  FOREIGN KEY (Voter_ID) REFERENCES Folks(ID_Num),
  FOREIGN KEY (Ballot_Name) REFERENCES Ballots(Ballot_Name)
);

CREATE TABLE Residencies (
  Address VARCHAR(10),
  ID_Num INT,
  FOREIGN KEY (Address)
    REFERENCES Places(Address),
  FOREIGN KEY (ID_Num)
    REFERENCES Folks(ID_Num)
);
