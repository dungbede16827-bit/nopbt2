create database UserVIP;
use UserVIP;

create table Users(
	user_id int primary key,
    user_name varchar(50) not null
);
create table Hotels(
	hotels_id int primary key,
    hotels_name varchar(50),
    star int check (star between 1 and 5)
    
);

create table Bookings(
	booking_id int primary key,
    total_amount decimal(15,2),
	hotels_id int,
	user_id int,
    status ENUM('COMPLETED', 'FAILED', 'CANCELLED') NOT NULL,
    foreign key(user_id) references Users(user_id),
    foreign key(hotels_id) references Hotels(hotels_id)
); 
INSERT INTO Users (user_id, user_name) VALUES
(1, 'Nguyen Van A'),
(2, 'Tran Thi B'),
(3, 'Le Van C'),
(4, 'Pham Van D');

INSERT INTO Hotels (hotels_id, hotels_name, star) VALUES
(101, 'Luxury Hotel', 5),
(102, 'Premium Hotel', 4),
(103, 'Standard Hotel', 3);
INSERT INTO Bookings (booking_id, total_amount, hotels_id, user_id, status) VALUES

-- Nguyễn Văn A (5 sao -> VIP > 50tr)
(1, 30000000, 101, 1, 'COMPLETED'),
(2, 25000000, 101, 1, 'COMPLETED'),
-- Nguyễn Văn A (4 sao nhưng không đủ 50tr)
(3, 10000000, 102, 1, 'COMPLETED'),
-- Trần Thị B (có FAILED nên bị loại 1 phần)
(4, 40000000, 101, 2, 'COMPLETED'),
(5, 20000000, 101, 2, 'FAILED'),
-- Lê Văn C (4 sao -> đủ 50tr)
(6, 30000000, 102, 3, 'COMPLETED'),
(7, 25000000, 102, 3, 'COMPLETED'),
-- Phạm Văn D (3 sao -> không đủ điều kiện)
(8, 20000000, 103, 4, 'COMPLETED'),
(9, 10000000, 103, 4, 'COMPLETED');

-- lấy tên khách hàng , hạng khách sạn , số tiền khách đã chi
-- 1. lấy tên tất cả khách hàng
select u.user_id , u.user_name , h.star , sum(b.total_amount) as TongTienDaChi
from Users u 
join Bookings b on b.user_id = u.user_id
join Hotels h on h.hotels_id = b.hotels_id
where b.status = 'COMPLETED'
group by u.user_id , h.star -- gom vào thành một 
having sum(b.total_amount) > 50000000
order by h.star desc 
, TongTienDaChi desc