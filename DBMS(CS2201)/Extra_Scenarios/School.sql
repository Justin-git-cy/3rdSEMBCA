CREATE DATABASE Sch;
Use Sch;

CREATE TABLE Student (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(50)
);

CREATE TABLE Course (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(50),
  course_fee DECIMAL(8,2)
);

CREATE TABLE Enrollment (
  student_id INT,
  course_id INT,
  FOREIGN KEY (student_id) REFERENCES Student(student_id),
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT INTO Student VALUES (1,'Amit'),(2,'Neha'),(3,'Ravi');
INSERT INTO Course VALUES (1,'Database Systems',1200),(2,'Networking',1000),(3,'Python Programming',1500);
INSERT INTO Enrollment VALUES (1,1),(2,2),(3,1);

SELECT s.student_name, c.course_name
   FROM Enrollment e
   INNER JOIN Student s ON e.student_id = s.student_id
   INNER JOIN Course c ON e.course_id = c.course_id;

SELECT c.course_name, s.student_name
   FROM Course c
   LEFT OUTER JOIN Enrollment e ON c.course_id = e.course_id
   LEFT OUTER JOIN Student s ON e.student_id = s.student_id;

SELECT c.course_name, COUNT(e.student_id) AS total_students
   FROM Enrollment e
   INNER JOIN Course c ON e.course_id = c.course_id
   GROUP BY c.course_name;

SELECT AVG(course_fee) AS avg_course_fee FROM Course;

SELECT COUNT(*) AS total_students_enrolled FROM Enrollment;
