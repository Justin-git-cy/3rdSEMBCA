CREATE DATABASE Rent;
Use Rent;

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50)
);

CREATE TABLE Vehicle (
  vehicle_id INT PRIMARY KEY,
  model VARCHAR(50),
  rent_price DECIMAL(8,2)
);

CREATE TABLE Rental (
  rental_id INT PRIMARY KEY,
  customer_id INT,
  vehicle_id INT,
  total_rent DECIMAL(8,2),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

INSERT INTO Customer VALUES (1,'Rohan'),(2,'Sneha'),(3,'Kiran');
INSERT INTO Vehicle VALUES (1,'Honda City',2500),(2,'Maruti Swift',2000),(3,'Hyundai i20',2200);
INSERT INTO Rental VALUES (1,1,1,2500),(2,2,2,2000),(3,1,3,2200);

SELECT c.customer_name, v.model
   FROM Rental r
   INNER JOIN Customer c ON r.customer_id = c.customer_id
   INNER JOIN Vehicle v ON r.vehicle_id = v.vehicle_id;

SELECT c.customer_name, v.model
   FROM Customer c
   LEFT OUTER JOIN Rental r ON c.customer_id = r.customer_id
   LEFT OUTER JOIN Vehicle v ON r.vehicle_id = v.vehicle_id;

SELECT v.model, COUNT(r.rental_id) AS total_rentals
   FROM Rental r
   INNER JOIN Vehicle v ON r.vehicle_id = v.vehicle_id
   GROUP BY v.model;

 SELECT SUM(total_rent) AS total_rent_collected FROM Rental;

 SELECT AVG(rent_price) AS avg_rent_per_vehicle FROM Vehicle;
