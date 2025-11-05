CREATE DATABASE hst;
USE hst;

CREATE TABLE Student(
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  RoomID INT
);

CREATE TABLE Room(
  RoomID INT PRIMARY KEY AUTO_INCREMENT,
  RoomNo VARCHAR(20),
  RentPerMonth DECIMAL(10,2)
);

CREATE TABLE RentPayment(
  PaymentID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  PaymentDate DATE,
  Amount DECIMAL(10,2),
  PeriodMonth DATE,
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

INSERT INTO Room(RoomNo,RentPerMonth) VALUES ('A101',5000.00),('A102',5500.00);
INSERT INTO Student(Name,RoomID) VALUES ('Nikhil',1),('Rhea',2);
INSERT INTO RentPayment(StudentID,PaymentDate,Amount,PeriodMonth) VALUES (1,'2025-11-01',5000.00,'2025-11-01'),(2,'2025-11-03',5500.00,'2025-11-01');

SELECT DATE_FORMAT(r.PeriodMonth,'%Y-%m') AS Month,SUM(r.Amount) AS TotalRent FROM RentPayment r GROUP BY DATE_FORMAT(r.PeriodMonth,'%Y-%m');
SELECT s.Name,rm.RoomNo,rm.RentPerMonth FROM Student s JOIN Room rm ON s.RoomID=rm.RoomID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateRent(IN pid INT,IN sid INT,IN pdate DATE,IN amt DECIMAL(10,2),IN period DATE)
BEGIN
  IF EXISTS(SELECT 1 FROM RentPayment WHERE PaymentID=pid) THEN
    UPDATE RentPayment SET StudentID=sid,PaymentDate=pdate,Amount=amt,PeriodMonth=period WHERE PaymentID=pid;
  ELSE
    INSERT INTO RentPayment(StudentID,PaymentDate,Amount,PeriodMonth) VALUES(sid,pdate,amt,period);
  END IF;
END //
DELIMITER ;
