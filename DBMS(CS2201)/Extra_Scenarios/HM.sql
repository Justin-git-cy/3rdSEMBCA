CREATE DATABASE Hos;
USE Hos;

CREATE TABLE Doctor (
  DoctorID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50),
  Specialization VARCHAR(50)
);

CREATE TABLE Patient (
  PatientID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50),
  Age INT,
  Gender CHAR(1)
);

CREATE TABLE Appointment (
  AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
  DoctorID INT,
  PatientID INT,
  Date DATE,
  FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
  FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

INSERT INTO Doctor (Name, Specialization)
VALUES ('Dr. Mehta', 'Cardiology'), ('Dr. Khan', 'Orthopedic');

INSERT INTO Patient (Name, Age, Gender)
VALUES ('Amit Sharma', 45, 'M'), ('Neha Verma', 29, 'F');

INSERT INTO Appointment (DoctorID, PatientID, Date)
VALUES (1,1,'2025-11-05'), (2,2,'2025-11-06');

SELECT DoctorID, COUNT(PatientID) AS TotalPatients
FROM Appointment GROUP BY DoctorID;

SELECT * FROM Appointment WHERE Date='2025-11-05';

DELIMITER //
CREATE PROCEDURE AddOrUpdateAppointment(
  IN aid INT,
  IN did INT,
  IN pid INT,
  IN adate DATE
)
BEGIN
  IF EXISTS (SELECT * FROM Appointment WHERE AppointmentID = aid) THEN
    UPDATE Appointment SET DoctorID=did, PatientID=pid, Date=adate WHERE AppointmentID=aid;
  ELSE
    INSERT INTO Appointment(DoctorID,PatientID,Date) VALUES(did,pid,adate);
  END IF;
END //
DELIMITER ;