CREATE DATABASE spt;
USE spt;

CREATE TABLE Team (
  TeamID INT PRIMARY KEY AUTO_INCREMENT,
  TeamName VARCHAR(50)
);

CREATE TABLE Player (
  PlayerID INT PRIMARY KEY AUTO_INCREMENT,
  PlayerName VARCHAR(50),
  TeamID INT,
  FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

CREATE TABLE Game (
  GameID INT PRIMARY KEY AUTO_INCREMENT,
  Team1ID INT,
  Team2ID INT,
  MatchDate DATE,
  Result VARCHAR(50),
  FOREIGN KEY (Team1ID) REFERENCES Team(TeamID),
  FOREIGN KEY (Team2ID) REFERENCES Team(TeamID)
);

INSERT INTO Team (TeamName)
VALUES ('Lions'), ('Tigers'), ('Eagles');

INSERT INTO Player (PlayerName, TeamID)
VALUES ('Rohit',1), ('Virat',1), ('Rahul',2), ('Ankit',3);

INSERT INTO Game (Team1ID, Team2ID, MatchDate, Result)
VALUES (1,2,'2025-11-01','Lions Win'), (2,3,'2025-11-03','Eagles Win');

SELECT TeamID, COUNT(*) AS TotalMatches
FROM (
  SELECT Team1ID AS TeamID FROM Game
  UNION ALL
  SELECT Team2ID AS TeamID FROM Game
) AS Combined
GROUP BY TeamID;

SELECT P.PlayerName, T.TeamName, G.Result
FROM Player P
JOIN Team T ON P.TeamID=T.TeamID
JOIN Game G ON (T.TeamID=G.Team1ID OR T.TeamID=G.Team2ID);

DELIMITER //
CREATE PROCEDURE AddOrUpdateGame(
  IN gid INT,
  IN t1 INT,
  IN t2 INT,
  IN mdate DATE,
  IN res VARCHAR(50)
)
BEGIN
  IF EXISTS (SELECT * FROM Game WHERE GameID=gid) THEN
    UPDATE Game SET Team1ID=t1, Team2ID=t2, MatchDate=mdate, Result=res WHERE GameID=gid;
  ELSE
    INSERT INTO Game (Team1ID, Team2ID, MatchDate, Result)
    VALUES (t1,t2,mdate,res);
  END IF;
END //
DELIMITER ;

