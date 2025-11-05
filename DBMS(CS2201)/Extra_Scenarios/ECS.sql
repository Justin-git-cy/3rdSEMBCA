CREATE DATABASE Ecom;
USE Ecom;

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Product(
  ProdID INT PRIMARY KEY AUTO_INCREMENT,
  ProdName VARCHAR(50),
  Price DECIMAL(10,2),
  Stock INT
);

CREATE TABLE Orders(
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  CustID INT,
  ProdID INT,
  Quantity INT,
  FOREIGN KEY (CustID) REFERENCES Customer(CustID),
  FOREIGN KEY (ProdID) REFERENCES Product(ProdID)
);

INSERT INTO Customer(Name) VALUES ('Kiran'),('Sneha');
INSERT INTO Product(ProdName,Price,Stock) VALUES ('Mouse',500,10),('Keyboard',1000,15);
INSERT INTO Orders(CustID,ProdID,Quantity) VALUES (1,1,2),(2,2,1);

SELECT o.OrderID,c.Name,p.ProdName,o.Quantity FROM Orders o JOIN Customer c ON o.CustID=c.CustID JOIN Product p ON o.ProdID=p.ProdID;
SELECT p.ProdName,SUM(o.Quantity*p.Price) AS TotalSales FROM Orders o JOIN Product p ON o.ProdID=p.ProdID GROUP BY p.ProdName;

DELIMITER //
CREATE PROCEDURE AddOrUpdateOrder(IN oid INT,IN cid INT,IN pid INT,IN qty INT)
BEGIN
  IF EXISTS(SELECT * FROM Orders WHERE OrderID=oid) THEN
    UPDATE Orders SET CustID=cid,ProdID=pid,Quantity=qty WHERE OrderID=oid;
  ELSE
    INSERT INTO Orders(CustID,ProdID,Quantity) VALUES(cid,pid,qty);
    UPDATE Product SET Stock=Stock-qty WHERE ProdID=pid;
  END IF;
END //
DELIMITER ;
