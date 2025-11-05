CREATE DATABASE ngo;
USE ngo;

CREATE TABLE Volunteer(
  VolID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Contact VARCHAR(100)
);

CREATE TABLE Project(
  ProjectID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(200),
  StartDate DATE,
  EndDate DATE
);

CREATE TABLE Assignment(
  AssignID INT PRIMARY KEY AUTO_INCREMENT,
  VolID INT,
  ProjectID INT,
  Role VARCHAR(100),
  AssignedDate DATE,
  FOREIGN KEY (VolID) REFERENCES Volunteer(VolID),
  FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

INSERT INTO Volunteer(Name,Contact) VALUES ('Kamal','kamal@example.com'),('Rita','rita@example.com');
INSERT INTO Project(Title,StartDate,EndDate) VALUES ('CleanUp','2025-09-01','2025-12-31'),('Teaching','2025-10-01','2026-03-31');
INSERT INTO Assignment(VolID,ProjectID,Role,AssignedDate) VALUES (1,1,'Coordinator','2025-09-05'),(2,2,'Tutor','2025-10-10');

SELECT p.Title,v.Name,a.Role,a.AssignedDate FROM Assignment a JOIN Project p ON a.ProjectID=p.ProjectID JOIN Volunteer v ON a.VolID=v.VolID;
SELECT p.Title,COUNT(a.VolID) AS VolunteersCount FROM Assignment a JOIN Project p ON a.ProjectID=p.ProjectID GROUP BY p.ProjectID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateAssignment(IN aid INT,IN vid INT,IN pid INT,IN role VARCHAR(100),IN adate DATE)
BEGIN
  IF EXISTS(SELECT 1 FROM Assignment WHERE AssignID=aid) THEN
    UPDATE Assignment SET VolID=vid,ProjectID=pid,Role=role,AssignedDate=adate WHERE AssignID=aid;
  ELSE
    INSERT INTO Assignment(VolID,ProjectID,Role,AssignedDate) VALUES(vid,pid,role,adate);
  END IF;
END //
DELIMITER ;
