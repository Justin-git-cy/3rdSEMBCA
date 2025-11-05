CREATE DATABASE Uni;
Use Uni;

CREATE TABLE Department (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE Student (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Exam (
  student_id INT,
  subject VARCHAR(50),
  marks INT,
  FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

INSERT INTO Department VALUES (1,'CSE'),(2,'ECE'),(3,'ME');
INSERT INTO Student VALUES (1,'Asha',1),(2,'Vivek',2),(3,'Kiran',1);
INSERT INTO Exam VALUES (1,'DBMS',85),(2,'DBMS',75),(3,'DBMS',90);

SELECT s.student_name, d.dept_name
   FROM Student s
   INNER JOIN Department d ON s.dept_id = d.dept_id;

SELECT d.dept_name, s.student_name
   FROM Department d
   LEFT OUTER JOIN Student s ON d.dept_id = s.dept_id;

SELECT subject, AVG(marks) AS avg_marks
   FROM Exam
   GROUP BY subject;

SELECT MAX(marks) AS highest_marks FROM Exam;

SELECT SUM(marks) AS total_marks FROM Exam;
