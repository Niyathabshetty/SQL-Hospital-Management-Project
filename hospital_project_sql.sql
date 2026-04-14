CREATE DATABASE hospital_db;
USE hospital_db;

SHOW DATABASES;

CREATE TABLE Patients(
patient_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
gender VARCHAR(10)
);

CREATE TABLE Doctors(
doctor_id INT PRIMARY KEY,
name VARCHAR(50),
specialization VARCHAR(50)
);

CREATE TABLE Appointments(
appointment_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
date DATE,
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Treatments(
treatment_id INT PRIMARY KEY,
patient_id INT,
diagnosis VARCHAR(100),
cost DECIMAL(10,2),
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
SHOW TABLES;

INSERT INTO Patients VALUES
(1,'Niyatha',22,'Female'),
(2,'Shraddha',25,'Female'),
(3,'Ram',35,'Male'),
(4,'Shravya',40,'Female'),
(5,'Pratheek',28,'Male');

INSERT INTO Doctors VALUES
(101,'Dr.Sharma','Cardio'),
(102,'Dr.Mehek','Neuro'),
(103,'Dr.Adam','Ortho');

INSERT INTO Appointments VALUES
(1,1,101,'2024-01-10'),
(2,2,102,'2024-01-15'),
(3,1,101,'2024-02-10'),
(4,3,103,'2024-02-18'),
(5,4,101,'2024-03-05'),
(6,5,102,'2024-03-20'),
(7,2,101,'2024-03-25');

INSERT INTO Treatments VALUES
(1,1,'Heart Disease',5000),
(2,2,'Migraine',2000),
(3,3,'Fracture',3000),
(4,4,'Heart Disease',4500),
(5,5,'Migraine',1800),
(6,1,'Heart Disease',5200);

SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;
SELECT * FROM Treatments;

# Most Consulted Doctors
SELECT d.name,COUNT(a.appointment_id) AS total_consultations
FROM Doctors d
JOIN Appointments a ON d.doctor_id=a.doctor_id
GROUP BY d.name
ORDER BY total_consultations DESC;

#Total Revenue per Month
SELECT MONTH(a.date) AS month,SUM(t.cost) AS total_revenue
FROM Appointments a
JOIN Treatments t ON a.patient_id=t.patient_id
GROUP BY MONTH(a.date)
ORDER BY month;

#Most Common Diseases
SELECT diagnosis,COUNT(*) AS frequency
FROM Treatments
GROUP BY diagnosis
ORDER BY frequency DESC;

#Track Patient Visit Frequency
SELECT p.name,COUNT(a.appointment_id) AS visit_count
FROM Patients p
JOIN Appointments a ON p.patient_id=a.patient_id
GROUP BY p.name
ORDER BY visit_count DESC;

#Analyze Doctor Performance
SELECT d.name,COUNT(DISTINCT a.patient_id) AS patients_handled
FROM Doctors d
JOIN Appointments a ON d.doctor_id=a.doctor_id
GROUP BY d.name
ORDER BY patients_handled DESC;












