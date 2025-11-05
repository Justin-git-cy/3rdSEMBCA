CREATE DATABASE Pha;
USE Pha;
CREATE TABLE Medicine(
  MedID INT PRIMARY KEY AUTO_INCREMENT,
  MedName VARCHAR(50),
  Price DECIMAL(10,2),
  Stock INT
);

CREATE TABLE Supplier(
  SupID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Sale(
  SaleID INT PRIMARY KEY AUTO_INCREMENT,
  MedID INT,
  Quantity INT,
  FOREIGN KEY (MedID) REFERENCES Medicine(MedID)
);

INSERT INTO Medicine(MedName,Price,Stock) VALUES ('Paracetamol',20,100),('Amoxicillin',50,50);
INSERT INTO Supplier(Name) VALUES ('ABC Pharma'),('XYZ Med');
INSERT INTO Sale(MedID,Quantity) VALUES (1,5),(2,3);

SELECT m.MedName,SUM(s.Quantity*m.Price) AS TotalSales FROM Sale s JOIN Medicine m ON s.MedID=m.MedID GROUP BY m.MedName;

DELIMITER //
CREATE PROCEDURE AddOrUpdateSale(IN sid INT,IN mid INT,IN qty INT)
BEGIN
  IF EXISTS(SELECT * FROM Sale WHERE SaleID=sid) THEN
    UPDATE Sale SET MedID=mid,Quantity=qty WHERE SaleID=sid;
  ELSE
    INSERT INTO Sale(MedID,Quantity) VALUES(mid,qty);
    UPDATE Medicine SET Stock=Stock-qty WHERE MedID=mid;
  END IF;
END //
DELIMITER ;

