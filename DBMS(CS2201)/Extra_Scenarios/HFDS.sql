CREATE DATABASE hfd;
USE hfd;

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Address VARCHAR(200)
);

CREATE TABLE FoodItem(
  ItemID INT PRIMARY KEY AUTO_INCREMENT,
  ItemName VARCHAR(200),
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
  FOREIGN KEY (ItemID) REFERENCES FoodItem(ItemID)
);

INSERT INTO Customer(Name,Address) VALUES ('Vikram','MG Road'),('Neha','Brigade Rd');
INSERT INTO FoodItem(ItemName,Price) VALUES ('Burger',150.00),('Sushi',300.00);
INSERT INTO OrderHead(CustID,OrderDate) VALUES (1,'2025-11-04'),(2,'2025-11-04');
INSERT INTO OrderItem(OrderID,ItemID,Quantity) VALUES (1,1,2),(1,2,1),(2,2,2);

SELECT oh.OrderDate,SUM(oi.Quantity*fi.Price) AS DailyRevenue FROM OrderItem oi JOIN OrderHead oh ON oi.OrderID=oh.OrderID JOIN FoodItem fi ON oi.ItemID=fi.ItemID GROUP BY oh.OrderDate;
SELECT oh.OrderID,c.Name,fi.ItemName,oi.Quantity,(oi.Quantity*fi.Price) AS LineTotal FROM OrderItem oi JOIN OrderHead oh ON oi.OrderID=oh.OrderID JOIN FoodItem fi ON oi.ItemID=fi.ItemID JOIN Customer c ON oh.CustID=c.CustID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateFoodOrder(IN oid INT,IN cid INT,IN odate DATE,IN itemid INT,IN qty INT)
BEGIN
  IF oid IS NOT NULL AND EXISTS(SELECT 1 FROM OrderHead WHERE OrderID=oid) THEN
    UPDATE OrderHead SET CustID=cid,OrderDate=odate WHERE OrderID=oid;
    IF EXISTS(SELECT 1 FROM OrderItem WHERE OrderID=oid AND ItemID=itemid) THEN
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
