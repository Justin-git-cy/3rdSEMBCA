CREATE DATABASE Vehi;
USE Vehi;

CREATE TABLE Vehicle(
  VehID INT PRIMARY KEY AUTO_INCREMENT,
  Model VARCHAR(50),
  RentPerDay DECIMAL(10,2)
);

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Rental(
  RentID INT PRIMARY KEY AUTO_INCREMENT,
  VehID INT,
  CustID INT,
  RentDate DATE,
  ReturnDate DATE,
  FOREIGN KEY (VehID) REFERENCES Vehicle(VehID),
  FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

INSERT INTO Vehicle(Model,RentPerDay) VALUES ('Sedan',1000),('SUV',1500);
INSERT INTO Customer(Name) VALUES ('Arun'),('Divya');
INSERT INTO Rental(VehID,CustID,RentDate,ReturnDate) VALUES (1,1,'2025-11-01','2025-11-03'),(2,2,'2025-11-02','2025-11-04');

SELECT r.RentID,c.Name,v.Model FROM Rental r JOIN Customer c ON r.CustID=c.CustID JOIN Vehicle v ON r.VehID=v.VehID;
SELECT c.Name,SUM(DATEDIFF(ReturnDate,RentDate)*v.RentPerDay) AS TotalRent FROM Rental r JOIN Customer c ON r.CustID=c.CustID JOIN Vehicle v ON r.VehID=v.VehID GROUP BY c.Name;

DELIMITER //
CREATE PROCEDURE AddOrUpdateRental(IN rid INT,IN vid INT,IN cid INT,IN rdate DATE,IN retd DATE)
BEGIN
  IF EXISTS(SELECT * FROM Rental WHERE RentID=rid) THEN
    UPDATE Rental SET VehID=vid,CustID=cid,RentDate=rdate,ReturnDate=retd WHERE RentID=rid;
  ELSE
    INSERT INTO Rental(VehID,CustID,RentDate,ReturnDate) VALUES(vid,cid,rdate,retd);
  END IF;
END //
DELIMITER ;