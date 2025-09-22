-- Lab Experiment 05: To implement different types of joins: Inner Join, Outer Join (Left, Right, Full), and Natural Join.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Justin
-- USN: 1RUA24BCA0041
-- SECTION: --
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Write your code below this line along with the output 
/*'root@localhost', 'RVU-PC-060', '8.4.6', '2025-09-22 05:55:50'
*/

CREATE database Com;
use com;
-- table 01: Customers
-- CREATE  a TABLE named Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(50),city VARCHAR(50)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- insert 5 records
INSERT INTO Customers (customer_id, customer_name, city) VALUES
(1, 'John Doe', 'Bangalore'),
(2, 'Alice Smith', 'Chennai'),
(3, 'Bob Johnson', 'Mumbai'),
(4, 'Eve Davis', 'Bangalore'),
(5, 'Charlie Brown', 'Hyderabad');

-- TABLE:02 Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- CREATE a TABLE named Orders (order_id INT PRIMARY KEY,customer_id INT foreign key,product_name VARCHAR(50),order_date DATE,
    -- insert 5 records
INSERT INTO Orders (order_id, customer_id, product_name, order_date) VALUES
(101, 1, 'Laptop', '2025-09-01'),
(102, 1, 'Smartphone', '2025-09-03'),
(103, 2, 'Headphones', '2025-09-04'),
(104, 4, 'Tablet', '2025-09-05'),
(105, 3, 'Smartwatch', '2025-09-06');


-- TASK FOR STUDENTS 

 
-- Write and Execute Queries
/*
1. Inner Join – */

-- 1. Find all orders placed by customers from the city "Bangalore."
SELECT o.order_id, c.customer_name, o.product_name, o.order_date
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.city = 'Bangalore';

/*'101', 'John Doe', 'Laptop', '2025-09-01'
'102', 'John Doe', 'Smartphone', '2025-09-03'
'104', 'Eve Davis', 'Tablet', '2025-09-05'
*/

-- 2. List all customers with the products they ordered.
SELECT c.customer_name, o.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

/*'John Doe', 'Laptop'
'John Doe', 'Smartphone'
'Alice Smith', 'Headphones'
'Bob Johnson', 'Smartwatch'
'Eve Davis', 'Tablet'
*/ 

-- 3. Show customer names and their order dates.
SELECT c.customer_name, o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;
/*'John Doe', '2025-09-01'
'John Doe', '2025-09-03'
'Alice Smith', '2025-09-04'
'Bob Johnson', '2025-09-06'
'Eve Davis', '2025-09-05'
*/

-- 4. Display order IDs with the corresponding customer names.
SELECT o.order_id, c.customer_name
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

/*'101', 'John Doe'
'102', 'John Doe'
'103', 'Alice Smith'
'105', 'Bob Johnson'
'104', 'Eve Davis'
*/

-- 5. Find the number of orders placed by each customer.
SELECT c.customer_name, COUNT(o.order_id) AS num_orders
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

/*'John Doe', '2'
'Alice Smith', '1'
'Bob Johnson', '1'
'Eve Davis', '1'
*/

-- 6. Show city names along with the products ordered by customers.
SELECT c.city, o.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

/*'Bangalore', 'Laptop'
'Bangalore', 'Smartphone'
'Chennai', 'Headphones'
'Mumbai', 'Smartwatch'
'Bangalore', 'Tablet'
*/

/* 
2  Left Outer Join – */
-- 1. Find all customers and their orders, even if a customer has no orders.
SELECT c.customer_name, o.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

/*'John Doe', 'Laptop'
'John Doe', 'Smartphone'
'Alice Smith', 'Headphones'
'Bob Johnson', 'Smartwatch'
'Eve Davis', 'Tablet'
*/

-- 2. List all customers and the products they ordered.
SELECT c.customer_name, o.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

/*'John Doe', 'Laptop'
'John Doe', 'Smartphone'
'Alice Smith', 'Headphones'
'Bob Johnson', 'Smartwatch'
'Eve Davis', 'Tablet'
*/

-- 3. Show customer IDs, names, and their order IDs.
SELECT c.customer_id, c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

/*'1', 'John Doe', '101'
'1', 'John Doe', '102'
'2', 'Alice Smith', '103'
'3', 'Bob Johnson', '105'
'4', 'Eve Davis', '104'
*/

-- 4. Find the total number of orders (if any) placed by each customer.
SELECT c.customer_name, COUNT(o.order_id) AS num_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

/*'John Doe', '2'
'Alice Smith', '1'
'Bob Johnson', '1'
'Eve Davis', '1'
'Charlie Brown', '0'
*/

-- 5. Retrieve customers who have not placed any orders.
SELECT c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 'Charlie Brown'


-- 6. Display customer names with their order dates.
SELECT c.customer_name, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

/*'John Doe', '2025-09-01'
'John Doe', '2025-09-03'
'Alice Smith', '2025-09-04'
'Bob Johnson', '2025-09-06'
'Eve Davis', '2025-09-05'
*/

/* 3: Right Outer Join – */

-- 1. Find all orders and their corresponding customers, even if an order doesn't have a customer associated with it.
SELECT o.order_id, c.customer_name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

/*'101', 'John Doe'
'102', 'John Doe'
'103', 'Alice Smith'
'105', 'Bob Johnson'
'104', 'Eve Davis'*/

-- 2. Show all orders with the customer names.
SELECT o.order_id, c.customer_name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

/*'101', 'John Doe'
'102', 'John Doe'
'103', 'Alice Smith'
'105', 'Bob Johnson'
'104', 'Eve Davis'
NULL, 'Charlie Brown'

*/
-- 3. Display product names with the customers who ordered them.
SELECT o.product_name, c.customer_name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

/*'Laptop', 'John Doe'
'Smartphone', 'John Doe'
'Headphones', 'Alice Smith'
'Smartwatch', 'Bob Johnson'
'Tablet', 'Eve Davis'
*/

-- 4. List order IDs with customer cities.
SELECT o.order_id, c.city
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

/*'101', 'Bangalore'
'102', 'Bangalore'
'103', 'Chennai'
'105', 'Mumbai'
'104', 'Bangalore'
NULL, 'Hyderabad'
*/

-- 5. Find the number of orders per customer (include those without orders).
SELECT c.customer_name, COUNT(o.order_id) AS num_orders
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

/*'John Doe', '2'
'Alice Smith', '1'
'Bob Johnson', '1'
'Eve Davis', '1'
*/

-- 6. Retrieve customers who do not have any matching orders.
SELECT c.customer_name
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- customer_name


/* 4: Full Outer Join – */   

-- 1. Find all customers and their orders, including those customers with no orders and orders without a customer.
SELECT c.customer_name, o.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT c.customer_name, o.product_name
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

/*'John Doe', 'Laptop'
'John Doe', 'Smartphone'
'Alice Smith', 'Headphones'
'Bob Johnson', 'Smartwatch'
'Eve Davis', 'Tablet'
'Charlie Brown', NULL
*/

-- 2. List all customers and products, whether they placed an order or not.
     SELECT c.customer_name, o.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT c.customer_name, o.product_name
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

/*'John Doe', 'Laptop'
'John Doe', 'Smartphone'
'Alice Smith', 'Headphones'
'Bob Johnson', 'Smartwatch'
'Eve Davis', 'Tablet'
'Charlie Brown', NULL
*/ 

-- 3. Show customer IDs with order IDs (include unmatched ones).
SELECT c.customer_id, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT c.customer_id, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

/*'1', '101'
'1', '102'
'2', '103'
'3', '105'
'4', '104'
'5', NULL
*/

-- 4. Display customer names with order dates.
SELECT c.customer_name, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT c.customer_name, o.order_date
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

/*'John Doe', '2025-09-01'
'John Doe', '2025-09-03'
'Alice Smith', '2025-09-04'
'Bob Johnson', '2025-09-06'
'Eve Davis', '2025-09-05'
'Charlie Brown', NULL
*/

-- 5. Find all unmatched records (customers without orders and orders without customers).
SELECT c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL

UNION

SELECT c.customer_name, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

/*'Charlie Brown', NULL
*/

-- 6. Show customer cities with products.
SELECT c.city, o.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT c.city, o.product_name
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

/*'Bangalore', 'Laptop'
'Bangalore', 'Smartphone'
'Chennai', 'Headphones'
'Mumbai', 'Smartwatch'
'Bangalore', 'Tablet'
*/

  /* 5: Natural Join – */
      -- 1. Find all orders placed by customers.
SELECT * 
FROM Customers c
NATURAL JOIN Orders o;

/*'1', 'John Doe', 'Bangalore', '101', 'Laptop', '2025-09-01'
'1', 'John Doe', 'Bangalore', '102', 'Smartphone', '2025-09-03'
'2', 'Alice Smith', 'Chennai', '103', 'Headphones', '2025-09-04'
'4', 'Eve Davis', 'Bangalore', '104', 'Tablet', '2025-09-05'
'3', 'Bob Johnson', 'Mumbai', '105', 'Smartwatch', '2025-09-06'
*/

-- 2. List all customers with the products they ordered using NATURAL JOIN.
SELECT c.customer_name, o.product_name
FROM Customers c
NATURAL JOIN Orders o;

/*'John Doe', 'Laptop'
'John Doe', 'Smartphone'
'Alice Smith', 'Headphones'
'Eve Davis', 'Tablet'
'Bob Johnson', 'Smartwatch'
*/


-- 3. Show customer names along with their order dates using NATURAL JOIN.
SELECT c.customer_name, o.order_date
FROM Customers c
NATURAL JOIN Orders o;

/*'John Doe', '2025-09-01'
'John Doe', '2025-09-03'
'Alice Smith', '2025-09-04'
'Eve Davis', '2025-09-05'
'Bob Johnson', '2025-09-06'
*/

-- 4. Find all customer cities and the products ordered by those customers using NATURAL JOIN.
SELECT c.city, o.product_name
FROM Customers c
NATURAL JOIN Orders o;

/*'Bangalore', 'Laptop'
'Bangalore', 'Smartphone'
'Chennai', 'Headphones'
'Bangalore', 'Tablet'
'Mumbai', 'Smartwatch'
*/
  
  -- END OF THE EXPERIMENT