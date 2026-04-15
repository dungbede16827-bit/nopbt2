create database books_management;

use books_management;

CREATE TABLE BOOK (
    MaSach CHAR(5) PRIMARY KEY,
    TenSach VARCHAR(200) NOT NULL,
    SoLuong INT CHECK (SoLuong >= 0),
    GiaThue DECIMAL(10,2) DEFAULT 5000
);

ALTER TABLE BOOK
ADD NgayNhap DATE;

CREATE TABLE BORROW_BOOKS (
    MaMuon INT AUTO_INCREMENT PRIMARY KEY,
    MaSach CHAR(5) NOT NULL,
    NgayMuon DATE DEFAULT current_timestamp,

    


    FOREIGN KEY (MaSach) REFERENCES BOOK(MaSach)
);