CREATE DATABASE IF NOT EXISTS CinemaDB;
USE CinemaDB;

CREATE TABLE Movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(200),
  duration_min INT,
  genre VARCHAR(50)
);

CREATE TABLE Shows (
  show_id INT PRIMARY KEY,
  movie_id INT,
  show_date DATE,
  show_time TIME,
  auditorium VARCHAR(50),
  seat_capacity INT,
  ticket_price DECIMAL(8,2),
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  show_id INT,
  seats_booked INT,
  booking_date DATETIME,
  total_amount DECIMAL(10,2),
  FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

INSERT INTO Movies VALUES
(1,'Space Odyssey','140','Sci-Fi'),
(2,'Romantic Saga','120','Romance'),
(3,'La Vida Loca','110','Drama');

INSERT INTO Shows VALUES
(101,1,'2025-10-25','18:30:00','Auditorium 1',200,300.00),
(102,2,'2025-10-25','20:30:00','Auditorium 2',150,250.00),
(103,3,'2025-10-26','19:00:00','Auditorium 3',120,280.00);

INSERT INTO Bookings VALUES
(2001,'Kiran Das',101,2,'2025-10-20 10:00:00',600.00),
(2002,'Neha Agarwal',102,3,'2025-10-21 11:00:00',750.00),
(2003,'Maria López',103,1,'2025-10-22 12:00:00',280.00);

SELECT m.movie_id, m.title, SUM(b.seats_booked) AS tickets_sold, SUM(b.total_amount) AS revenue
FROM Movies m
LEFT JOIN Shows s ON m.movie_id = s.movie_id
LEFT JOIN Bookings b ON s.show_id = b.show_id
GROUP BY m.movie_id, m.title
ORDER BY tickets_sold DESC;

SELECT b.booking_id, b.customer_name, m.title, s.show_date, s.show_time, b.seats_booked, b.total_amount
FROM Bookings b
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
ORDER BY b.booking_date DESC;

DELIMITER //
CREATE PROCEDURE InsertBooking(
  IN bid INT, IN cname VARCHAR(100), IN sid INT, IN seats INT
)
BEGIN
  DECLARE cap INT;
  DECLARE price DECIMAL(8,2);
  DECLARE booked INT;
  SELECT seat_capacity, ticket_price INTO cap, price FROM Shows WHERE show_id = sid;
  -- Calculate seats already booked

  SELECT COALESCE(SUM(seats_booked),0) INTO booked FROM Bookings WHERE show_id = sid;
  IF booked + seats <= cap THEN
    INSERT INTO Bookings VALUES (bid, cname, sid, seats, NOW(), price * seats);
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough seats available';
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateBookingSeats(IN bid INT, IN new_seats INT)
BEGIN
  DECLARE sid INT;
  DECLARE cap INT;
  DECLARE price DECIMAL(8,2);
  DECLARE booked_other INT;
  SELECT show_id INTO sid FROM Bookings WHERE booking_id = bid;
  SELECT seat_capacity, ticket_price INTO cap, price FROM Shows WHERE show_id = sid;
 
  SELECT COALESCE(SUM(seats_booked),0) - (SELECT seats_booked FROM Bookings WHERE booking_id = bid)
    INTO booked_other FROM Bookings WHERE show_id = sid;
  IF booked_other + new_seats <= cap THEN
    UPDATE Bookings SET seats_booked = new_seats, total_amount = new_seats * price WHERE booking_id = bid;
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough seats available for update';
  END IF;
END //
DELIMITER ;
