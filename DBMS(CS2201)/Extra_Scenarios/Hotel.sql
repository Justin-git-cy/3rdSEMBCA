CREATE DATABASE Hotels;
Use Hotels;

CREATE TABLE Guest (
  guest_id INT PRIMARY KEY,
  guest_name VARCHAR(50)
);

CREATE TABLE Room (
  room_id INT PRIMARY KEY,
  room_type VARCHAR(50),
  price DECIMAL(8,2)
);

CREATE TABLE Booking (
  booking_id INT PRIMARY KEY,
  guest_id INT,
  room_id INT,
  total_amount DECIMAL(8,2),
  FOREIGN KEY (guest_id) REFERENCES Guest(guest_id),
  FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

INSERT INTO Guest VALUES (1,'John'),(2,'Alice'),(3,'Mark');
INSERT INTO Room VALUES (1,'Deluxe',2000),(2,'Suite',3500),(3,'Standard',1500);
INSERT INTO Booking VALUES (1,1,1,2000),(2,2,2,3500),(3,1,3,1500);

 SELECT g.guest_name, r.room_type
   FROM Booking b
   INNER JOIN Guest g ON b.guest_id = g.guest_id
   INNER JOIN Room r ON b.room_id = r.room_id;

SELECT r.room_type, g.guest_name
   FROM Room r
   LEFT OUTER JOIN Booking b ON r.room_id = b.room_id
   LEFT OUTER JOIN Guest g ON b.guest_id = g.guest_id;

SELECT r.room_type, COUNT(b.booking_id) AS total_bookings
   FROM Booking b
   INNER JOIN Room r ON b.room_id = r.room_id
   GROUP BY r.room_type;

SELECT MAX(price) AS max_room_price FROM Room;

SELECT SUM(total_amount) AS total_revenue FROM Booking;
