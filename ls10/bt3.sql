
CREATE DATABASE HospitalDB;
USE HospitalDB;


CREATE TABLE Departments (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100)
);


CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Departments(Dept_ID)
);

CREATE TABLE Invoices (
    Invoice_ID INT PRIMARY KEY,
    Patient_ID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);

INSERT INTO Departments VALUES 
(1, 'Noi'), 
(2, 'Ngoai');

INSERT INTO Patients VALUES 
(1, 1),
(2, 1),
(3, 2);

INSERT INTO Invoices VALUES 
(101, 1, 500.00), 
(102, 2, 300.00), 
(103, 3, 1000.00);

CREATE VIEW Department_Revenue_View AS
SELECT d.Dept_Name,COUNT(DISTINCT p.Patient_ID) AS Total_Patients,COALESCE(SUM(i.Amount), 0) AS Total_Revenue
FROM Departments d
LEFT JOIN Patients p ON d.Dept_ID = p.Dept_ID
LEFT JOIN Invoices i ON p.Patient_ID = i.Patient_ID
GROUP BY d.Dept_ID, d.Dept_Name;