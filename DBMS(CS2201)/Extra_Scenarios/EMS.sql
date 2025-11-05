CREATE DATABASE evt;
USE evt;

CREATE TABLE Event(
  EventID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(200),
  EventDate DATE,
  Location VARCHAR(200)
);

CREATE TABLE Participant(
  PartID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Email VARCHAR(100)
);

CREATE TABLE Registration(
  RegID INT PRIMARY KEY AUTO_INCREMENT,
  EventID INT,
  PartID INT,
  RegDate DATE,
  FOREIGN KEY (EventID) REFERENCES Event(EventID),
  FOREIGN KEY (PartID) REFERENCES Participant(PartID)
);

INSERT INTO Event(Title,EventDate,Location) VALUES ('Tech Summit','2025-12-10','Auditorium'),('Music Fest','2025-11-20','Open Ground');
INSERT INTO Participant(Name,Email) VALUES ('Asha','asha@example.com'),('Vikram','vikram@example.com');
INSERT INTO Registration(EventID,PartID,RegDate) VALUES (1,1,'2025-10-01'),(1,2,'2025-10-05');

SELECT e.Title,COUNT(r.RegID) AS Participants FROM Registration r JOIN Event e ON r.EventID=e.EventID GROUP BY e.Title;
SELECT * FROM Event WHERE EventDate >= CURDATE() ORDER BY EventDate;

DELIMITER //
CREATE PROCEDURE AddOrUpdateRegistration(IN rid INT,IN eid INT,IN pid INT,IN rdate DATE)
BEGIN
  IF EXISTS(SELECT * FROM Registration WHERE RegID=rid) THEN
    UPDATE Registration SET EventID=eid,PartID=pid,RegDate=rdate WHERE RegID=rid;
  ELSE
    INSERT INTO Registration(EventID,PartID,RegDate) VALUES(eid,pid,rdate);
  END IF;
END //
DELIMITER ;
