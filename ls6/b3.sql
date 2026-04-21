-- Sử dụng GROUP BY user_id để đưa tất cả giao dịch của cùng một khách hàng về một dòng duy nhất.
-- Sử dụng hàm COUNT(*) đơn giản để xác định quy mô hoạt động của người dùng.
-- Đếm có điều kiện  Để đếm riêng số đơn 'CANCELLED' mà không dùng WHERE (vì WHERE sẽ làm mất các đơn khác), 
-- chúng ta lồng cấu trúc rẽ nhánh vào hàm tổng hợp:
-- Công thức: SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END)
--  Sử dụng mệnh đề HAVING để lọc các nhóm thỏa mãn đồng thời hai điều kiện (Tổng đơn >= 10 và Đơn hủy >= 5).
SELECT user_id, COUNT(*) AS total_bookings, SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) AS cancelled_bookings
FROM  bookings
GROUP BY user_id
HAVING COUNT(*) >= 10 AND SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) > 5;