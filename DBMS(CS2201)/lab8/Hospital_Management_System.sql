CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Patients (
  patient_id INT PRIMARY KEY,
  patient_name VARCHAR(100),
  gender VARCHAR(10),
  dob DATE,
  city VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE Doctors (
  doctor_id INT PRIMARY KEY,
  doctor_name VARCHAR(100),
  specialization VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE Appointments (
  appointment_id INT PRIMARY KEY,
  patient_id INT,
  doctor_id INT,
  appointment_date DATETIME,
  reason VARCHAR(255),
  status VARCHAR(20), -- Scheduled, Completed, Cancelled
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
INSERT INTO Patients VALUES
(1,'Aisha Patel','Female','1990-03-12','Bangalore','+91-9876500001'),
(2,'Diego Silva','Male','1985-07-30','Málaga','+34-600000002'),
(3,'Sara Tonali','Female','1998-11-05','Osaka','+81-90-0000-0003'),
(4,'Luca Rossi','Male','1978-09-21','Rome','+39-333-0000004'),
(5,'Min-Joon Kim','Male','1992-01-17','Seoul','+82-10-0000-0005');

INSERT INTO Doctors VALUES
(101,'Dr. Elena Martínez','Cardiology','+34-9444000001'),
(102,'Dr. Priya Sharma','Dermatology','+91-9444000002'),
(103,'Dr. Tomasz Nowak','Orthopedics','+48-9444000003'),
(104,'Dr. Chen Wei','Neurology','+86-9444000004');

INSERT INTO Appointments VALUES
(1001,1,101,'2025-10-20 10:30:00','Chest pain','Scheduled'),
(1002,2,103,'2025-10-21 14:00:00','Knee pain','Scheduled'),
(1003,3,102,'2025-09-15 11:00:00','Skin rash','Completed'),
(1004,4,104,'2025-10-05 09:00:00','Headache','Completed'),
(1005,5,101,'2025-10-22 16:30:00','Follow-up','Scheduled');


-- Total patients per doctor
SELECT d.doctor_id, d.doctor_name, COUNT(a.patient_id) AS total_patients
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY total_patients DESC;

-- Upcoming appointments (next 7 days)
SELECT a.appointment_id, p.patient_name, d.doctor_name, a.appointment_date, a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 7 DAY)
ORDER BY a.appointment_date;

-- Patients older than 40
SELECT patient_name, dob, TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM Patients
WHERE TIMESTAMPDIFF(YEAR, dob, CURDATE()) > 40;

-- Procedure to insert appointment
DELIMITER //
CREATE PROCEDURE InsertAppointment(
  IN apid INT, IN pid INT, IN did INT, IN apdt DATETIME, IN reas VARCHAR(255), IN st VARCHAR(20)
)
BEGIN
  INSERT INTO Appointments VALUES (apid, pid, did, apdt, reas, st);
END //
DELIMITER ;

-- Procedure to update appointment status
DELIMITER //
CREATE PROCEDURE UpdateAppointmentStatus(IN apid INT, IN new_status VARCHAR(20))
BEGIN
  UPDATE Appointments SET status = new_status WHERE appointment_id = apid;
END //
DELIMITER ;
