CREATE DATABASE Banki;
USE Banki;

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Account(
  AccID INT PRIMARY KEY AUTO_INCREMENT,
  CustID INT,
  Balance DECIMAL(10,2),
  FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE Transaction(
  TransID INT PRIMARY KEY AUTO_INCREMENT,
  AccID INT,
  Amount DECIMAL(10,2),
  Type VARCHAR(10),
  Date DATE,
  FOREIGN KEY (AccID) REFERENCES Account(AccID)
);

INSERT INTO Customer(Name) VALUES ('Ravi'),('Sita');
INSERT INTO Account(CustID,Balance) VALUES (1,10000),(2,20000);
INSERT INTO Transaction(AccID,Amount,Type,Date) VALUES (1,2000,'Deposit','2025-11-01'),(2,1000,'Withdraw','2025-11-03');

SELECT * FROM Transaction WHERE Date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);
SELECT AccID,SUM(Amount) AS TotalDeposit FROM Transaction WHERE Type='Deposit' GROUP BY AccID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateTransaction(IN tid INT,IN aid INT,IN amt DECIMAL(10,2),IN typ VARCHAR(10),IN tdate DATE)
BEGIN
  IF EXISTS(SELECT * FROM Transaction WHERE TransID=tid) THEN
    UPDATE Transaction SET AccID=aid,Amount=amt,Type=typ,Date=tdate WHERE TransID=tid;
  ELSE
    INSERT INTO Transaction(AccID,Amount,Type,Date) VALUES(aid,amt,typ,tdate);
  END IF;
END //
DELIMITER ;
