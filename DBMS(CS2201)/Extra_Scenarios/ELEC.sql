CREATE DATABASE elb;
USE elb;

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Address VARCHAR(200)
);

CREATE TABLE Meter(
  MeterID INT PRIMARY KEY AUTO_INCREMENT,
  CustID INT,
  MeterNo VARCHAR(50),
  InstallDate DATE,
  FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE Bill(
  BillID INT PRIMARY KEY AUTO_INCREMENT,
  MeterID INT,
  BillingPeriodStart DATE,
  BillingPeriodEnd DATE,
  Amount DECIMAL(12,2),
  BillDate DATE,
  FOREIGN KEY (MeterID) REFERENCES Meter(MeterID)
);

INSERT INTO Customer(Name,Address) VALUES ('Ajita','Area 1'),('Balu','Area 2'),('Charu','Area 3'),('Deep','Area 4'),('Ela','Area 5');
INSERT INTO Meter(CustID,MeterNo,InstallDate) VALUES (1,'MTR1001','2023-01-01'),(2,'MTR1002','2023-02-01'),(3,'MTR1003','2023-03-01'),(4,'MTR1004','2023-04-01'),(5,'MTR1005','2023-05-01');
INSERT INTO Bill(MeterID,BillingPeriodStart,BillingPeriodEnd,Amount,BillDate) VALUES (1,'2025-10-01','2025-10-31',1200.00,'2025-11-01'),(2,'2025-10-01','2025-10-31',1500.00,'2025-11-01'),(3,'2025-10-01','2025-10-31',800.00,'2025-11-01'),(4,'2025-10-01','2025-10-31',2200.00,'2025-11-01'),(5,'2025-10-01','2025-10-31',950.00,'2025-11-01');

SELECT c.Name,SUM(b.Amount) AS TotalBills FROM Bill b JOIN Meter m ON b.MeterID=m.MeterID JOIN Customer c ON m.CustID=c.CustID GROUP BY c.CustID;
SELECT * FROM Bill WHERE BillingPeriodEnd BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE();

DELIMITER //
CREATE PROCEDURE AddOrUpdateBill(IN bid INT,IN mid INT,IN startd DATE,IN endd DATE,IN amt DECIMAL(12,2),IN bdate DATE)
BEGIN
  IF EXISTS(SELECT 1 FROM Bill WHERE BillID=bid) THEN
    UPDATE Bill SET MeterID=mid,BillingPeriodStart=startd,BillingPeriodEnd=endd,Amount=amt,BillDate=bdate WHERE BillID=bid;
  ELSE
    INSERT INTO Bill(MeterID,BillingPeriodStart,BillingPeriodEnd,Amount,BillDate) VALUES(mid,startd,endd,amt,bdate);
  END IF;
END //
DELIMITER ;
