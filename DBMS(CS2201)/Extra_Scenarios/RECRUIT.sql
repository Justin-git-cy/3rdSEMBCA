CREATE DATABASE rec;
USE rec;

CREATE TABLE Applicant(
  ApplicantID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(200),
  Email VARCHAR(200)
);

CREATE TABLE Job(
  JobID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(200),
  Department VARCHAR(100)
);

CREATE TABLE Application(
  AppID INT PRIMARY KEY AUTO_INCREMENT,
  ApplicantID INT,
  JobID INT,
  ApplyDate DATE,
  Status VARCHAR(50),
  FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
  FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

INSERT INTO Applicant(Name,Email) VALUES ('Karthik','karthik@example.com'),('Lata','lata@example.com');
INSERT INTO Job(Title,Department) VALUES ('Software Engineer','IT'),('HR Executive','HR');
INSERT INTO Application(ApplicantID,JobID,ApplyDate,Status) VALUES (1,1,'2025-10-30','Received'),(2,2,'2025-11-02','Shortlisted');

SELECT j.Title,COUNT(a.AppID) AS TotalApplications FROM Application a JOIN Job j ON a.JobID=j.JobID GROUP BY j.Title;
SELECT ap.Name,j.Title,a.ApplyDate,a.Status FROM Application a JOIN Applicant ap ON a.ApplicantID=ap.ApplicantID JOIN Job j ON a.JobID=j.JobID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateApplication(IN aid INT,IN appid INT,IN jid INT,IN adate DATE,IN st VARCHAR(50))
BEGIN
  IF EXISTS(SELECT 1 FROM Application WHERE AppID=aid) THEN
    UPDATE Application SET ApplicantID=appid,JobID=jid,ApplyDate=adate,Status=st WHERE AppID=aid;
  ELSE
    INSERT INTO Application(ApplicantID,JobID,ApplyDate,Status) VALUES(appid,jid,adate,st);
  END IF;
END //
DELIMITER ;
