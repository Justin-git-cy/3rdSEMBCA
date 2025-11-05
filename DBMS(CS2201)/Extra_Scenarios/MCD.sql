CREATE DATABASE mfg;
USE mfg;

CREATE TABLE Product(
  ProdID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Unit VARCHAR(50)
);

CREATE TABLE Worker(
  WorkerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Role VARCHAR(100)
);

CREATE TABLE Production(
  ProdRecID INT PRIMARY KEY AUTO_INCREMENT,
  ProdID INT,
  WorkerID INT,
  ProdDate DATE,
  Quantity INT,
  FOREIGN KEY (ProdID) REFERENCES Product(ProdID),
  FOREIGN KEY (WorkerID) REFERENCES Worker(WorkerID)
);

INSERT INTO Product(Name,Unit) VALUES ('Bolt','pcs'),('Nut','pcs');
INSERT INTO Worker(Name,Role) VALUES ('Raju','Assembler'),('Sonia','Operator');
INSERT INTO Production(ProdID,WorkerID,ProdDate,Quantity) VALUES (1,1,'2025-11-01',500),(2,2,'2025-11-01',300);

SELECT p.Name,w.Name,pr.ProdDate,pr.Quantity FROM Production pr JOIN Product p ON pr.ProdID=p.ProdID JOIN Worker w ON pr.WorkerID=w.WorkerID;
SELECT p.Name,SUM(pr.Quantity) AS TotalProduced FROM Production pr JOIN Product p ON pr.ProdID=p.ProdID GROUP BY p.ProdID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateProduction(IN id INT,IN pid INT,IN wid INT,IN pdate DATE,IN qty INT)
BEGIN
  IF EXISTS(SELECT 1 FROM Production WHERE ProdRecID=id) THEN
    UPDATE Production SET ProdID=pid,WorkerID=wid,ProdDate=pdate,Quantity=qty WHERE ProdRecID=id;
  ELSE
    INSERT INTO Production(ProdID,WorkerID,ProdDate,Quantity) VALUES(pid,wid,pdate,qty);
  END IF;
END //
DELIMITER ;
