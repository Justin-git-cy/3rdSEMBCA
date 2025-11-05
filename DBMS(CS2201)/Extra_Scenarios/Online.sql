CREATE DATABASE Store;
Use Store;

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(8,2),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Customer VALUES (1,'Alice'),(2,'Bob'),(3,'David');
INSERT INTO Orders VALUES (1,1,'2025-10-01',500.00),(2,2,'2025-10-05',1200.00),(3,1,'2025-10-15',800.00);

SELECT c.customer_name, o.order_date
   FROM Orders o
   INNER JOIN Customer c ON o.customer_id = c.customer_id;

SELECT c.customer_name, o.order_id
   FROM Customer c
   LEFT OUTER JOIN Orders o ON c.customer_id = o.customer_id;

SELECT c.customer_name, SUM(o.total_amount) AS total_sales
   FROM Orders o
   INNER JOIN Customer c ON o.customer_id = c.customer_id
   GROUP BY c.customer_name;

SELECT MAX(total_amount) AS max_order_amount FROM Orders;

SELECT AVG(total_amount) AS avg_order_amount FROM Orders;
