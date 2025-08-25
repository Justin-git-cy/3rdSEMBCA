-- Initial environment info query (copy-paste output after running)
SELECT USER() AS User, 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT example (copy-paste your actual output after running)
-- "user@host","myhostname","8.0.33","2025-08-25 12:34:56";



-- Task 1: Create Tables for College Student Management System

-- Use or create database
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- Table 01: Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NOT NULL,
    HOD VARCHAR(50) NOT NULL,
    ContactEmail VARCHAR(30),
    PhoneNumber VARCHAR(15),
    Location VARCHAR(50)
);

-- Table 02: Course
CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(50) NOT NULL,
    Credits INT NOT NULL,
    DepartmentID INT,
    Duration VARCHAR(20),
    Fee DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Table 03: Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(30),
    DateOfBirth DATE,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Table 04: Faculty
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY AUTO_INCREMENT,
    FacultyName VARCHAR(100),
    DepartmentID INT,
    Qualification VARCHAR(25),
    Email VARCHAR(30),
    PhoneNumber VARCHAR(15),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Table 05: Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(10),
    Year YEAR,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


-- Describe each table structure
DESCRIBE Departments;
DESCRIBE Course;
DESCRIBE Students;
DESCRIBE Faculty;
DESCRIBE Enrollments;

-- output:
-- 'DepartmentID', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'DepartmentName', 'varchar(50)', 'NO', '', NULL, ''
-- 'HOD', 'varchar(100)', 'NO', '', NULL, ''
-- 'ContactEmail', 'varchar(100)', 'YES', '', NULL, ''
-- 'Location', 'varchar(80)', 'YES', '', NULL, ''
-- 'EstablishedYear', 'year', 'YES', '', NULL, ''
-- 'DeptType', 'varchar(20)', 'YES', '', NULL, ''

-- output:
-- 'CourseID', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'CourseName', 'varchar(25)', 'YES', '', NULL, ''
-- 'Credits', 'int', 'NO', '', NULL, ''
-- 'DepartmentID', 'int', 'YES', 'MUL', NULL, ''
-- 'Fee', 'decimal(10,2)', 'YES', '', NULL, ''
-- 'MaxEnrollment', 'int', 'YES', '', NULL, ''
-- 'CourseLevel', 'varchar(20)', 'YES', '', NULL, ''

-- output:
-- 'StudentID', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'FirstName', 'varchar(50)', 'YES', '', NULL, ''
-- 'LastName', 'varchar(50)', 'YES', '', NULL, ''
-- 'DateOfBirth', 'date', 'YES', '', NULL, ''
-- 'CourseID', 'int', 'YES', 'MUL', NULL, ''
-- 'Address', 'varchar(100)', 'YES', '', NULL, ''
-- 'Gender', 'char(1)', 'YES', '', NULL, ''


-- output:
-- 'FacultyID', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'FacultyName', 'varchar(100)', 'YES', '', NULL, ''
-- 'DepartmentID', 'int', 'YES', 'MUL', NULL, ''
-- 'Qualification', 'varchar(25)', 'YES', '', NULL, ''
-- 'Email', 'varchar(30)', 'YES', '', NULL, ''
-- 'PhoneNumber', 'varchar(15)', 'YES', '', NULL, ''

-- output:
-- 'EnrollmentID', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'StudentID', 'int', 'YES', 'MUL', NULL, ''
-- 'CourseID', 'int', 'YES', 'MUL', NULL, ''
-- 'Semester', 'varchar(10)', 'YES', '', NULL, ''
-- 'Year', 'year', 'YES', '', NULL, ''
-- 'Grade', 'char(2)', 'YES', '', NULL, ''



-- Add 2 new columns for each table
ALTER TABLE Departments ADD COLUMN EstablishedYear YEAR;
ALTER TABLE Departments ADD COLUMN DeptType VARCHAR(20);

ALTER TABLE Course ADD COLUMN MaxEnrollment INT;
ALTER TABLE Course ADD COLUMN CourseLevel VARCHAR(20);

ALTER TABLE Students ADD COLUMN Address VARCHAR(100);
ALTER TABLE Students ADD COLUMN Gender CHAR(1);

ALTER TABLE Faculty ADD COLUMN JoiningDate DATE;
ALTER TABLE Faculty ADD COLUMN ExperienceYears INT;

ALTER TABLE Enrollments ADD COLUMN EnrollmentDate DATE;
ALTER TABLE Enrollments ADD COLUMN Status VARCHAR(20);

-- Modify existing columns (change size or datatype)
ALTER TABLE Course MODIFY CourseName VARCHAR(25); -- Task 4
ALTER TABLE Departments MODIFY Location VARCHAR(30); -- Task 5

-- Rename a column
ALTER TABLE Faculty CHANGE Qualification Degree VARCHAR(50); -- Task 6

-- Rename table Faculty to Teachers
RENAME TABLE Faculty TO Teachers; -- Task 7

-- Drop columns
ALTER TABLE Departments DROP COLUMN PhoneNumber; -- Task 8
ALTER TABLE Students DROP COLUMN Email; -- Task 9
ALTER TABLE Course DROP COLUMN Duration; -- Task 10

-- Describe new structure after changes
DESCRIBE Departments;
DESCRIBE Course;
DESCRIBE Students;
DESCRIBE Teachers;
DESCRIBE Enrollments;

-- Show tables before dropping
SHOW TABLES;

-- Drop the 'Course' and 'Enrollments' tables
DROP TABLE Course;
DROP TABLE Enrollments;

-- Show tables after dropping
SHOW TABLES;

