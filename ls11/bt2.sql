DELIMITER //

CREATE PROCEDURE AddInventory(IN p_item_id INT, IN p_quantity INT)
BEGIN
UPDATE Inventory
SET stock_quantity = stock_quantity + p_quantity
WHERE item_id = p_item_id;
END //

DELIMITER ;

-- vấn đề không kiểm tra p_quantity nếu âm thì hệ thống sẽ tự trừ
-- Do  không kiểm tra giá trị đầu vào p_quantity, nên khi truyền số âm,
-- câu lệnh UPDATE sẽ thực hiện phép cộng với số âm, dẫn đến việc trừ trực tiếp vào tồn kho.
-- sửa lỗi 
drop procedure AddInventory;
-- viết lại

DELIMITER //

CREATE PROCEDURE AddInventory(IN p_item_id INT, IN p_quantity INT)
BEGIN
if p_quantity > 0 then
UPDATE Inventory
SET stock_quantity = stock_quantity + p_quantity
WHERE item_id = p_item_id; 
else 
select 'lỗi! số nhập phải lớn hơn 0' as error_message;
end if;
END //

DELIMITER ;