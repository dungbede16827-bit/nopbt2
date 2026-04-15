create database customer;
use customer;

CREATE TABLE CUSTOMERS (
    customerID INT PRIMARY KEY,
    customerName VARCHAR(100) not null,
    email varchar(100) unique
    
);

create table orders (
	orderId int primary key,
    orderDate datetime not null default current_timestamp ,
    totalAmount Decimal(18,2) not null check (totalAmount >= 0),
    customerID int not null,
    constraint FK_Orders_Customers
    foreign key (customerID)
    -- khóa ngoại
    REFERENCES CUSTOMERS(customerID)
);