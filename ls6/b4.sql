-- 1.Cách tiếp cận này không sử dụng mệnh đề WHERE, mà gom toàn bộ dữ liệu trước, sau đó mới lọc bằng HAVING.
-- 2.Cách này loại bỏ dữ liệu không cần thiết ngay từ đầu bằng WHERE, sau đó mới tiến hành gom nhóm.
-- So sánh & Đánh giá
-- cách 1 database phải đọc và gom nhóm toàn bộ dữ liệu
-- nếu có hàng triệu đơn hàng hệ thống vẫn phải load ram 
-- tính toán GROUP BY
-- SAU ĐÓ mới loại bỏ lãng phí tài nguyên 
-- cách 2 Chỉ giữ lại các dòng COMPLETED ngay từ đầu
-- Giảm mạnh số lượng bản ghi cần xử lý
-- GROUP BY chạy trên tập dữ liệu nhỏ hơn nhanh hơn nhiều

SELECT 
    hotel_id
FROM Bookings
WHERE status = 'COMPLETED'
GROUP BY hotel_id
HAVING 
    COUNT(*) >= 50
    AND AVG(total_price) > 3000000;