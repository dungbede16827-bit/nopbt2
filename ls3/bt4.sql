-- Cách 1: Xóa đơn hàng bị hủy
DELETE FROM ORDERS
WHERE Status = 'Canceled';
-- Cách 2: Soft Delete 
-- Thêm cột
ALTER TABLE ORDERS
ADD IsDeleted BIT DEFAULT 0;

-- Đánh dấu đơn bị hủy
UPDATE ORDERS
SET IsDeleted = 1
WHERE Status = 'Canceled';


-- Truy vấn cho người dùng 
SELECT *
FROM ORDERS
WHERE IsDeleted = 0;

-- Truy vấn cho kế toán 
SELECT *
FROM ORDERS
WHERE Status = 'Canceled';