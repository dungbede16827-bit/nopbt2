th1 tăng giá 
Ví dụ:
Giá cũ = 10000
Giá mới = 15000
=> trạng thái:
TĂNG GIÁ
=> chênh lệch:
15000 - 10000 = 5000
Trường hợp 2 — Giảm giá
Ví dụ:
Giá cũ = 15000
Giá mới = 12000
=> trạng thái:
GIẢM GIÁ
=> chênh lệch:
15000 - 12000 = 3000
th3 không đổi chỉ đổi tồn kho không được đổi giá
th4 giá bằng 0
phải chặn và báo lỗi
Ta cần:
kiểm tra giá âm trước khi cập nhật
ghi log sau khi cập nhật thành công
=> nên dùng:
Trigger	Mục đích
BEFORE UPDATE	chặn giá âm
AFTER UPDATE	ghi lịch sử log

CREATE DATABASE TEST;
USE TEST;
CREATE TABLE Medicines (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO Medicines(medicine_name, price, stock)
VALUES
('Paracetamol', 10000, 50),
('Vitamin C', 20000, 30),
('Amoxicillin', 15000, 40);

CREATE TABLE Price_Changes_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    status VARCHAR(20),
    difference_amount DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER CheckMedicinePrice
BEFORE UPDATE ON Medicines
FOR EACH ROW
BEGIN

    IF NEW.price <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Giá thuốc mới không hợp lệ';
    END IF;

END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER LogMedicinePriceChange
AFTER UPDATE ON Medicines
FOR EACH ROW
BEGIN

    -- Chỉ xử lý khi giá thay đổi
    IF OLD.price <> NEW.price THEN

        -- Tăng giá
        IF NEW.price > OLD.price THEN

            INSERT INTO Price_Changes_Log(
                medicine_id,
                old_price,
                new_price,
                status,
                difference_amount
            )
            VALUES(
                OLD.medicine_id,
                OLD.price,
                NEW.price,
                'TĂNG GIÁ',
                NEW.price - OLD.price
            );

        -- Giảm giá
        ELSEIF NEW.price < OLD.price THEN
            INSERT INTO Price_Changes_Log(
                medicine_id,
                old_price,
                new_price,
                status,
                difference_amount
            )
            VALUES(
                OLD.medicine_id,
                OLD.price,
                NEW.price,
                'GIẢM GIÁ',
                OLD.price - NEW.price
            );
        END IF;
    END IF;
END //
DELIMITER ;

UPDATE Medicines
SET price = 15000
WHERE medicine_id = 1;

UPDATE Medicines
SET price = 12000
WHERE medicine_id = 1;

UPDATE Medicines
SET stock = 200
WHERE medicine_id = 1;
UPDATE Medicines
SET price = -5000
WHERE medicine_id = 1;
SELECT * FROM Price_Changes_Log;