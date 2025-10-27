CREATE DATABASE FlightDB;
USE FlightDB;

CREATE TABLE Passengers (
  passenger_id INT PRIMARY KEY,
  passenger_name VARCHAR(100),
  passport_no VARCHAR(30),
  phone VARCHAR(20)
);

CREATE TABLE Flights (
  flight_id INT PRIMARY KEY,
  flight_no VARCHAR(20),
  origin VARCHAR(50),
  destination VARCHAR(50),
  flight_date DATE,
  capacity INT
);

CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  passenger_id INT,
  flight_id INT,
  booking_date DATE,
  seat_no VARCHAR(10),
  fare DECIMAL(10,2),
  FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
  FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

INSERT INTO Passengers VALUES
(1,'Trevor Wallace','P1234567','+91-9000000001'),
(2,'Trisha Muller','P7654321','+49-9000000002'),
(3,'Julia Gonsalvez','P9988776','+34-9000000003'),
(4,'Sakura Tanaka','P5566778','+81-9000000004');

INSERT INTO Flights VALUES
(301,'AI-101','Bangalore','Delhi','2025-11-01',180),
(302,'IB-205','Madrid','Barcelona','2025-11-05',150),
(303,'JL-501','Tokyo','Osaka','2025-11-03',160);

INSERT INTO Bookings VALUES
(4001,1,301,'2025-10-10','12A',4500.00),
(4002,2,301,'2025-10-11','12B',4500.00),
(4003,3,302,'2025-10-12','5C',120.00),
(4004,4,303,'2025-10-13','7D',80.00);


-- Total passengers per flight
SELECT f.flight_id, f.flight_no, f.origin, f.destination, COUNT(b.booking_id) AS total_passengers
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.flight_no, f.origin, f.destination;

-- Flight details for each passenger
SELECT p.passenger_name, f.flight_no, f.origin, f.destination, f.flight_date, b.seat_no
FROM Bookings b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
ORDER BY f.flight_date;

-- Procedure to insert booking (simple, doesn't check seat uniqueness)
DELIMITER //
CREATE PROCEDURE InsertBooking(
  IN bid INT, IN pid INT, IN fid INT, IN bdate DATE, IN seat VARCHAR(10), IN fare_amt DECIMAL(10,2)
)
BEGIN
  INSERT INTO Bookings VALUES (bid, pid, fid, bdate, seat, fare_amt);
END //
DELIMITER ;

-- Procedure to update booking seat
DELIMITER //
CREATE PROCEDURE UpdateBookingSeat(IN bid INT, IN new_seat VARCHAR(10))
BEGIN
  UPDATE Bookings SET seat_no = new_seat WHERE booking_id = bid;
END //
DELIMITER ;
