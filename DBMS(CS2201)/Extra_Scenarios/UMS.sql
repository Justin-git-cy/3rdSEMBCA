CREATE DATABASE Univ;
USE Univ;

CREATE TABLE Student(
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Course(
  CourseID INT PRIMARY KEY AUTO_INCREMENT,
  CourseName VARCHAR(50)
);

CREATE TABLE Enrollment(
  EnrollID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  CourseID INT,
  Grade DECIMAL(3,1),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Student(Name) VALUES ('Anita'),('Vijay');
INSERT INTO Course(CourseName) VALUES ('Math'),('Science');
INSERT INTO Enrollment(StudentID,CourseID,Grade) VALUES (1,1,8.5),(2,2,9.0);

SELECT c.CourseName,s.Name,e.Grade FROM Enrollment e JOIN Student s ON e.StudentID=s.StudentID JOIN Course c ON e.CourseID=c.CourseID;
SELECT c.CourseName,AVG(e.Grade) AS AvgGrade FROM Enrollment e JOIN Course c ON e.CourseID=c.CourseID GROUP BY c.CourseName;

DELIMITER //
CREATE PROCEDURE AddOrUpdateEnrollment(IN eid INT,IN sid INT,IN cid INT,IN grd DECIMAL(3,1))
BEGIN
  IF EXISTS(SELECT * FROM Enrollment WHERE EnrollID=eid) THEN
    UPDATE Enrollment SET StudentID=sid,CourseID=cid,Grade=grd WHERE EnrollID=eid;
  ELSE
    INSERT INTO Enrollment(StudentID,CourseID,Grade) VALUES(sid,cid,grd);
  END IF;
END //
DELIMITER ;
