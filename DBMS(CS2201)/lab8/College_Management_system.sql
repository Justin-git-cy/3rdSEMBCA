CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    city VARCHAR(30)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    duration INT, -- in months
    fee DECIMAL(10,2)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students VALUES
(1, 'Alina Rodrigues', 'Female', '2003-04-12', 'Bangalore'),
(2, 'Raj Chowdary', 'Male', '2002-10-05', 'Mysore'),
(3, 'Jenna Carmen', 'Female', '2003-07-22', 'Mangalore'),
(4, 'Jordan Flick', 'Male', '2001-12-11', 'Hubli'),
(5, 'Natalie hargrover', 'Female', '2002-01-25', 'Udupi');

INSERT INTO Courses VALUES
(101, 'Computer Science', 6, 25000.00),
(102, 'Data Analytics', 4, 20000.00),
(103, 'Web Development', 3, 18000.00),
(104, 'AI and ML', 5, 30000.00),
(105, 'Cyber Security', 6, 28000.00);

-- Insert into Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 101, '2024-06-10', 'A'),
(2, 2, 103, '2024-07-01', 'B'),
(3, 3, 104, '2024-06-15', 'A'),
(4, 4, 102, '2024-05-20', 'C'),
(5, 5, 105, '2024-07-05', 'B');



-- Total number of students
SELECT COUNT(*) AS Total_Students FROM Students;

-- Average course fee
SELECT AVG(fee) AS Avg_Fee FROM Courses;

-- Maximum and Minimum fee
SELECT MAX(fee) AS Max_Fee, MIN(fee) AS Min_Fee FROM Courses;

-- List of enrollments with year and month of enrollment
SELECT enrollment_id, 
       student_id, 
       YEAR(enrollment_date) AS Year, 
       MONTH(enrollment_date) AS Month
FROM Enrollments;

SELECT student_name, dob, TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS Age
FROM Students
WHERE TIMESTAMPDIFF(YEAR, dob, CURDATE()) > 21;

SELECT s.student_name, c.course_name, e.grade
FROM Students s
INNER JOIN Enrollments e ON s.student_id = e.student_id
INNER JOIN Courses c ON e.course_id = c.course_id;

-- List all students and their enrollment (if any)
SELECT s.student_name, e.course_id, e.grade
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id;

-- List all courses with enrolled students (if any)
SELECT c.course_name, e.student_id, e.grade
FROM Courses c
RIGHT JOIN Enrollments e ON c.course_id = e.course_id;

-- Number of students enrolled per course
SELECT c.course_name, COUNT(e.student_id) AS Total_Students
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY Total_Students DESC;

-- Courses ordered by fee
SELECT * FROM Courses
ORDER BY fee DESC;

Stored Procedures
🔹 Procedure to Insert a New Student
DELIMITER //
CREATE PROCEDURE InsertStudent(
    IN sid INT,
    IN sname VARCHAR(50),
    IN gender VARCHAR(10),
    IN dob DATE,
    IN city VARCHAR(30)
)
BEGIN
    INSERT INTO Students VALUES (sid, sname, gender, dob, city);
END //
DELIMITER ;

-- Example Call
CALL InsertStudent(6, 'Kiran Das', 'Male', '2003-02-18', 'Belgaum');


🔹 Procedure to Update Course Fee
DELIMITER //
CREATE PROCEDURE UpdateCourseFee(
    IN cid INT,
    IN new_fee DECIMAL(10,2)
)
BEGIN
    UPDATE Courses SET fee = new_fee WHERE course_id = cid;
END //
DELIMITER ;

-- Example Call
CALL UpdateCourseFee(103, 19000.00);
