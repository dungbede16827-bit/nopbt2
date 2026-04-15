-- hiện tượng xảy ra gửi email bị crash vì khách hàng không có email null họăc rỗng
-- có dữ liệu sai tuổi - 5 vô lý
-- thiếu not null cho email và unique
-- thiếu check cho AGE >= 0 
CREATE TABLE CUSTOMERS (
CustomerID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100), 
Age INT

);

alter table CUSTOMERS 
modify Email varchar(255) not null;

alter table CUSTOMERS
add constraint uq_email unique (Email);

alter table CUSTOMERS
add constraint chk_age check (Age >= 0);
