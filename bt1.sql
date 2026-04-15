-- 1. Vấn đề sai lệch tiền bạc
-- Price DECIMAL(18, 2)
-- đúng chuẩn để lưu tiền nhưng cứ bị làm tròn liên tiếp
-- làm mất đi số tiền thật ban đầu
-- varchar quá lớn giảm kích thước hợp lý


create table PRODUCTS (
	ID int primary key,
    productName varchar(100),
    price decimal(18,2),
    quantity int,
    totalAmount decimal(18,2),
    descriptionn varchar(500)
);