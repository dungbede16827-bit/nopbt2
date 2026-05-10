-- cần tạo thêm 2 trigger 
Trigger	Sự kiện	Thời điểm	Mục đích
BEFORE INSERT	INSERT	BEFORE	Kiểm tra trùng lịch khi thêm lịch mới
BEFORE UPDATE	UPDATE	BEFORE	Kiểm tra trùng lịch khi dời lịch khám
Dùng BEFORE để
Kiểm tra dữ liệu trước khi ghi xuống bảng.
Nếu phát hiện trùng lịch thì dùng SIGNAL để chặn giao dịch ngay lập tức
Điều kiện kiểm tra trùng lịch
Logic chuẩn
Một lịch bị xem là trùng nếu:
Cùng doctor_id
Cùng appointment_time
Trạng thái KHÔNG phải Cancelled
Các lịch có status = 'Cancelled' được xem là trống
Thêm điều kiện
status <> 'Cancelled'
hi UPDATE chính bản ghi đó thì không được tự nhận diện là trùng với chính nó.
 Loại trừ chính bản ghi hiện tại:
appointment_id <> NEW.appointment_id



CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    appointment_time DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL
);


DELIMITER //

CREATE TRIGGER trg_prevent_double_booking_insert
BEFORE INSERT
ON appointments
FOR EACH ROW
BEGIN
    DECLARE existing_count INT;

    SELECT COUNT(*)
    INTO existing_count
    FROM appointments
    WHERE doctor_id = NEW.doctor_id
      AND appointment_time = NEW.appointment_time
      AND status <> 'Cancelled';

    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bác sĩ đã có lịch hẹn vào khung giờ này';
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_prevent_double_booking_update
BEFORE UPDATE
ON appointments
FOR EACH ROW
BEGIN
    DECLARE existing_count INT;

    SELECT COUNT(*)
    INTO existing_count
    FROM appointments
    WHERE doctor_id = NEW.doctor_id
      AND appointment_time = NEW.appointment_time
      AND status <> 'Cancelled'
      AND appointment_id <> NEW.appointment_id;

    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bác sĩ đã có lịch hẹn vào khung giờ này';
    END IF;
END//

DELIMITER ;


INSERT INTO appointments(doctor_id, appointment_time, status)
VALUES (1, '2026-05-10 09:00:00', 'Pending');

INSERT INTO appointments(doctor_id, appointment_time, status)
VALUES (1, '2026-05-10 09:00:00', 'Pending');

INSERT INTO appointments(doctor_id, appointment_time, status)
VALUES (2, '2026-05-10 10:00:00', 'Cancelled');

INSERT INTO appointments(doctor_id, appointment_time, status)
VALUES (2, '2026-05-10 10:00:00', 'Pending');

INSERT INTO appointments(doctor_id, appointment_time, status)
VALUES (3, '2026-05-10 11:00:00', 'Pending');

UPDATE appointments
SET status = 'Completed'
WHERE appointment_id = 4;



SELECT * FROM appointments;