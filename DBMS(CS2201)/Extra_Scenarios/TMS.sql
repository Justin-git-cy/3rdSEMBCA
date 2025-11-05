CREATE DATABASE trp;
USE trp;

CREATE TABLE Driver(
  DriverID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE TABLE Vehicle(
  VehicleID INT PRIMARY KEY AUTO_INCREMENT,
  RegNo VARCHAR(50),
  Model VARCHAR(100)
);

CREATE TABLE Trip(
  TripID INT PRIMARY KEY AUTO_INCREMENT,
  DriverID INT,
  VehicleID INT,
  TripDate DATE,
  DistanceKm DECIMAL(7,2),
  FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
  FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);

INSERT INTO Driver(Name) VALUES ('Suresh'),('Nina');
INSERT INTO Vehicle(RegNo,Model) VALUES ('KA01AB1234','Truck'),('KA02CD5678','Van');
INSERT INTO Trip(DriverID,VehicleID,TripDate,DistanceKm) VALUES (1,1,'2025-11-01',120.5),(1,2,'2025-11-02',75.0),(2,2,'2025-11-03',200.0);

SELECT d.Name,SUM(t.DistanceKm) AS TotalDistance FROM Trip t JOIN Driver d ON t.DriverID=d.DriverID GROUP BY d.Name;
DELIMITER //
CREATE PROCEDURE AddOrUpdateTrip(IN tid INT,IN did INT,IN vid INT,IN tdate DATE,IN dist DECIMAL(7,2))
BEGIN
  IF EXISTS(SELECT * FROM Trip WHERE TripID=tid) THEN
    UPDATE Trip SET DriverID=did,VehicleID=vid,TripDate=tdate,DistanceKm=dist WHERE TripID=tid;
  ELSE
    INSERT INTO Trip(DriverID,VehicleID,TripDate,DistanceKm) VALUES(did,vid,tdate,dist);
  END IF;
END //
DELIMITER ;
