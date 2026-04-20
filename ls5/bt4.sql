-- hệ thoogns cần lọc các đơn hàng theo nhiều nguyên nhân thất bại
-- dùng or viết nhiều đk bằng nhau code dài khó mở rộng
-- dùng in gom các giá trị vào 1 danh sách ngắn gọn dễ đọc hơn
-- vì vậy nên dùng in để tối ưu 
SELECT *
FROM Orders
WHERE reason IN (
    'KHACH_HUY',
    'QUAN_DONG_CUA',
    'KHONG_CO_TAI_XE',
    'BOM_HANG'
);