-- Trong mỗi nhóm có nhiều room_name , nhưng bạn không chỉ định quy tắc chặn cái nào
-- sql buộc bạn viết truy vấn xác định duy nhất
-- sửa lại
SELECT hotel_id, MIN(price_per_night) AS min_price
FROM Rooms
GROUP BY hotel_id;
-- không phải cột nhóm không có quy tắc tổng hợp