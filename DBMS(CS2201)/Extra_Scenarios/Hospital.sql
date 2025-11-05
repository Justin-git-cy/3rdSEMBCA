CREATE DATABASE Hospital;
Use Hospital;

CREATE TABLE Doctor (
  doctor_id INT PRIMARY KEY,
  doctor_name VARCHAR(50)
);

CREATE TABLE Patient (
  patient_id INT PRIMARY KEY,
  patient_name VARCHAR(50),
  doctor_id INT,
  bill_amount DECIMAL(8,2),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

INSERT INTO Doctor VALUES (1,'Dr. Smith'),(2,'Dr. Adams'),(3,'Dr. Brown');
INSERT INTO Patient VALUES (1,'Tom',1,2000.00),(2,'Jerry',2,3500.00),(3,'Nina',1,1800.00);

 SELECT p.patient_name, d.doctor_name
   FROM Patient p
   INNER JOIN Doctor d ON p.doctor_id = d.doctor_id;

 SELECT d.doctor_name, p.patient_name
   FROM Doctor d
   RIGHT OUTER JOIN Patient p ON d.doctor_id = p.doctor_id;

 SELECT d.doctor_name, COUNT(p.patient_id) AS total_patients
   FROM Patient p
   INNER JOIN Doctor d ON p.doctor_id = d.doctor_id
   GROUP BY d.doctor_name;

 SELECT SUM(bill_amount) AS total_bill_collected FROM Patient;

 SELECT AVG(bill_amount) AS avg_bill_per_patient FROM Patient;

