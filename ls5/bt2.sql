-- SQL không đảm bảo thứ tự dòng database trả về dữ liệu ngẫu nhiên
-- chỉ lấy 5 dòng đầu tiên nó gặp không phải 5 dòng mới nhất
-- dùng order by
select restaurant_name , created_at
from Restaurants 
ORDER BY created_at desc
-- sắp xếp mới nhất -> cũ nhất
limit 5;