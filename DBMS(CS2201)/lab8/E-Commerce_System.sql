CREATE DATABASE ECommerceDB;
USE ECommerceDB;

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  email VARCHAR(100),
  city VARCHAR(50)
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(150),
  price DECIMAL(10,2),
  stock INT
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(12,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
  orderitem_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  item_price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1,'Kendall Torres','KendallTorres@gmail.com','Barcelona'),
(2,'Lucia Fernández','lucia.F@gmail.com','Valencia'),
(3,'Oliver Smith','oliver.S@gmail.com','London');

INSERT INTO Products VALUES
(201,'Wireless Mouse',799.00,50),
(202,'Mechanical Keyboard',1250.00,20),
(203,'USB-C Cable',399.00,100),
(204,'Noise Cancelling Headphones',4999.00,15);

INSERT INTO Orders VALUES
(9001,1,'2025-10-10',2049.00),
(9002,2,'2025-10-11',399.00),
(9003,3,'2025-10-12',4999.00);

INSERT INTO OrderItems VALUES
(1,9001,201,1,799.00),
(2,9001,202,1,1250.00),
(3,9002,203,1,399.00),
(4,9003,204,1,4999.00);

-- Total sales per product
SELECT p.product_id, p.product_name, SUM(oi.quantity * oi.item_price) AS total_sales,
       SUM(oi.quantity) AS total_units_sold
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

-- Most purchased product (by units)
SELECT product_id, product_name, total_units_sold
FROM (
  SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_units_sold
  FROM Products p JOIN OrderItems oi ON p.product_id = oi.product_id
  GROUP BY p.product_id, p.product_name
) t
ORDER BY total_units_sold DESC
LIMIT 1;

-- Join customers and orders
SELECT o.order_id, c.customer_name, o.order_date, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- Procedure to update product stock (delta negative to reduce)
DELIMITER //
CREATE PROCEDURE UpdateProductStock(IN pid INT, IN delta INT)
BEGIN
  UPDATE Products SET stock = stock + delta WHERE product_id = pid;
END //
DELIMITER ;

-- Procedure to insert an order (simple example; does not check stock here)
DELIMITER //
CREATE PROCEDURE CreateOrder(
  IN oid INT, IN cid INT, IN od DATE, IN total DECIMAL(12,2)
)
BEGIN
  INSERT INTO Orders VALUES (oid, cid, od, total);
END //
DELIMITER ;
