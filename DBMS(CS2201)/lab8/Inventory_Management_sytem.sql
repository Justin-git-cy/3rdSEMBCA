CREATE DATABASE InventoryDB;
USE InventoryDB;

CREATE TABLE Suppliers (
  supplier_id INT PRIMARY KEY,
  supplier_name VARCHAR(100),
  contact VARCHAR(50)
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(150),
  unit_price DECIMAL(10,2)
);

CREATE TABLE Supplies (
  supply_id INT PRIMARY KEY,
  supplier_id INT,
  product_id INT,
  supply_date DATE,
  quantity INT,
  total_cost DECIMAL(12,2),
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Suppliers VALUES
(1,'ABC Traders','+91-8000000001'),
(2,'Global Supplies','+44-8000000002'),
(3,'Suministros García','+34-8000000003');

INSERT INTO Products VALUES
(301,'Bolt M6',2.50),
(302,'Nut M6',1.50),
(303,'Hex Key Set',12.00);

INSERT INTO Supplies VALUES
(9001,1,301,'2025-10-01',100,100*2.50),
(9002,2,302,'2025-10-05',200,200*1.50),
(9003,3,303,'2025-10-07',50,50*12.00);


-- Total quantity supplied per supplier
SELECT s.supplier_id, s.supplier_name, SUM(sp.quantity) AS total_quantity, SUM(sp.total_cost) AS total_cost
FROM Suppliers s
LEFT JOIN Supplies sp ON s.supplier_id = sp.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_quantity DESC;

SELECT * FROM Supplies WHERE supply_date BETWEEN '2025-10-01' AND '2025-10-31';

DELIMITER //
CREATE PROCEDURE InsertSupply(
  IN sid INT, IN suppid INT, IN pid INT, IN sdate DATE, IN qty INT, IN tcost DECIMAL(12,2)
)
BEGIN
  INSERT INTO Supplies VALUES (sid, suppid, pid, sdate, qty, tcost);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateSupplyQty(IN sid INT, IN new_qty INT, IN new_cost DECIMAL(12,2))
BEGIN
  UPDATE Supplies SET quantity = new_qty, total_cost = new_cost WHERE supply_id = sid;
END //
DELIMITER ;
