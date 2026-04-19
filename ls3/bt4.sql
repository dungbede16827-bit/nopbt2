-- Cách 1: Xóa đơn hàng bị hủy
DELETE FROM ORDERS
WHERE Status = 'Canceled';
-- Cách 2: Soft Delete (chọn cách này)
-- Thêm cột
ALTER TABLE ORDERS
ADD IsDeleted BIT DEFAULT 0;

-- Đánh dấu đơn bị hủy
UPDATE ORDERS
SET IsDeleted = 1
WHERE Status = 'Canceled';


-- Truy vấn cho người dùng (không thấy đơn hủy)
SELECT *
FROM ORDERS
WHERE IsDeleted = 0;

-- Truy vấn cho kế toán (vẫn thấy đơn hủy)
SELECT *
FROM ORDERS
WHERE Status = 'Canceled';