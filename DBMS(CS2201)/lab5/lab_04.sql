-- Lab Experiment 04: Implement arithmetic, logical, comparison, special, and set operators in SQL using the Employees and Departments tables.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Justin
-- USN: 1RUA24BCA0041
-- SECTION: --
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Write your code below this line along with the output 
/*'root@localhost', 'RVU-PC-069', '9.4.0', '2025-09-15 06:01:53'*/

create database company;
use company;

CREATE TABLE Employees (  
    EmployeeID INT PRIMARY KEY,  
    Name VARCHAR(100),  
    Age INT,  
    Salary DECIMAL(10,2),  
    DepartmentID INT,  
    HireDate DATE,  
    Address VARCHAR(255)  
);  

INSERT INTO Employees VALUES  
(1, 'Alice Johnson', 30, 60000, 1, '2020-03-15', '123 Main St, City A'),  
(2, 'Bob Smith', 28, 55000, 2, '2021-06-20', '456 Oak St, City B'),  
(3, 'Charlie Brown', 35, 75000, 3, '2019-01-10', '789 Pine St, City C'),  
(4, 'David Wilson', 40, 90000, 3, '2018-07-25', '101 Maple St, City D'),  
(5, 'Emma Davis', 27, 50000, 4, '2022-09-30', '202 Birch St, City E'),  
(6, 'Frank Miller', 32, 70000, 5, '2020-11-18', '303 Cedar St, City F'),  
(7, 'Grace Lee', 29, 58000, 1, '2021-04-05', '404 Walnut St, City G'),  
(8, 'Hank Adams', 45, 98000, 2, '2017-12-12', '505 Spruce St, City H'),  
(9, 'Ivy Green', 31, 64000, 4, '2023-02-14', '606 Redwood St, City I'),  
(10, 'Jack White', 38, 85000, 5, '2019-08-08', '707 Elm St, City J');  

-- TABLE:02 Department Table

CREATE TABLE Departments (  
    DepartmentID INT PRIMARY KEY,  
    DepartmentName VARCHAR(50)  
);  

INSERT INTO Departments VALUES  
(1, 'HR'),  
(2, 'Finance'),  
(3, 'Engineering'),  
(4, 'Marketing'),  
(5, 'Sales');  


-- TASK FOR STUDENTS 

/* 
Exercise 1: Arithmetic Operators
Addition, Subtraction, Multiplication, Division
Q1 - Add a bonus (10% of Salary) to each employee’s salary.*/
SELECT EmployeeID, Name, Salary, (Salary + (Salary * 0.10)) AS Salary_With_Bonus
FROM Employees;

/*'1', 'Alice Johnson', '60000.00', '66000.0000'
'2', 'Bob Smith', '55000.00', '60500.0000'
'3', 'Charlie Brown', '75000.00', '82500.0000'
'4', 'David Wilson', '90000.00', '99000.0000'
'5', 'Emma Davis', '50000.00', '55000.0000'
'6', 'Frank Miller', '70000.00', '77000.0000'
'7', 'Grace Lee', '58000.00', '63800.0000'
'8', 'Hank Adams', '98000.00', '107800.0000'
'9', 'Ivy Green', '64000.00', '70400.0000'
'10', 'Jack White', '85000.00', '93500.0000'
*/

/*Q2 - Subtract tax (15% of Salary) from each employee’s salary.*/
SELECT EmployeeID, Name, Salary, (Salary - (Salary * 0.15)) AS Salary_After_Tax
FROM Employees;

/*'1', 'Alice Johnson', '60000.00', '51000.0000'
'2', 'Bob Smith', '55000.00', '46750.0000'
'3', 'Charlie Brown', '75000.00', '63750.0000'
'4', 'David Wilson', '90000.00', '76500.0000'
'5', 'Emma Davis', '50000.00', '42500.0000'
'6', 'Frank Miller', '70000.00', '59500.0000'
'7', 'Grace Lee', '58000.00', '49300.0000'
'8', 'Hank Adams', '98000.00', '83300.0000'
'9', 'Ivy Green', '64000.00', '54400.0000'
'10', 'Jack White', '85000.00', '72250.0000'*/


-- Q3 - Calculate the yearly salary from the monthly salary.
SELECT EmployeeID, Name, Salary, (Salary * 12) AS Yearly_Salary
FROM Employees;

/*'1', 'Alice Johnson', '60000.00', '720000.00'
'2', 'Bob Smith', '55000.00', '660000.00'
'3', 'Charlie Brown', '75000.00', '900000.00'
'4', 'David Wilson', '90000.00', '1080000.00'
'5', 'Emma Davis', '50000.00', '600000.00'
'6', 'Frank Miller', '70000.00', '840000.00'
'7', 'Grace Lee', '58000.00', '696000.00'
'8', 'Hank Adams', '98000.00', '1176000.00'
'9', 'Ivy Green', '64000.00', '768000.00'
'10', 'Jack White', '85000.00', '1020000.00'
*/

-- Modulus Operator
-- Q4 - Find the remainder when employees’ ages are divided by 5.*/
SELECT EmployeeID, Name, Age, (Age % 5) AS Age_Remainder
FROM Employees;

/*'1', 'Alice Johnson', '30', '0'
'2', 'Bob Smith', '28', '3'
'3', 'Charlie Brown', '35', '0'
'4', 'David Wilson', '40', '0'
'5', 'Emma Davis', '27', '2'
'6', 'Frank Miller', '32', '2'
'7', 'Grace Lee', '29', '4'
'8', 'Hank Adams', '45', '0'
'9', 'Ivy Green', '31', '1'
'10', 'Jack White', '38', '3'
*/

