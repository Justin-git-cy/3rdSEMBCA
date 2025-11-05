CREATE DATABASE gym;
USE gym;

CREATE TABLE Member(
  MemberID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE TABLE Trainer(
  TrainerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE TABLE Session(
  SessionID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  TrainerID INT,
  SessionDate DATE,
  SessionType VARCHAR(100),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
  FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID)
);

INSERT INTO Member(Name) VALUES ('Rahul'),('Sneha');
INSERT INTO Trainer(Name) VALUES ('Vikram'),('Rita');
INSERT INTO Session(MemberID,TrainerID,SessionDate,SessionType) VALUES (1,1,'2025-11-01','Strength'),(2,2,'2025-11-02','Yoga'),(1,2,'2025-11-03','Cardio');

SELECT t.Name AS Trainer, m.Name AS Member, s.SessionDate,s.SessionType FROM Session s JOIN Trainer t ON s.TrainerID=t.TrainerID JOIN Member m ON s.MemberID=m.MemberID;
SELECT TrainerID,COUNT(SessionID) AS SessionCount FROM Session GROUP BY TrainerID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateSession(IN sid INT,IN mid INT,IN tid INT,IN sdate DATE,IN stype VARCHAR(100))
BEGIN
  IF EXISTS(SELECT * FROM Session WHERE SessionID=sid) THEN
    UPDATE Session SET MemberID=mid,TrainerID=tid,SessionDate=sdate,SessionType=stype WHERE SessionID=sid;
  ELSE
    INSERT INTO Session(MemberID,TrainerID,SessionDate,SessionType) VALUES(mid,tid,sdate,stype);
  END IF;
END //
DELIMITER ;
