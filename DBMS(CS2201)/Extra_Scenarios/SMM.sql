CREATE DATABASE mll;
USE mll;

CREATE TABLE Shop(
  ShopID INT PRIMARY KEY AUTO_INCREMENT,
  ShopName VARCHAR(200),
  Floor VARCHAR(50)
);

CREATE TABLE Employee(
  EmpID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  ShopID INT,
  FOREIGN KEY (ShopID) REFERENCES Shop(ShopID)
);

CREATE TABLE Sale(
  SaleID INT PRIMARY KEY AUTO_INCREMENT,
  ShopID INT,
  EmpID INT,
  SaleDate DATE,
  Amount DECIMAL(12,2),
  FOREIGN KEY (ShopID) REFERENCES Shop(ShopID),
  FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

INSERT INTO Shop(ShopName,Floor) VALUES ('Gadget Zone','Ground'),('Fashion Hub','First');
INSERT INTO Employee(Name,ShopID) VALUES ('Tanu',1),('Rajat',2);
INSERT INTO Sale(ShopID,EmpID,SaleDate,Amount) VALUES (1,1,'2025-11-04',15000.00),(2,2,'2025-11-04',22000.00);

SELECT s.ShopName, SUM(sa.Amount) AS TotalSales FROM Sale sa JOIN Shop s ON sa.ShopID=s.ShopID GROUP BY s.ShopName;
SELECT e.Name,s.ShopName,sa.Amount,sa.SaleDate FROM Sale sa JOIN Employee e ON sa.EmpID=e.EmpID JOIN Shop s ON sa.ShopID=s.ShopID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateSale(IN sid INT,IN shopid INT,IN empid INT,IN sdate DATE,IN amt DECIMAL(12,2))
BEGIN
  IF EXISTS(SELECT * FROM Sale WHERE SaleID=sid) THEN
    UPDATE Sale SET ShopID=shopid,EmpID=empid,SaleDate=sdate,Amount=amt WHERE SaleID=sid;
  ELSE
    INSERT INTO Sale(ShopID,EmpID,SaleDate,Amount) VALUES(shopid,empid,sdate,amt);
  END IF;
END //
DELIMITER ;
