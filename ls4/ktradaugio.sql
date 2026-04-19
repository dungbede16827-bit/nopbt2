create database ShopManager;
-- drop database ShopManager;
use ShopManager;

create table Categories (
	category_id int primary key,
	category_name varchar(50) 
);

create table Products (
	product_id char(5) primary key,
	product_name varchar(50),
	price int not null,
	stock int not null,
	category_id int ,
    foreign key (category_id) REFERENCES Categories(category_id)
	on delete cascade

);
insert into Categories (category_id,category_name)
value	( 1 ,	'Điện tử'),
		(2  ,	'Thời trang');
        
insert into Products(product_id,product_name,price,stock,category_id)
value  (1,	'iPhone 15' , 25000000 ,10 , 1),
		(2,	'Samsung S23' , 20000000 ,5 , 1),
        (3,	'Áo sơ mi nam' , 500000 ,50 , 2),
		(4,	'Giày thể thao' , 1200000 ,20 , 2);
        
update Products
set price = 26000000
where product_name = 'iPhone 15';

update Products
set stock = stock + 10 
where category_id = 1 ;

delete from Products where product_id = 4;
delete from Products where price < 1000000;

select * from Products;

select * from Products where stock > 15;




        