/* Exercise 2: Logical Operators: AND, OR, NOT*/

-- Q5 - Retrieve employees older than 30 AND with salary > 50000.
SELECT EmployeeID, Name, Age, Salary
FROM Employees
WHERE Age > 30 AND Salary > 50000;

/*'3', 'Charlie Brown', '35', '75000.00'
'4', 'David Wilson', '40', '90000.00'
'6', 'Frank Miller', '32', '70000.00'
'8', 'Hank Adams', '45', '98000.00'
'9', 'Ivy Green', '31', '64000.00'
'10', 'Jack White', '38', '85000.00'
*/

-- Q6 - Retrieve employees in the HR department (ID=1) OR earning > 70000.
SELECT EmployeeID, Name, DepartmentID, Salary
FROM Employees
WHERE DepartmentID = 1 OR Salary > 70000;

/*'1', 'Alice Johnson', '1', '60000.00'
'3', 'Charlie Brown', '3', '75000.00'
'4', 'David Wilson', '3', '90000.00'
'7', 'Grace Lee', '1', '58000.00'
'8', 'Hank Adams', '2', '98000.00'
'10', 'Jack White', '5', '85000.00'*/


-- Q7 - Retrieve employees NOT living in City G.*/

SELECT EmployeeID, Name, Address
FROM Employees
WHERE Address NOT LIKE '%City G%';

/*'1', 'Alice Johnson', '123 Main St, City A'
'2', 'Bob Smith', '456 Oak St, City B'
'3', 'Charlie Brown', '789 Pine St, City C'
'4', 'David Wilson', '101 Maple St, City D'
'5', 'Emma Davis', '202 Birch St, City E'
'6', 'Frank Miller', '303 Cedar St, City F'
'8', 'Hank Adams', '505 Spruce St, City H'
'9', 'Ivy Green', '606 Redwood St, City I'
'10', 'Jack White', '707 Elm St, City J'
*/



/* Exercise 3: Comparison Operators*/

-- Q8 - Equality, Inequality, Greater Than, Less Than

-- Q9 - Find employees with salary = 60000.
SELECT EmployeeID, Name, Salary
FROM Employees
WHERE Salary = 60000;

/*'1', 'Alice Johnson', '60000.00'
*/

-- Q10 - List employees not in the IT department (no IT department exists; returns all).
SELECT EmployeeID, Name, DepartmentID
FROM Employees
WHERE DepartmentID NOT IN (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'IT');

/*'1', 'Alice Johnson', '1'
'2', 'Bob Smith', '2'
'3', 'Charlie Brown', '3'
'4', 'David Wilson', '3'
'5', 'Emma Davis', '4'
'6', 'Frank Miller', '5'
'7', 'Grace Lee', '1'
'8', 'Hank Adams', '2'
'9', 'Ivy Green', '4'
'10', 'Jack White', '5'
*/

-- Q11 - Retrieve employees younger than 25 with salary > 50000 
SELECT EmployeeID, Name, Age, Salary
FROM Employees
WHERE Age < 25 AND Salary > 50000;

/*# EmployeeID, Name, Age, Salary
*/

-- Q12 - List employees aged 25–35.
SELECT EmployeeID, Name, Age
FROM Employees
WHERE Age BETWEEN 25 AND 35;

/*'1', 'Alice Johnson', '30'
'2', 'Bob Smith', '28'
'3', 'Charlie Brown', '35'
'5', 'Emma Davis', '27'
'6', 'Frank Miller', '32'
'7', 'Grace Lee', '29'
'9', 'Ivy Green', '31'
*/

-- Q13 - Find employees in HR, Finance, or Engineering (IDs 1, 2, 3).
SELECT EmployeeID, Name, DepartmentID
FROM Employees
WHERE DepartmentID IN (1, 2, 3);

/*'1', 'Alice Johnson', '1'
'2', 'Bob Smith', '2'
'3', 'Charlie Brown', '3'
'4', 'David Wilson', '3'
'7', 'Grace Lee', '1'
'8', 'Hank Adams', '2'
*/

-- Q14 - Find employees with names starting with A.
SELECT EmployeeID, Name
FROM Employees
WHERE Name LIKE 'A%';

/*'1', 'Alice Johnson'
*/

-- Q15 - List employees with no address.
SELECT EmployeeID, Name
FROM Employees
WHERE Address IS NULL OR Address = '';


/*EmployeeID, Name*/

/*Exercise 5: Set Operators: UNION.*/

-- Q16 - Retrieve names from the HR department hired in 2022 OR 2023.
SELECT Name
FROM Employees
WHERE DepartmentID = 1 AND (YEAR(HireDate) = 2022 OR YEAR(HireDate) = 2023);

/*Name*/

-- Q17 - Find common employees in the Engineering department (ID=3) hired before and after 2020.
SELECT e1.EmployeeID, e1.Name
FROM Employees e1
JOIN Employees e2 
    ON e1.EmployeeID = e2.EmployeeID
WHERE e1.DepartmentID = 3 
  AND e2.DepartmentID = 3
  AND YEAR(e1.HireDate) < 2020
  AND YEAR(e2.HireDate) >= 2020;

/*EmployeeID, Name*/


-- Q18 - Find employees hired in 2023 but not in 2022.


SELECT Name
FROM Employees e1
WHERE e1.Name = 'Alice Johnson'
  AND YEAR(e1.HireDate) = 2023
  AND NOT EXISTS (
    SELECT 1
    FROM Employees e2
    WHERE e2.Name = 'Hank Adams'
      AND YEAR(e2.HireDate) = 2022
  );

/*Name*/

