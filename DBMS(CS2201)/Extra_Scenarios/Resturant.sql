CREATE DATABASE Res;
Use Res;

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50)
);

CREATE TABLE Menu (
  item_id INT PRIMARY KEY,
  item_name VARCHAR(50),
  price DECIMAL(8,2)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(8,2),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE OrderDetails (
  order_id INT,
  item_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (item_id) REFERENCES Menu(item_id)
);

INSERT INTO Customer VALUES (1,'Anita'),(2,'Ravi'),(3,'Sonia');
INSERT INTO Menu VALUES (1,'Pizza',300),(2,'Burger',150),(3,'Pasta',250);
INSERT INTO Orders VALUES (1,1,600),(2,2,300),(3,1,450);
INSERT INTO OrderDetails VALUES (1,1,2),(2,2,2),(3,3,3);

SELECT o.order_id, c.customer_name, o.total_amount
   FROM Orders o
   INNER JOIN Customer c ON o.customer_id = c.customer_id;

SELECT m.item_name, od.order_id
   FROM Menu m
   LEFT OUTER JOIN OrderDetails od ON m.item_id = od.item_id;

 SELECT m.item_name, SUM(od.quantity) AS total_quantity_sold
   FROM OrderDetails od
   INNER JOIN Menu m ON od.item_id = m.item_id
   GROUP BY m.item_name;

 SELECT MAX(total_amount) AS highest_order_amount FROM Orders;

 SELECT AVG(price) AS avg_item_price FROM Menu;
