-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 03: Implementation of different types of SQL functions.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Justin
-- USN: 1RUA24BCA0041
-- SECTION: -
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command

-- 'root@localhost', 'RVU-PC-054', '8.4.6', '2025-09-08 06:00:23'


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- PreCoded Relational Schema and Instance.
-- -----------------------------------------------------------------------------------------------------------------------------------------
create database Company;
use company; 
-- 1. Create Employee table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2),
    BirthDate DATE,
    HireDate DATE
);

-- 2. Insert 10 records into Employee table
INSERT INTO Employee (EmpID, FirstName, LastName, Salary, BirthDate, HireDate)
VALUES
(1, 'Joseph', 'Doe', 50000, '1985-06-15', '2015-01-20'),
(2, 'Janet', 'Smith', 60000, '1990-08-22', '2016-03-10'),
(3, 'Samuel', 'Brown', 55000, '1983-11-03', '2017-02-28'),
(4, 'Alice', 'Weems', 45000, '1987-04-25', '2018-07-01'),
(5, 'Walter', 'White', 70000, '1982-09-14', '2014-11-11'),
(6, 'Charles', 'Davis', 65000, '1989-12-30', '2016-06-18'),
(7, 'David', 'Wilson', 80000, '1984-02-09', '2019-03-15'),
(8, 'Eva', 'Miller', 72000, '1992-10-18', '2020-05-04'),
(9, 'Frank', 'rodriguez', 55000, '1991-01-29', '2017-09-09'),
(10, 'Grace', 'Moore', 50000, '1990-03-12', '2021-01-25');

-- 3. Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    EmpID INT,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

-- 4. Insert 10 records into Orders table
INSERT INTO Orders (OrderID, OrderDate, TotalAmount, EmpID)
VALUES
(1, '2023-01-15', 1500.50, 1),
(2, '2023-02-18', 2300.75, 2),
(3, '2023-03-10', 1800.60, 3),
(4, '2023-04-25', 1200.45, 4),
(5, '2023-05-30', 2100.90, 5),
(6, '2023-06-12', 1600.40, 6),
(7, '2023-07-14', 1900.85, 7),
(8, '2023-08-10', 2050.30, 8),
(9, '2023-09-01', 1700.20, 9),
(10, '2023-10-05', 1400.55, 10);

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Print the Information of the Employee and Order Table
 SELECT * FROM Employee;
/* '1', 'Joseph', 'Doe', '50000.00', '1985-06-15', '2015-01-20'
'2', 'Janet', 'Smith', '60000.00', '1990-08-22', '2016-03-10'
'3', 'Samuel', 'Brown', '55000.00', '1983-11-03', '2017-02-28'
'4', 'Alice', 'Weems', '45000.00', '1987-04-25', '2018-07-01'
'5', 'Walter', 'White', '70000.00', '1982-09-14', '2014-11-11'
'6', 'Charles', 'Davis', '65000.00', '1989-12-30', '2016-06-18'
'7', 'David', 'Wilson', '80000.00', '1984-02-09', '2019-03-15'
'8', 'Eva', 'Miller', '72000.00', '1992-10-18', '2020-05-04'
'9', 'Frank', 'rodriguez', '55000.00', '1991-01-29', '2017-09-09'
'10', 'Grace', 'Moore', '50000.00', '1990-03-12', '2021-01-25'*/

 SELECT * FROM Orders;
/*'1', '2023-01-15', '1500.50', '1'
'2', '2023-02-18', '2300.75', '2'
'3', '2023-03-10', '1800.60', '3'
'4', '2023-04-25', '1200.45', '4'
'5', '2023-05-30', '2100.90', '5'
'6', '2023-06-12', '1600.40', '6'
'7', '2023-07-14', '1900.85', '7'
'8', '2023-08-10', '2050.30', '8'
'9', '2023-09-01', '1700.20', '9'
'10', '2023-10-05', '1400.55', '10'*/

