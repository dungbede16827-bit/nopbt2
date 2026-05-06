input 
tổng chi phí 
diện bệnh nhân (BHYT,VJP , THUONG)
IN p_total_cost DECIMAL,
IN p_type VARCHAR
output
số tiền phải thu cuối cùng thông báo trạng thái 
hệ thống phải tự tính nhập sai phải báo lỗi
OUT p_final_amount DECIMAL,
OUT p_message VARCHAR

if kiểm tra lỗi else if phân loại set giá trị

các bước làm bài 
kiểm tra lỗi hợp lệ thì tính toán
gán thông báo thành công

DELIMITER $$
CREATE PROCEDURE CalculateBill( 
in p_total decimal(10,2),
in p_type varchar(10),
out p_final_amount decimal(10,2),
out p_message varchar(100)
)
BEGIN
    if p_type = 'BHYT' THEN 
    set p_final_amount = p_total * 0.2;
    elseif p_type = 'VIP' THEN 
    set p_final_amount = p_total * 0.9;
    else 
    set p_final_amount = p_total ;
    end if;
    set p_message = 'đã tính xong';
END$$ 
DELIMITER ; 