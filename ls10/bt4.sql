
CREATE DATABASE PharmacyDB;
USE PharmacyDB;

CREATE TABLE Pharmacy_Inventory (
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Drug_Name VARCHAR(255) NOT NULL,
    Batch_Number VARCHAR(50) NOT NULL,
    Expiry_Date DATE NOT NULL,
    Quantity INT NOT NULL
);

INSERT INTO Pharmacy_Inventory (Drug_Name, Batch_Number, Expiry_Date, Quantity) VALUES
('Paracetamol', 'B001', '2026-12-31', 100),
('Paracetamol', 'B002', '2025-10-01', 150),
('Aspirin', 'B003', '2026-05-20', 200),
('Amoxicillin', 'B004', '2025-08-15', 120),
('Vitamin C', 'B005', '2027-01-01', 300),
('Paracetamol Extra', 'B006', '2025-09-10', 80);

CREATE INDEX idx_drug_name ON Pharmacy_Inventory(Drug_Name);
CREATE INDEX idx_expiry_date ON Pharmacy_Inventory(Expiry_Date);

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
  AND Expiry_Date = '2025-10-01';


CREATE INDEX idx_drug_expiry
ON Pharmacy_Inventory(Drug_Name, Expiry_Date);


EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
  AND Expiry_Date = '2025-10-01';

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE '%para%';

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE 'Para%';

ALTER TABLE Pharmacy_Inventory
ADD FULLTEXT(Drug_Name);

SELECT *
FROM Pharmacy_Inventory
WHERE MATCH(Drug_Name) AGAINST('para');


CREATE INDEX idx_covering
ON Pharmacy_Inventory(Drug_Name, Expiry_Date, Quantity);

SELECT Drug_Name, Expiry_Date, Quantity
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
ORDER BY Expiry_Date ASC;