CREATE DATABASE log;
USE log;

CREATE TABLE Package(
  PackID INT PRIMARY KEY AUTO_INCREMENT,
  TrackingNo VARCHAR(100),
  WeightKg DECIMAL(6,2),
  Destination VARCHAR(200)
);

CREATE TABLE Courier(
  CourierID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Phone VARCHAR(50)
);

CREATE TABLE Delivery(
  DeliveryID INT PRIMARY KEY AUTO_INCREMENT,
  PackID INT,
  CourierID INT,
  PickupDate DATE,
  DeliveryDate DATE,
  Status VARCHAR(50),
  FOREIGN KEY (PackID) REFERENCES Package(PackID),
  FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
);

INSERT INTO Package(TrackingNo,WeightKg,Destination) VALUES ('TRK001',2.5,'Bengaluru'),('TRK002',5.0,'Mumbai');
INSERT INTO Courier(Name,Phone) VALUES ('FastEx','7777000011'),('ShipIt','6666000022');
INSERT INTO Delivery(PackID,CourierID,PickupDate,DeliveryDate,Status) VALUES (1,1,'2025-11-01','2025-11-03','Delivered'),(2,2,'2025-11-02',NULL,'In Transit');

SELECT c.Name,p.TrackingNo,d.Status,d.DeliveryDate FROM Delivery d JOIN Courier c ON d.CourierID=c.CourierID JOIN Package p ON d.PackID=p.PackID;
SELECT c.Name,COUNT(d.DeliveryID) AS TotalDeliveries FROM Delivery d JOIN Courier c ON d.CourierID=c.CourierID GROUP BY c.Name;

DELIMITER //
CREATE PROCEDURE AddOrUpdateDelivery(IN did INT,IN pid INT,IN cid INT,IN pdate DATE,IN ddate DATE,IN st VARCHAR(50))
BEGIN
  IF EXISTS(SELECT 1 FROM Delivery WHERE DeliveryID=did) THEN
    UPDATE Delivery SET PackID=pid,CourierID=cid,PickupDate=pdate,DeliveryDate=ddate,Status=st WHERE DeliveryID=did;
  ELSE
    INSERT INTO Delivery(PackID,CourierID,PickupDate,DeliveryDate,Status) VALUES(pid,cid,pdate,ddate,st);
  END IF;
END //
DELIMITER ;
