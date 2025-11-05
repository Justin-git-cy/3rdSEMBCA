CREATE DATABASE Col;
USE Col;

CREATE TABLE Student(
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Subject(
  SubjectID INT PRIMARY KEY AUTO_INCREMENT,
  SubjectName VARCHAR(50)
);

CREATE TABLE Result(
  ResultID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  SubjectID INT,
  Marks INT,
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
  FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID)
);

INSERT INTO Student(Name) VALUES ('Pooja'),('Rahul');
INSERT INTO Subject(SubjectName) VALUES ('Math'),('Science');
INSERT INTO Result(StudentID,SubjectID,Marks) VALUES (1,1,85),(2,2,90);

SELECT s.SubjectName,AVG(r.Marks) AS AvgMarks FROM Result r JOIN Subject s ON r.SubjectID=s.SubjectID GROUP BY s.SubjectName;
SELECT st.Name,s.SubjectName,r.Marks FROM Result r JOIN Student st ON r.StudentID=st.StudentID JOIN Subject s ON r.SubjectID=s.SubjectID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateResult(IN rid INT,IN sid INT,IN subid INT,IN mark INT)
BEGIN
  IF EXISTS(SELECT * FROM Result WHERE ResultID=rid) THEN
    UPDATE Result SET StudentID=sid,SubjectID=subid,Marks=mark WHERE ResultID=rid;
  ELSE
    INSERT INTO Result(StudentID,SubjectID,Marks) VALUES(sid,subid,mark);
  END IF;
END //
DELIMITER ;