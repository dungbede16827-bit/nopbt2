-- nguyên nhân gây lỗi
-- ở phần update thiếu mệnh đề where nên là cập nhật tất cả các dòng trong bảng
-- nên là tất cả các sản phẩm đều bị giảm 10%
-- nên sửa chỗ update thành
UPDATE PRODUCTS
SET OriginalPrice = OriginalPrice * 0.9
WHERE Category = 'Electronics';