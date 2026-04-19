-- lỗi sai cú pháp 
-- thiếu dấu nháy ' ở cuối chuỗi Giao Hàng Nhanh 
-- sửa đúng VALUES ('Giao Hàng Nhanh', '0901234567');
-- Thiếu dữ liệu Phone bị null
-- phần insert thêm mỗi vetthell kh thêm số nên phần phone không có dữ liệu nên để null

-- sửa
INSERT INTO SHIPPERS (ShipperName, Phone)
VALUES 
('Giao Hàng Nhanh', '0901234567'),
('Viettel Post', '0987654321');
-- sửa thành có số điện thoai hoặc kh có số thì ghi rõ là NULL