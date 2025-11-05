CREATE DATABASE Scho;
USE Scho;

CREATE TABLE Student(
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50),
  ClassID INT
);

CREATE TABLE Class(
  ClassID INT PRIMARY KEY AUTO_INCREMENT,
  ClassName VARCHAR(50)
);

CREATE TABLE Marks(
  MarkID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  Subject VARCHAR(50),
  Marks INT,
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

INSERT INTO Class(ClassName) VALUES ('10A'),('10B');
INSERT INTO Student(Name,ClassID) VALUES ('Arjun',1),('Meera',1),('Ravi',2);
INSERT INTO Marks(StudentID,Subject,Marks) VALUES (1,'Math',80),(2,'Math',90),(3,'Math',70);

SELECT c.ClassName,AVG(m.Marks) AS AvgMarks FROM Marks m JOIN Student s ON m.StudentID=s.StudentID JOIN Class c ON s.ClassID=c.ClassID GROUP BY c.ClassName;
SELECT s.Name,m.Subject,m.Marks FROM Marks m JOIN Student s ON m.StudentID=s.StudentID WHERE m.Marks=(SELECT MAX(Marks) FROM Marks);

DELIMITER //
CREATE PROCEDURE AddOrUpdateMarks(IN mid INT,IN sid INT,IN sub VARCHAR(50),IN mark INT)
BEGIN
  IF EXISTS(SELECT * FROM Marks WHERE MarkID=mid) THEN
    UPDATE Marks SET StudentID=sid,Subject=sub,Marks=mark WHERE MarkID=mid;
  ELSE
    INSERT INTO Marks(StudentID,Subject,Marks) VALUES(sid,sub,mark);
  END IF;
END //
DELIMITER ;