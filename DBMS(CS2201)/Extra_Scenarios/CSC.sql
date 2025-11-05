CREATE DATABASE csc;
USE csc;

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Phone VARCHAR(50)
);

CREATE TABLE Vehicle(
  VehID INT PRIMARY KEY AUTO_INCREMENT,
  CustID INT,
  RegNo VARCHAR(50),
  Model VARCHAR(100),
  FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE ServiceRecord(
  ServiceID INT PRIMARY KEY AUTO_INCREMENT,
  VehID INT,
  ServiceDate DATE,
  Description VARCHAR(255),
  Cost DECIMAL(10,2),
  FOREIGN KEY (VehID) REFERENCES Vehicle(VehID)
);

INSERT INTO Customer(Name,Phone) VALUES ('Ajay','9000000001'),('Sunita','9000000002'),('Vikram','9000000003');
INSERT INTO Vehicle(CustID,RegNo,Model) VALUES (1,'KA01AB1234','Swift'),(1,'KA01AB5678','Alto'),(2,'KA02CD1111','i20');
INSERT INTO ServiceRecord(VehID,ServiceDate,Description,Cost) VALUES (1,'2025-10-01','Oil Change',1200.00),(2,'2025-10-05','Tire Replace',4000.00),(3,'2025-10-10','Full Service',3500.00);

SELECT c.Name,COUNT(s.ServiceID) AS TotalServices FROM ServiceRecord s JOIN Vehicle v ON s.VehID=v.VehID JOIN Customer c ON v.CustID=c.CustID GROUP BY c.CustID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateService(IN sid INT,IN vid INT,IN sdate DATE,IN descp VARCHAR(255),IN cost DECIMAL(10,2))
BEGIN
  IF EXISTS(SELECT 1 FROM ServiceRecord WHERE ServiceID=sid) THEN
    UPDATE ServiceRecord SET VehID=vid,ServiceDate=sdate,Description=descp,Cost=cost WHERE ServiceID=sid;
  ELSE
    INSERT INTO ServiceRecord(VehID,ServiceDate,Description,Cost) VALUES(vid,sdate,descp,cost);
  END IF;
END //
DELIMITER ;
