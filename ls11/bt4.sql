input  
p_patient_id INT
p_phone VARCHAR(15)

Output 
p_total_debt DECIMAL
p_message VARCHAR

1.
cách giải dùng if rẽ nhánh 
tìm theo id 
tìm theo phone 
2.
query linh hoạt
WHERE (patient_id = p_patient_id OR p_patient_id IS NULL)
AND (phone = p_phone OR p_phone IS NULL)

Nên dùng Cách 1 (IF ELSE) - rõ ràng dễ sửa chữa
cách 2 tối ưu ngắn nhưng khó hiểu 

luồng xử lý

Nếu ID và Phone đều NULL -> báo lỗi
Nếu có ID -> tìm theo ID
Nếu có Phone -> tìm theo Phone
Nếu không có dữ liệu -> trả 0 + thông báo
Nếu có -> trả nợ + "Đã tìm thấy"

DELIMITER //
CREATE PROCEDURE GetPatientDebt(
    IN p_patient_id INT,
    IN p_phone VARCHAR(15),
    OUT p_total_debt DECIMAL(10,2),
    OUT p_message VARCHAR(100)
)
BEGIN

    IF p_patient_id IS NULL AND p_phone IS NULL THEN
        SET p_total_debt = 0;
        SET p_message = 'Lỗi: Phải nhập ID hoặc SĐT';
    ELSE
        IF p_patient_id IS NOT NULL THEN
            SELECT IFNULL(SUM(debt), 0)
            INTO p_total_debt
            FROM Patients
            WHERE patient_id = p_patient_id;

        ELSEIF p_phone IS NOT NULL THEN
            SELECT IFNULL(SUM(debt), 0)
            INTO p_total_debt
            FROM Patients
            WHERE phone = p_phone;
        END IF;

        -- Kiểm tra có tồn tại không
        IF p_total_debt = 0 THEN
            SET p_message = 'Không tìm thấy bệnh nhân';
        ELSE
            SET p_message = 'Đã tìm thấy';
        END IF;

    END IF;

END //

DELIMITER ;

CALL GetPatientDebt(1, NULL, @debt, @msg);
SELECT @debt, @msg;
CALL GetPatientDebt(NULL, '0901234567', @debt, @msg);
SELECT @debt, @msg;
CALL GetPatientDebt(NULL, NULL, @debt, @msg);
SELECT @debt, @msg;
CALL GetPatientDebt(9999, NULL, @debt, @msg);
SELECT @debt, @msg;


