--  truy vấn danh sách khách hàng kích cầu hà nội
 --  Ngày lập: 16/04/2026
select 
    FullName, 
    Email
from 
    CUSTOMERS
where 
    --  Chỉ lấy khách hàng tại Hà Nội 
    City = N'Hà Nội'
    --  Khách không mua hàng hơn 6 tháng tính từ 01/04/2026
    AND LastPurchaseDate < '2025-10-01'
    --  Loại bỏ bẫy dữ liệu: Email trống hoặc NULL
    AND Email IS NOT NULL 
    AND Email <> ''
    --  Loại bỏ bẫy dữ liệu: Tài khoản đang bị khóa
    AND Status = 'Active';