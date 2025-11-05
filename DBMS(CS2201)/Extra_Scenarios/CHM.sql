CREATE DATABASE chm;
USE chm;

CREATE TABLE Student(
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE TABLE Meal(
  MealID INT PRIMARY KEY AUTO_INCREMENT,
  MealDate DATE,
  MealType VARCHAR(50),
  Cost DECIMAL(10,2)
);

CREATE TABLE Payment(
  PaymentID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  MealID INT,
  PaidDate DATE,
  Amount DECIMAL(10,2),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
  FOREIGN KEY (MealID) REFERENCES Meal(MealID)
);

INSERT INTO Student(Name) VALUES ('Ishaan'),('Jaya');
INSERT INTO Meal(MealDate,MealType,Cost) VALUES ('2025-11-01','Lunch',50.00),('2025-11-01','Dinner',70.00);
INSERT INTO Payment(StudentID,MealID,PaidDate,Amount) VALUES (1,1,'2025-11-01',50.00),(2,2,'2025-11-01',70.00);

SELECT p.StudentID,s.Name,SUM(p.Amount) AS TotalMealCost FROM Payment p JOIN Student s ON p.StudentID=s.StudentID GROUP BY p.StudentID;
SELECT s.Name,m.MealDate,m.MealType,p.Amount FROM Payment p JOIN Student s ON p.StudentID=s.StudentID JOIN Meal m ON p.MealID=m.MealID;

DELIMITER //
CREATE PROCEDURE AddOrUpdatePayment(IN pid INT,IN sid INT,IN mid INT,IN pdate DATE,IN amt DECIMAL(10,2))
BEGIN
  IF EXISTS(SELECT 1 FROM Payment WHERE PaymentID=pid) THEN
    UPDATE Payment SET StudentID=sid,MealID=mid,PaidDate=pdate,Amount=amt WHERE PaymentID=pid;
  ELSE
    INSERT INTO Payment(StudentID,MealID,PaidDate,Amount) VALUES(sid,mid,pdate,amt);
  END IF;
END //
DELIMITER ;
