-- Lab Experiment 01: Implementation of DDL Commands in SQL
-- STUDENT NAME: Justin
-- USN: 1RUA24BCA0041
-- SECTION: BCA

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- 'root@localhost', 'RVU-PC-069', '9.4.0', '2025-08-18 06:02:22'


-- Scenario: University Course Management System
-- CREATE AND LOAD THE database DBLab001
-- Write your SQL query below Codespace:
create database DBLab001;
use DBLab001;
-- Task 1: Create the Students Table
-- Create a table to store information about students.
-- Include the following columns:
-- 1. StudentID (Primary Key)
-- 2. FirstName
-- 3. LastName
-- 4. Email (Unique Constraint)
-- 5. DateOfBirth

-- Write your SQL query below Codespace:
create table students
(studentID varchar(10) primary key,
fisrtname varchar(15),
lastname varchar (10),
email varchar(15) unique,
dob date);


DESC Students; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
'studentID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'fisrtname', 'varchar(15)', 'YES', '', NULL, ''
'lastname', 'varchar(10)', 'YES', '', NULL, ''
'email', 'varchar(15)', 'YES', 'UNI', NULL, ''
'dob', 'date', 'YES', '', NULL, ''

-- Alter the table and 2 new columns
alter table students add (gender varchar (2), age int);

desc students;
'studentID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'fisrtname', 'varchar(15)', 'YES', '', NULL, ''
'lastname', 'varchar(10)', 'YES', '', NULL, ''
'email', 'varchar(15)', 'YES', 'UNI', NULL, ''
'dob', 'date', 'YES', '', NULL, ''
'gender', 'varchar(2)', 'YES', '', NULL, ''
'age', 'int', 'YES', '', NULL, ''

-- Modify a column data type
alter table students modify lastname varchar(10);
desc students;
-- Rename a column
alter table students rename column lastname to surname;
desc students;

-- Drop a column
alter table students drop dob;
desc students;
-- Rename the table
alter table students rename  to StudentDetails;
desc students;


-- Task 2: Create the Courses Table
-- Create a table to store information about courses.
-- Include the following columns:
-- - CourseID (Primary Key)
-- - CourseName
-- - Credits

-- Write your SQL query below Codespace:
Create table courses
( courseID varchar(15) primary key,
courseName varchar(10),
credits int );

DESC Courses; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]




-- Alter the table and 2 new columns
alter table course add (lecture varchar(15), hour varchar(10) );
desc course;
-- Modify a column data type
alter table course modify credits varchar(10);
desc course;
-- Rename a column
alter table course rename column credits to creds;
desc course;

-- Drop a column
alter table course drop lecture;
desc course;
-- Rename the table
alter table course rename  to CourseDetails;
desc CourseDetails;


-- Task 3: Create the Enrollments Table
-- Create a table to store course enrollment information.
-- Include the following columns:
-- - EnrollmentID (Primary Key)
-- - StudentID (Foreign Key referencing Students table)
-- - CourseID (Foreign Key referencing Courses table)
-- - EnrollmentDate

-- Write your SQL query below Codespace:

create table enrollments
(enrollID varchar(10) primary key,
studentID varchar(10),
courseID varchar(10),
Foreign key(studentID) references students(studentID),
Foreign key(courseID) references courses(courseID)
);

DESC ENROLLMENTS; -- [ [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ] ]
-- OUTPUT :

-- Alter the table and 2 new columns
alter table enrollments add (gender varchar(15), age varchar(10) );
desc enrollments;
-- Modify a column data type
alter table course modify studentID varchar(10);
desc enrollments;
-- Rename a column
alter table course rename column gender to gen;
desc enrollments;

-- Drop a column
alter table course drop age;
desc enrollments;
-- Rename the table
alter table course rename  to enrollmentsDetails;
desc enrollmentsDetails;

-- Task 4: Alter the Students Table
-- Add a column 'PhoneNumber' to store student contact numbers.

-- Write your SQL query below Codespace:
alter table student add (phonenum int );
desc student;

DESC STUDENTS; -- [[ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]]

-- Task 5: Modify the Courses Table
-- Change the data type of the 'Credits' column to DECIMAL.
-- Write your SQL query below Codespace:

-- Task 6: Drop Tables

SHOW TABLES; -- Before dropping the table

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:

SHOW TABLES; -- After dropping the table Enrollement and Course

-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01



