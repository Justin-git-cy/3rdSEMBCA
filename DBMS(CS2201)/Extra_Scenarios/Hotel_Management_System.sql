CREATE DATABASE Hotel;
USE Hotel;

CREATE TABLE Guests (
  guest_id INT PRIMARY KEY,
  guest_name VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(100)
);

CREATE TABLE Rooms (
  room_id INT PRIMARY KEY,
  room_number VARCHAR(10),
  room_type VARCHAR(50), -- Single, Double, Suite
  rate_per_night DECIMAL(10,2)
);

CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  guest_id INT,
  room_id INT,
  checkin_date DATE,
  checkout_date DATE,
  total_amount DECIMAL(12,2),
  FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

INSERT INTO Guests VALUES
(1,'Adriana Lopez','+91-8888000001','AdrianaLopez@gmail.com'),
(2,'Racheal Pereira','+91-8888000002','RachaelPereira@gmail.com'),
(3,'Elena Rossi','+39-8888000003','ElenaRossi@gmail.com'),
(4,'Diego Garcia','+34-8888000004','DiegoGarcia@gmail.com');

INSERT INTO Rooms VALUES
(1,'101','Single',2500.00),
(2,'102','Double',4000.00),
(3,'201','Suite',8000.00),
(4,'301','Deluxe',6000.00);

INSERT INTO Bookings VALUES
(5001,1,2,'2025-10-20','2025-10-23',4000*3),
(5002,2,1,'2025-09-12','2025-09-14',2500*2),
(5003,3,3,'2025-11-01','2025-11-04',8000*3),
(5004,4,4,'2025-10-15','2025-10-16',6000*1);


-- Total revenue per room type
SELECT r.room_type, SUM(b.total_amount) AS revenue, COUNT(b.booking_id) AS bookings
FROM Rooms r
LEFT JOIN Bookings b ON r.room_id = b.room_id
GROUP BY r.room_type
ORDER BY revenue DESC;

-- Booking duration using date functions
SELECT booking_id, guest_id, room_id, checkin_date, checkout_date,
       DATEDIFF(checkout_date, checkin_date) AS nights
FROM Bookings;

-- Procedure to insert booking (computes total amount using room rate)
DELIMITER //
CREATE PROCEDURE InsertRoomBooking(
  IN bid INT, IN gid INT, IN rid INT, IN cin DATE, IN cout DATE
)
BEGIN
  DECLARE nights INT;
  DECLARE rate DECIMAL(10,2);
  SET nights = DATEDIFF(cout, cin);
  SELECT rate_per_night INTO rate FROM Rooms WHERE room_id = rid;
  INSERT INTO Bookings VALUES (bid, gid, rid, cin, cout, rate * GREATEST(nights,1));
END //
DELIMITER ;

-- Procedure to update checkout date (and recalc total)
DELIMITER //
CREATE PROCEDURE UpdateCheckout(IN bid INT, IN new_cout DATE)
BEGIN
  DECLARE cin DATE;
  DECLARE rid INT;
  DECLARE nights INT;
  DECLARE rate DECIMAL(10,2);
  SELECT checkin_date, room_id INTO cin, rid FROM Bookings WHERE booking_id = bid;
  SET nights = DATEDIFF(new_cout, cin);
  SELECT rate_per_night INTO rate FROM Rooms WHERE room_id = rid;
  UPDATE Bookings SET checkout_date = new_cout, total_amount = rate * GREATEST(nights,1) WHERE booking_id = bid;
END //
DELIMITER ;
