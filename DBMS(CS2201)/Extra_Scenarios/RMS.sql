CREATE DATABASE rst;
USE rst;

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

CREATE TABLE MenuItem(
  ItemID INT PRIMARY KEY AUTO_INCREMENT,
  ItemName VARCHAR(100),
  Price DECIMAL(10,2)
);

CREATE TABLE OrderHead(
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  CustID INT,
  OrderDate DATE,
  FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE OrderItem(
  OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT,
  ItemID INT,
  Quantity INT,
  FOREIGN KEY (OrderID) REFERENCES OrderHead(OrderID),
  FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID)
);

INSERT INTO Customer(Name) VALUES ('Ramesh'),('Anu');
INSERT INTO MenuItem(ItemName,Price) VALUES ('Pasta',250.00),('Pizza',400.00);
INSERT INTO OrderHead(CustID,OrderDate) VALUES (1,'2025-11-04'),(2,'2025-11-04');
INSERT INTO OrderItem(OrderID,ItemID,Quantity) VALUES (1,1,2),(1,2,1),(2,2,3);

SELECT oh.OrderID,c.Name,mi.ItemName,oi.Quantity, (oi.Quantity*mi.Price) AS LineTotal FROM OrderItem oi JOIN OrderHead oh ON oi.OrderID=oh.OrderID JOIN MenuItem mi ON oi.ItemID=mi.ItemID JOIN Customer c ON oh.CustID=c.CustID;
SELECT OrderDate,SUM(oi.Quantity*mi.Price) AS TotalRevenue FROM OrderItem oi JOIN OrderHead oh ON oi.OrderID=oh.OrderID JOIN MenuItem mi ON oi.ItemID=mi.ItemID GROUP BY OrderDate;

DELIMITER //
CREATE PROCEDURE AddOrUpdateOrder(IN oid INT,IN cid INT,IN odate DATE,IN itemid INT,IN qty INT)
BEGIN
  IF oid IS NOT NULL AND EXISTS(SELECT * FROM OrderHead WHERE OrderID=oid) THEN
    UPDATE OrderHead SET CustID=cid,OrderDate=odate WHERE OrderID=oid;
    IF EXISTS(SELECT * FROM OrderItem WHERE OrderID=oid AND ItemID=itemid) THEN
      UPDATE OrderItem SET Quantity=qty WHERE OrderID=oid AND ItemID=itemid;
    ELSE
      INSERT INTO OrderItem(OrderID,ItemID,Quantity) VALUES(oid,itemid,qty);
    END IF;
  ELSE
    INSERT INTO OrderHead(CustID,OrderDate) VALUES(cid,odate);
    SET @newid = LAST_INSERT_ID();
    INSERT INTO OrderItem(OrderID,ItemID,Quantity) VALUES(@newid,itemid,qty);
  END IF;
END //
DELIMITER ;
