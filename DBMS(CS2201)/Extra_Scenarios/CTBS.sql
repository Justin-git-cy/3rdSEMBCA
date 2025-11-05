CREATE DATABASE cin;
USE cin;

CREATE TABLE Movie(
  MovieID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(100),
  Duration INT
);

CREATE TABLE ShowTime(
  ShowID INT PRIMARY KEY AUTO_INCREMENT,
  MovieID INT,
  ShowDate DATE,
  ShowTime TIME,
  FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

CREATE TABLE Booking(
  BookingID INT PRIMARY KEY AUTO_INCREMENT,
  ShowID INT,
  Tickets INT,
  BookingDate DATE,
  FOREIGN KEY (ShowID) REFERENCES ShowTime(ShowID)
);

INSERT INTO Movie(Title,Duration) VALUES ('Inception',148),('Avatar',162);
INSERT INTO ShowTime(MovieID,ShowDate,ShowTime) VALUES (1,'2025-11-10','18:30:00'),(1,'2025-11-11','21:00:00'),(2,'2025-11-11','19:00:00');
INSERT INTO Booking(ShowID,Tickets,BookingDate) VALUES (1,50,'2025-11-05'),(2,30,'2025-11-06'),(3,100,'2025-11-07');

SELECT m.Title,SUM(b.Tickets) AS TotalTickets FROM Booking b JOIN ShowTime s ON b.ShowID=s.ShowID JOIN Movie m ON s.MovieID=m.MovieID GROUP BY m.Title;
SELECT * FROM ShowTime WHERE ShowDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);

DELIMITER //
CREATE PROCEDURE AddOrUpdateBooking(IN bid INT,IN sid INT,IN tcks INT,IN bdate DATE)
BEGIN
  IF EXISTS(SELECT * FROM Booking WHERE BookingID=bid) THEN
    UPDATE Booking SET ShowID=sid,Tickets=tcks,BookingDate=bdate WHERE BookingID=bid;
  ELSE
    INSERT INTO Booking(ShowID,Tickets,BookingDate) VALUES(sid,tcks,bdate);
  END IF;
END //
DELIMITER ;