-- Output: Data from both tables will be shown when executed.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Number Functions Section
-- ------------------------------------------------------------
/* a. Round Salaries: Round employee salaries to nearest integer */
SELECT EmpID, FirstName, LastName, ROUND(Salary) AS RoundedSalary
FROM Employee;

-- Output: Shows employee salaries rounded to the nearest integer.
/*'1', 'Joseph', 'Doe', '50000'
'2', 'Janet', 'Smith', '60000'
'3', 'Samuel', 'Brown', '55000'
'4', 'Alice', 'Weems', '45000'
'5', 'Walter', 'White', '70000'
'6', 'Charles', 'Davis', '65000'
'7', 'David', 'Wilson', '80000'
'8', 'Eva', 'Miller', '72000'
'9', 'Frank', 'rodriguez', '55000'
'10', 'Grace', 'Moore', '50000'*/

-- /* b. Absolute Values: Show absolute values of salaries */
SELECT EmpID, FirstName, LastName, ABS(Salary) AS AbsoluteSalary
FROM Employee;

-- Output: Shows absolute values of employee salaries.
/*'1', 'Joseph', 'Doe', '50000.00'
'2', 'Janet', 'Smith', '60000.00'
'3', 'Samuel', 'Brown', '55000.00'
'4', 'Alice', 'Weems', '45000.00'
'5', 'Walter', 'White', '70000.00'
'6', 'Charles', 'Davis', '65000.00'
'7', 'David', 'Wilson', '80000.00'
'8', 'Eva', 'Miller', '72000.00'
'9', 'Frank', 'rodriguez', '55000.00'
'10', 'Grace', 'Moore', '50000.00'*/

-- /* c. Ceiling Values: Get ceiling values of order amounts */
SELECT OrderID, OrderDate, TotalAmount, CEIL(TotalAmount) AS CeilingAmount
FROM Orders;

-- Output: Shows order amounts rounded up to the next integer.
/*'1', '2023-01-15', '1500.50', '1501'
'2', '2023-02-18', '2300.75', '2301'
'3', '2023-03-10', '1800.60', '1801'
'4', '2023-04-25', '1200.45', '1201'
'5', '2023-05-30', '2100.90', '2101'
'6', '2023-06-12', '1600.40', '1601'
'7', '2023-07-14', '1900.85', '1901'
'8', '2023-08-10', '2050.30', '2051'
'9', '2023-09-01', '1700.20', '1701'
'10', '2023-10-05', '1400.55', '1401'*/

-- ------------------------------------------------------------
-- Aggregate Functions Section
-- ------------------------------------------------------------
/* a. Count of Employees: Find total number of employees */
SELECT COUNT(*) AS TotalEmployees
FROM Employee;

-- Output: Total count of employees in the Employee table.
/*'10'*/

-- /* b. Sum of Salaries: Calculate total salary expense */
SELECT SUM(Salary) AS TotalSalaryExpense
FROM Employee;

-- Output: Total sum of all employee salaries.
/*'602000.00'*/

-- /* c. Average Order Amount: Find average order value */
SELECT AVG(TotalAmount) AS AverageOrderAmount
FROM Orders;

-- Output: Shows the average order amount.
/*'1755.550000'*/

-- /* d. Max/Min Salary: Find highest and lowest salaries */
SELECT MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary
FROM Employee;

-- Output: Displays the highest and lowest salaries.
/*'80000.00', '45000.00'*/

-- ------------------------------------------------------------
-- Character Functions Section
-- ------------------------------------------------------------
/* a. Case Conversion: Show names in uppercase and lowercase */
SELECT EmpID, UPPER(FirstName) AS UpperCaseFirstName, LOWER(LastName) AS LowerCaseLastName
FROM Employee;

-- Output: Displays first names in uppercase and last names in lowercase.
/*'1', 'JOSEPH', 'doe'
'2', 'JANET', 'smith'
'3', 'SAMUEL', 'brown'
'4', 'ALICE', 'weems'
'5', 'WALTER', 'white'
'6', 'CHARLES', 'davis'
'7', 'DAVID', 'wilson'
'8', 'EVA', 'miller'
'9', 'FRANK', 'rodriguez'
'10', 'GRACE', 'moore'*/

