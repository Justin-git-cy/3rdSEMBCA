CREATE DATABASE Empl;
USE Empl;

CREATE TABLE Department(
  DeptID INT PRIMARY KEY AUTO_INCREMENT,
  DeptName VARCHAR(50)
);

CREATE TABLE Employee(
  EmpID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50),
  DeptID INT,
  FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Salary(
  SalaryID INT PRIMARY KEY AUTO_INCREMENT,
  EmpID INT,
  Amount DECIMAL(10,2),
  FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

INSERT INTO Department(DeptName) VALUES ('HR'),('IT');
INSERT INTO Employee(Name,DeptID) VALUES ('Asha',1),('Raj',2);
INSERT INTO Salary(EmpID,Amount) VALUES (1,30000),(2,50000);

SELECT e.Name,d.DeptName FROM Employee e JOIN Department d ON e.DeptID=d.DeptID;
SELECT SUM(Amount) AS TotalSalary,AVG(Amount) AS AvgSalary FROM Salary;

DELIMITER //
CREATE PROCEDURE AddOrUpdateSalary(IN sid INT,IN eid INT,IN amt DECIMAL(10,2))
BEGIN
  IF EXISTS(SELECT * FROM Salary WHERE SalaryID=sid) THEN
    UPDATE Salary SET EmpID=eid,Amount=amt WHERE SalaryID=sid;
  ELSE
    INSERT INTO Salary(EmpID,Amount) VALUES(eid,amt);
  END IF;
END //
DELIMITER ;