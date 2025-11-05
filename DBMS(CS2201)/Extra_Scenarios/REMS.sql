CREATE DATABASE rlt;
USE rlt;

CREATE TABLE Agent(
  AgentID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Contact VARCHAR(50)
);

CREATE TABLE Property(
  PropertyID INT PRIMARY KEY AUTO_INCREMENT,
  Address VARCHAR(200),
  Price DECIMAL(12,2),
  AgentID INT,
  FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

CREATE TABLE Sale(
  SaleID INT PRIMARY KEY AUTO_INCREMENT,
  PropertyID INT,
  SaleDate DATE,
  SalePrice DECIMAL(12,2),
  FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);

INSERT INTO Agent(Name,Contact) VALUES ('Amit Patel','9999999999'),('Sonia Rao','8888888888');
INSERT INTO Property(Address,Price,AgentID) VALUES ('12 Park Lane',5000000,1),('45 Lake View',7500000,2);
INSERT INTO Sale(PropertyID,SaleDate,SalePrice) VALUES (1,'2025-10-20',5100000),(2,'2025-10-25',7400000);

SELECT p.Address,a.Name,s.SalePrice,s.SaleDate FROM Sale s JOIN Property p ON s.PropertyID=p.PropertyID JOIN Agent a ON p.AgentID=a.AgentID;
SELECT a.Name,SUM(s.SalePrice) AS TotalSales FROM Sale s JOIN Property p ON s.PropertyID=p.PropertyID JOIN Agent a ON p.AgentID=a.AgentID GROUP BY a.Name;

DELIMITER //
CREATE PROCEDURE AddOrUpdateSale(IN sid INT,IN pid INT,IN sdate DATE,IN sprice DECIMAL(12,2))
BEGIN
  IF EXISTS(SELECT * FROM Sale WHERE SaleID=sid) THEN
    UPDATE Sale SET PropertyID=pid,SaleDate=sdate,SalePrice=sprice WHERE SaleID=sid;
  ELSE
    INSERT INTO Sale(PropertyID,SaleDate,SalePrice) VALUES(pid,sdate,sprice);
  END IF;
END //
DELIMITER ;
