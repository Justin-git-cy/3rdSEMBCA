CREATE DATABASE ins;
USE ins;

CREATE TABLE Customer(
  CustID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Contact VARCHAR(50)
);

CREATE TABLE Policy(
  PolicyID INT PRIMARY KEY AUTO_INCREMENT,
  PolicyNumber VARCHAR(50),
  CustID INT,
  StartDate DATE,
  EndDate DATE,
  FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE Claim(
  ClaimID INT PRIMARY KEY AUTO_INCREMENT,
  PolicyID INT,
  ClaimDate DATE,
  Amount DECIMAL(12,2),
  Status VARCHAR(50),
  FOREIGN KEY (PolicyID) REFERENCES Policy(PolicyID)
);

INSERT INTO Customer(Name,Contact) VALUES ('Ramesh','9999000011'),('Geeta','8888000022');
INSERT INTO Policy(PolicyNumber,CustID,StartDate,EndDate) VALUES ('POL1001',1,'2025-01-01','2026-01-01'),('POL1002',2,'2025-06-01','2026-06-01');
INSERT INTO Claim(PolicyID,ClaimDate,Amount,Status) VALUES (1,'2025-10-15',50000,'Pending'),(1,'2025-11-01',15000,'Settled'),(2,'2025-10-20',20000,'Pending');

SELECT p.PolicyNumber,COUNT(c.ClaimID) AS TotalClaims FROM Claim c JOIN Policy p ON c.PolicyID=p.PolicyID GROUP BY p.PolicyNumber;
SELECT * FROM Claim WHERE ClaimDate BETWEEN DATE_SUB(CURDATE(),INTERVAL 30 DAY) AND CURDATE();

DELIMITER //
CREATE PROCEDURE AddOrUpdateClaim(IN cid INT,IN pid INT,IN cdate DATE,IN amt DECIMAL(12,2),IN st VARCHAR(50))
BEGIN
  IF EXISTS(SELECT 1 FROM Claim WHERE ClaimID=cid) THEN
    UPDATE Claim SET PolicyID=pid,ClaimDate=cdate,Amount=amt,Status=st WHERE ClaimID=cid;
  ELSE
    INSERT INTO Claim(PolicyID,ClaimDate,Amount,Status) VALUES(pid,cdate,amt,st);
  END IF;
END //
DELIMITER ;
