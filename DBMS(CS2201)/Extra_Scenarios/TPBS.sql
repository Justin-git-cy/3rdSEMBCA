CREATE DATABASE tpb;
USE tpb;

CREATE TABLE Tourist(
  TouristID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(200),
  Contact VARCHAR(50)
);

CREATE TABLE Package(
  PackageID INT PRIMARY KEY AUTO_INCREMENT,
  Destination VARCHAR(200),
  StartDate DATE,
  EndDate DATE,
  Price DECIMAL(12,2)
);

CREATE TABLE Booking(
  BookingID INT PRIMARY KEY AUTO_INCREMENT,
  TouristID INT,
  PackageID INT,
  BookingDate DATE,
  Travelers INT,
  FOREIGN KEY (TouristID) REFERENCES Tourist(TouristID),
  FOREIGN KEY (PackageID) REFERENCES Package(PackageID)
);

INSERT INTO Tourist(Name,Contact) VALUES ('Sanjay','7777000033'),('Maya','6666000044');
INSERT INTO Package(Destination,StartDate,EndDate,Price) VALUES ('Goa','2025-12-20','2025-12-25',25000),( 'Manali','2026-01-10','2026-01-15',30000);
INSERT INTO Booking(TouristID,PackageID,BookingDate,Travelers) VALUES (1,1,'2025-11-01',2),(2,2,'2025-11-03',4);

SELECT p.Destination,COUNT(b.BookingID) AS TotalBookings FROM Booking b JOIN Package p ON b.PackageID=p.PackageID GROUP BY p.Destination;
SELECT * FROM Package WHERE StartDate >= CURDATE() ORDER BY StartDate;

DELIMITER //
CREATE PROCEDURE AddOrUpdateBooking(IN bid INT,IN tid INT,IN pid INT,IN bdate DATE,IN travelers INT)
BEGIN
  IF EXISTS(SELECT 1 FROM Booking WHERE BookingID=bid) THEN
    UPDATE Booking SET TouristID=tid,PackageID=pid,BookingDate=bdate,Travelers=travelers WHERE BookingID=bid;
  ELSE
    INSERT INTO Booking(TouristID,PackageID,BookingDate,Travelers) VALUES(tid,pid,bdate,travelers);
  END IF;
END //
DELIMITER ;