-- /* b. Concatenate Names: Create full names */
SELECT EmpID, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employee;

-- Output: Combines first and last names into full names.
/*'1', 'Joseph Doe'
'2', 'Janet Smith'
'3', 'Samuel Brown'
'4', 'Alice Weems'
'5', 'Walter White'
'6', 'Charles Davis'
'7', 'David Wilson'
'8', 'Eva Miller'
'9', 'Frank rodriguez'
'10', 'Grace Moore'*/

-- /* c. Extract Substring: Get first 3 characters of first names */
SELECT EmpID, SUBSTRING(FirstName, 1, 3) AS First3Chars
FROM Employee;

-- Output: Shows the first 3 characters of the first names.
/*'1', 'Jos'
'2', 'Jan'
'3', 'Sam'
'4', 'Ali'
'5', 'Wal'
'6', 'Cha'
'7', 'Dav'
'8', 'Eva'
'9', 'Fra'
'10', 'Gra'*/

-- ------------------------------------------------------------
-- Conversion Functions Section
-- ------------------------------------------------------------
/* Convert String to Date: Convert text to DATE type */
SELECT EmpID, STR_TO_DATE('2023-11-12', '%Y-%m-%d') AS ConvertedDate
FROM Employee;

-- Output: Shows the conversion of a text date into the DATE type.
/*'1', '2023-11-12'
'2', '2023-11-12'
'3', '2023-11-12'
'4', '2023-11-12'
'5', '2023-11-12'
'6', '2023-11-12'
'7', '2023-11-12'
'8', '2023-11-12'
'9', '2023-11-12'
'10', '2023-11-12'*/

-- ------------------------------------------------------------
-- Date Functions Section
-- ------------------------------------------------------------
/* a. Current Date/Time: Get current timestamp */
SELECT NOW() AS CurrentDateTime;

-- Output: Displays the current date and time.
/*'2025-09-08 06:10:55'*/

-- /* b. Extract Year: Get year from order dates */
SELECT OrderID, YEAR(OrderDate) AS OrderYear
FROM Orders;

-- Output: Extracts the year from each order date.
/*'1', 2023
'2', 2023
'3', 2023
'4', 2023
'5', 2023
'6', 2023
'7', 2023
'8', 2023
'9', 2023
'10', 2023*/

-- /* c. Add Months: Add 3 months to order dates */
SELECT OrderID, OrderDate, DATE_ADD(OrderDate, INTERVAL 3 MONTH) AS NewOrderDate
FROM Orders;

-- Output: Shows the new date after adding 3 months to each order date.
/*'1', '2023-01-15', '2023-04-15'
'2', '2023-02-18', '2023-05-18'
'3', '2023-03-10', '2023-06-10'
'4', '2023-04-25', '2023-07-25'
'5', '2023-05-30', '2023-08-30'
'6', '2023-06-12', '2023-09-12'
'7', '2023-07-14', '2023-10-14'
'8', '2023-08-10', '2023-11-10'
'9', '2023-09-01', '2023-12-01'
'10', '2023-10-05', '2024-01-05'*/

-- /* d. Days Since Order: Calculate days between order date and now */
SELECT OrderID, OrderDate, DATEDIFF(NOW(), OrderDate) AS DaysSinceOrder
FROM Orders;

-- Output: Displays the number of days between the order date and the current date.
/*'1', '2023-01-15', '967'
'2', '2023-02-18', '933'
'3', '2023-03-10', '913'
'4', '2023-04-25', '867'
'5', '2023-05-30', '832'
'6', '2023-06-12', '819'
'7', '2023-07-14', '787'
'8', '2023-08-10', '760'
'9', '2023-09-01', '738'
'10', '2023-10-05', '704'*/

-- END of the Task --
