CREATE DATABASE dnm;
USE dnm;

CREATE TABLE Donor(
  DonorID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Email VARCHAR(100)
);

CREATE TABLE Campaign(
  CampaignID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(200),
  StartDate DATE,
  EndDate DATE
);

CREATE TABLE Donation(
  DonationID INT PRIMARY KEY AUTO_INCREMENT,
  DonorID INT,
  CampaignID INT,
  DonateDate DATE,
  Amount DECIMAL(12,2),
  FOREIGN KEY (DonorID) REFERENCES Donor(DonorID),
  FOREIGN KEY (CampaignID) REFERENCES Campaign(CampaignID)
);

INSERT INTO Donor(Name,Email) VALUES ('Mohan','mohan@example.com'),('Laila','laila@example.com');
INSERT INTO Campaign(Title,StartDate,EndDate) VALUES ('Relief Fund','2025-09-01','2025-12-31');
INSERT INTO Donation(DonorID,CampaignID,DonateDate,Amount) VALUES (1,1,'2025-10-10',5000.00),(2,1,'2025-11-02',7500.00);

SELECT c.Title,dn.Name,don.Amount,don.DonateDate FROM Donation don JOIN Campaign c ON don.CampaignID=c.CampaignID JOIN Donor dn ON don.DonorID=dn.DonorID;
SELECT c.Title,SUM(don.Amount) AS TotalDonations FROM Donation don JOIN Campaign c ON don.CampaignID=c.CampaignID GROUP BY c.CampaignID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateDonation(IN did INT,IN donorid INT,IN campid INT,IN ddate DATE,IN amt DECIMAL(12,2))
BEGIN
  IF EXISTS(SELECT 1 FROM Donation WHERE DonationID=did) THEN
    UPDATE Donation SET DonorID=donorid,CampaignID=campid,DonateDate=ddate,Amount=amt WHERE DonationID=did;
  ELSE
    INSERT INTO Donation(DonorID,CampaignID,DonateDate,Amount) VALUES(donorid,campid-ddate,ddate,amt);
  END IF;
END //
DELIMITER ;
