CREATE DATABASE Air;
USE Air;

CREATE TABLE Flight(
  FlightID INT PRIMARY KEY AUTO_INCREMENT,
  FlightName VARCHAR(50),
  Date DATE
);

CREATE TABLE Passenger(
  PassengerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Booking(
  BookingID INT PRIMARY KEY AUTO_INCREMENT,
  FlightID INT,
  PassengerID INT,
  FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
  FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

INSERT INTO Flight(FlightName,Date) VALUES ('AI101','2025-11-10'),('6E502','2025-11-11');
INSERT INTO Passenger(Name) VALUES ('Manoj'),('Ritu');
INSERT INTO Booking(FlightID,PassengerID) VALUES (1,1),(2,2);

SELECT f.FlightName,p.Name FROM Booking b JOIN Flight f ON b.FlightID=f.FlightID JOIN Passenger p ON b.PassengerID=p.PassengerID;
SELECT FlightID,COUNT(PassengerID) AS TotalPassengers FROM Booking GROUP BY FlightID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateFlightBooking(IN bid INT,IN fid INT,IN pid INT)
BEGIN
  IF EXISTS(SELECT * FROM Booking WHERE BookingID=bid) THEN
    UPDATE Booking SET FlightID=fid,PassengerID=pid WHERE BookingID=bid;
  ELSE
    INSERT INTO Booking(FlightID,PassengerID) VALUES(fid,pid);
  END IF;
END //
DELIMITER ;
