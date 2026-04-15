-- giải phép là dùng ALTER trực tiếp 
-- nhược đểm có thể người dùng không login được treo , crash hệ thống
-- giải pháp tối ưu trong trường hợp này thêm cột mới
-- câu lệnh để không làm sập ứng dụng
alter table USERS 
add column phone_New varchar(15),
ALGORITHM=INPLACE, LOCK=NONE;