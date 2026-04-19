create database sell_product;
drop database sell_product;
use sell_product;

create table products (
	maSanPham char(3) PRIMARY KEY,
    tenSanPham varchar(500) not null,
    size varchar(5) ,
    price DECIMAL(15,2) DEFAULT 5000 
);
select * from products;
INSERT INTO products(maSanPham, tenSanPham, size, price)
VALUES ("P01", "Áo sơ mi trắng", "L", 250000),
("P02", "Quần Jean xanh", "M", 450000),
("P03", "Áo thun Basic", "XL", 150000),
("P04", "Áo hoodie",null,  200000);

update products
Set price = 400000
where maSanPham = P01;

update products
Set price = price * 1.1;

delete from products 
where maSanPham = "P03";

select products
from maSanPham , size
where price = 300000;


