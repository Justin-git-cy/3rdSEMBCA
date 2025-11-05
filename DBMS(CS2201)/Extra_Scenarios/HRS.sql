CREATE DATABASE Ban;
USE Ban;

CREATE TABLE Guest(
  GuestID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Room(
  RoomID INT PRIMARY KEY AUTO_INCREMENT,
  RoomNo INT,
  Type VARCHAR(20)
);

CREATE TABLE Booking(
  BookingID INT PRIMARY KEY AUTO_INCREMENT,
  GuestID INT,
  RoomID INT,
  CheckIn DATE,
  CheckOut DATE,
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

INSERT INTO Guest(Name) VALUES ('Karan'),('Leena'),('Tina'),('Rohit'),('Meena');
INSERT INTO Room(RoomNo,Type) VALUES (101,'AC'),(102,'Non-AC'),(103,'AC'),(104,'Suite'),(105,'AC');
INSERT INTO Booking(GuestID,RoomID,CheckIn,CheckOut) VALUES (1,1,'2025-11-01','2025-11-03'),(2,2,'2025-11-02','2025-11-04'),(3,3,'2025-11-05','2025-11-07'),(4,4,'2025-11-03','2025-11-06'),(5,5,'2025-11-04','2025-11-08');

SELECT RoomID,COUNT(BookingID) AS TotalBookings FROM Booking GROUP BY RoomID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateBooking(IN bid INT,IN gid INT,IN rid INT,IN cin DATE,IN cout DATE)
BEGIN
  IF EXISTS(SELECT * FROM Booking WHERE BookingID=bid) THEN
    UPDATE Booking SET GuestID=gid,RoomID=rid,CheckIn=cin,CheckOut=cout WHERE BookingID=bid;
  ELSE
    INSERT INTO Booking(GuestID,RoomID,CheckIn,CheckOut) VALUES(gid,rid,cin,cout);
  END IF;
END //
DELIMITER ;