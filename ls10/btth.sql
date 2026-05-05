create database ER;
use ER;


create table Patients (
Patient_ID varchar(5) primary key,
Full_Name varchar(100) not null,
Admission_Time datetime DEFAULT CURRENT_TIMESTAMP

);

create table Vitals_Logs  (
Log_ID int primary key auto_increment,
Patient_ID varchar(5) not null,
Heart_Rate int check (Heart_Rate > 0) ,
Blood_Pressure varchar(10),
Record_Time datetime,
foreign key(Patient_ID) references Patients(Patient_ID)
);
INSERT INTO Patients (Patient_ID, Full_Name) VALUES
('BN001', 'Nguyen Van A'),
('BN002', 'Tran Thi B'),
('BN003', 'Le Van C'),
('BN004', 'Pham Thi D'),
('BN005', 'Hoang Van E');
INSERT INTO Vitals_Logs (Patient_ID, Heart_Rate, Blood_Pressure, Record_Time) VALUES

('BN001', 80, '120/80', '2026-05-05 08:00:00'),
('BN001', 130, '140/90', '2026-05-05 09:00:00'),


('BN002', 75, '118/79', '2026-05-05 08:30:00'),


('BN003', 45, '110/70', '2026-05-05 09:15:00'),



('BN005', 90, '125/85', '2026-05-05 07:50:00'),
('BN005', 60, '120/80', '2026-05-05 09:10:00');

CREATE INDEX idx_patient_time 
ON Vitals_Logs(Patient_ID, Record_Time);

CREATE VIEW ER_Dashboard_View AS
SELECT p.Patient_ID,p.Full_Name,p.Admission_Time,
    ifnull(v.Heart_Rate, 'Pending') AS Heart_Rate,v.Blood_Pressure,v.Record_Time,
    CASE 
        WHEN v.Heart_Rate > 120 OR v.Heart_Rate < 50 THEN 'CRITICAL'
        WHEN v.Heart_Rate IS NULL THEN 'Pending'
        ELSE 'STABLE'
    END AS Urgency_Level
FROM Patients p
LEFT JOIN Vitals_Logs v 
    ON p.Patient_ID = v.Patient_ID
    AND v.Record_Time = (
        SELECT MAX(v2.Record_Time)
        FROM Vitals_Logs v2
        WHERE v2.Patient_ID = p.Patient_ID
    );
    
    
    
    