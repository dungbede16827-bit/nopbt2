create database shop;
drop database shop
use shop;

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	total_amount INT,
	note TEXT,
    user_id INT,
    status varchar(10)
);
INSERT INTO Orders (order_id, total_amount, note, user_id, status) VALUES
(1, 1000000, 'don thuong', 101, 'SS'),
(2, 2500000, 'giao gap trong ngay', 102, 'SS'),
(3, 3000000, 'don hang gap', NULL, 'SS'),
(4, 4500000, 'giao hang gap buoi toi', 103, 'SS'),
(5, 5000000, 'khach dat gap', NULL, 'SS'),
(6, 4200000, 'don lon can giao gap', 104, 'SS'),
(7, 2100000, 'don hang binh thuong', 105, 'SS'),
(8, 4800000, 'giao gap', NULL, 'SS'),
(9, 3500000, 'don gap', 106, 'SS'),
(10, 2000000, 'giao hang gap', 107, 'CANCELLED'),
(11, 4100000, 'gap gap gap', 108, 'SS'),
(12, 3900000, 'khong gap', NULL, 'SS'),
(13, 2700000, 'giao gap nhanh', 109, 'SS'),
(14, 4600000, 'don sieu gap', NULL, 'SS'),
(15, 2200000, 'don thuong', 110, 'SS'),
(16, 3300000, 'can giao gap', 111, 'SS'),
(17, 4400000, 'don gap lon', NULL, 'SS'),
(18, 2800000, 'giao hang gap', 112, 'SS'),
(19, 4900000, 'gap ngay lap tuc', NULL, 'SS'),
(20, 3100000, 'don hang', 113, 'SS'),
(21, 2600000, 'giao gap', NULL, 'SS'),
(22, 4700000, 'don hang gap', 114, 'SS'),
(23, 3600000, 'gap nhe', 115, 'SS'),
(24, 4300000, 'rat gap', NULL, 'SS'),
(25, 2400000, 'don hang gap', 116, 'SS'),
(26, 2900000, 'binh thuong', 117, 'SS'),
(27, 4100000, 'giao gap nhanh', NULL, 'SS'),
(28, 3800000, 'don gap', 118, 'SS'),
(29, 4550000, 'gap', NULL, 'SS'),
(30, 3200000, 'don hang gap', 119, 'SS');


-- đoạn code duy nhất 
SELECT order_id,note,status,total_amount,
CASE 
WHEN total_amount > 4000000 THEN 'Nguy hiểm'
ELSE 'Bình thường'
END AS danh_gia
FROM Orders
WHERE total_amount BETWEEN 2000000 AND 5000000
    AND status <> 'CANCELLED'
    AND (note LIKE '%gap%' OR user_id IS NULL)
ORDER BY total_amount DESC
LIMIT 20 -- OFFSET 40;