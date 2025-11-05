CREATE DATABASE SchoolDB;
USE SchoolDB;

CREATE TABLE Classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR(50),
  teacher_incharge VARCHAR(100)
);

CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100),
  class_id INT,
  dob DATE,
  FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

CREATE TABLE Marks (
  mark_id INT PRIMARY KEY,
  student_id INT,
  subject VARCHAR(100),
  marks INT,
  exam_date DATE,
  FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Classes VALUES
(1,'10-A','Mr. Kumar'),
(2,'10-B','Ms. Rao'),
(3,'10-C','Mr. Angelo');

INSERT INTO Students VALUES
(301,'Amit Singh',1,'2009-02-02'),
(302,'Nina George',1,'2009-05-20'),
(303,'Sofia Martinez',2,'2009-07-11'),
(304,'Luca Bianchi',3,'2009-09-01');

INSERT INTO Marks VALUES
(4001,301,'Math',88,'2025-03-10'),
(4002,301,'Science',78,'2025-03-12'),
(4003,302,'Math',92,'2025-03-10'),
(4004,303,'Math',85,'2025-03-10'),
(4005,304,'Math',73,'2025-03-10');

-- Class-wise student marks (join)
SELECT c.class_name, s.student_name, m.subject, m.marks
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Classes c ON s.class_id = c.class_id
ORDER BY c.class_name, s.student_name;

-- Average marks per class
SELECT c.class_name, AVG(m.marks) AS avg_marks
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Classes c ON s.class_id = c.class_id
GROUP BY c.class_name;

-- Procedure to insert a new student
DELIMITER //
CREATE PROCEDURE InsertStudent(
  IN sid INT, IN sname VARCHAR(100), IN cid INT, IN sdob DATE
)
BEGIN
  INSERT INTO Students VALUES (sid, sname, cid, sdob);
END //
DELIMITER ;

-- Procedure to update marks
DELIMITER //
CREATE PROCEDURE UpdateMarks(IN mid INT, IN new_marks INT)
BEGIN
  UPDATE Marks SET marks = new_marks WHERE mark_id = mid;
END //
DELIMITER ;
