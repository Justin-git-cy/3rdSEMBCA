CREATE DATABASE PayrollDB;
USE PayrollDB;

CREATE TABLE Departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(100),
  location VARCHAR(100)
);

CREATE TABLE Employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(100),
  dept_id INT,
  designation VARCHAR(50),
  hire_date DATE,
  FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Salaries (
  salary_id INT PRIMARY KEY,
  emp_id INT,
  salary_month DATE, -- store as first day of month
  basic DECIMAL(10,2),
  allowances DECIMAL(10,2),
  deductions DECIMAL(10,2),
  net_pay DECIMAL(10,2),
  FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

INSERT INTO Departments VALUES
(1,'Engineering','Bangalore'),
(2,'Human Resources','Madrid'),
(3,'Sales','Warsaw');

INSERT INTO Employees VALUES
(100,'Suresh Nair',1,'Software Engineer','2021-06-01'),
(101,'Elena Rossi',2,'HR Manager','2019-03-12'),
(102,'Trisha Stratton',3,'Sales Executive','2020-08-20'),
(103,'Jota Felix',1,'Senior Developer','2018-11-05');

INSERT INTO Salaries VALUES
(5001,100,'2025-10-01',60000,5000,2000,63000),
(5002,101,'2025-10-01',45000,3000,1500,46500),
(5003,102,'2025-10-01',42000,2500,1200,43300),
(5004,103,'2025-10-01',90000,7000,3000,94000);


-- Sum and average salary per department (use net_pay)
SELECT d.dept_name, COUNT(e.emp_id) AS employees,
       SUM(s.net_pay) AS total_pay, AVG(s.net_pay) AS avg_pay
FROM Departments d
JOIN Employees e ON d.dept_id = e.dept_id
JOIN Salaries s ON e.emp_id = s.emp_id
WHERE s.salary_month = '2025-10-01'
GROUP BY d.dept_name;

-- Join employee and department details
SELECT e.emp_id, e.emp_name, d.dept_name, e.designation, e.hire_date
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_name;

-- Procedure to insert salary
DELIMITER //
CREATE PROCEDURE InsertSalary(
  IN sid INT, IN eid INT, IN sm DATE, IN basic_amt DECIMAL(10,2),
  IN allow DECIMAL(10,2), IN ded DECIMAL(10,2)
)
BEGIN
  DECLARE net DECIMAL(10,2);
  SET net = basic_amt + allow - ded;
  INSERT INTO Salaries VALUES (sid, eid, sm, basic_amt, allow, ded, net);
END //
DELIMITER ;

-- Procedure to update employee salary (example: update allowances)
DELIMITER //
CREATE PROCEDURE UpdateAllowance(IN sid INT, IN new_allow DECIMAL(10,2))
BEGIN
  UPDATE Salaries
  SET allowances = new_allow, net_pay = basic + new_allow - deductions
  WHERE salary_id = sid;
END //
DELIMITER ;
