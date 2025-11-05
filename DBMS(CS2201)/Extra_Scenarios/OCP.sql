CREATE DATABASE ocp;
USE ocp;

CREATE TABLE Instructor(
  InstID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE TABLE Course(
  CourseID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(200),
  InstID INT,
  FOREIGN KEY (InstID) REFERENCES Instructor(InstID)
);

CREATE TABLE Enrollment(
  EnrollID INT PRIMARY KEY AUTO_INCREMENT,
  CourseID INT,
  StudentName VARCHAR(100),
  EnrollDate DATE,
  FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Instructor(Name) VALUES ('Dr. Roy'),('Ms. Leela');
INSERT INTO Course(Title,InstID) VALUES ('Intro to SQL',1),('Web Development',2);
INSERT INTO Enrollment(CourseID,StudentName,EnrollDate) VALUES (1,'Kabir','2025-10-20'),(1,'Maya','2025-10-22'),(2,'Rohit','2025-10-25');

SELECT c.Title,COUNT(e.EnrollID) AS TotalStudents FROM Enrollment e JOIN Course c ON e.CourseID=c.CourseID GROUP BY c.Title;
SELECT i.Name,c.Title FROM Course c JOIN Instructor i ON c.InstID=i.InstID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateEnrollment(IN eid INT,IN cid INT,IN sname VARCHAR(100),IN edate DATE)
BEGIN
  IF EXISTS(SELECT * FROM Enrollment WHERE EnrollID=eid) THEN
    UPDATE Enrollment SET CourseID=cid,StudentName=sname,EnrollDate=edate WHERE EnrollID=eid;
  ELSE
    INSERT INTO Enrollment(CourseID,StudentName,EnrollDate) VALUES(cid,sname,edate);
  END IF;
END //
DELIMITER ;
