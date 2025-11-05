CREATE DATABASE Inv;
USE Inv;

CREATE TABLE Product(
  ProdID INT PRIMARY KEY AUTO_INCREMENT,
  ProdName VARCHAR(50),
  Quantity INT
);

CREATE TABLE Supplier(
  SupID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Orders(
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  ProdID INT,
  SupID INT,
  Quantity INT,
  FOREIGN KEY (ProdID) REFERENCES Product(ProdID),
  FOREIGN KEY (SupID) REFERENCES Supplier(SupID)
);

INSERT INTO Product(ProdName,Quantity) VALUES ('Pen',100),('Book',200);
INSERT INTO Supplier(Name) VALUES ('StationeryCo'),('BookHouse');
INSERT INTO Orders(ProdID,SupID,Quantity) VALUES (1,1,50),(2,2,100);

SELECT s.Name,o.Quantity,p.ProdName FROM Orders o JOIN Supplier s ON o.SupID=s.SupID JOIN Product p ON o.ProdID=p.ProdID;
SELECT p.ProdName,SUM(o.Quantity) AS TotalOrdered FROM Orders o JOIN Product p ON o.ProdID=p.ProdID GROUP BY p.ProdName;

DELIMITER //
CREATE PROCEDURE AddOrUpdateOrder(IN oid INT,IN pid INT,IN sid INT,IN qty INT)
BEGIN
  IF EXISTS(SELECT * FROM Orders WHERE OrderID=oid) THEN
    UPDATE Orders SET ProdID=pid,SupID=sid,Quantity=qty WHERE OrderID=oid;
  ELSE
    INSERT INTO Orders(ProdID,SupID,Quantity) VALUES(pid,sid,qty);
    UPDATE Product SET Quantity=Quantity+qty WHERE ProdID=pid;
  END IF;
END //
DELIMITER ;
