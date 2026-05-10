CREATE TRIGGER PreventStatusRevert
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN

IF NEW.status = 'Completed' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Loi: Khong duoc phep thao tac tren lich kham nay!';
END IF;

END
trigger cũ 
IF NEW.status = 'Completed'
-- nghĩ là chỉ cần cập nhật thành completed là bị chặn
old là dữ liệu cũ trước update 
new là dl mới sau update 
thì ta phải ktra dữ liệu cũ trước 
xem cũ có phải là completed hay không nên phải dùng OLD.status
nếu viết như cũ thì mọi cái cập nhật sang completed đều là lỗi nên sửa thành old kh sửa được lịch khám khi đã hoàn thành

DROP TRIGGER IF EXISTS PreventStatusRevert;

DELIMITER //

CREATE TRIGGER PreventStatusRevert
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN

    IF OLD.status = 'Completed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong duoc thay doi lich kham da Completed!';
    END IF;

END //

DELIMITER ;
