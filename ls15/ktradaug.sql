CREATE DATABASE StudentManagement;
USE StudentManagement;

CREATE TABLE students (
    student_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    total_debt DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE subjects (
    subject_id VARCHAR(5) PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credits INT CHECK (credits > 0)
);

CREATE TABLE grades (
    student_id VARCHAR(5),
    subject_id VARCHAR(5),
    score DECIMAL(4, 2) CHECK (score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);
-- Lịch sử sửa điểm
CREATE TABLE grade_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(5),
    old_score DECIMAL(4, 2), -- Điểm cũ trước khi bị sửa đổi
    new_score DECIMAL(4, 2), -- Điểm mới sau khi sửa đổi
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- Thời gian hệ thống ghi nhận thay đổi
    FOREIGN KEY (student_id) REFERENCES students (student_id)
);
-- ================================
-- DỮ LIỆU MẪU CHO BẢNG STUDENTS
-- ================================

INSERT INTO students (student_id, full_name, total_debt)
VALUES
('S001', 'Nguyen Van An', 1500000),
('S002', 'Tran Thi Bich', 2000000),
('S003', 'Le Hoang Nam', 0),
('S004', 'Pham Thu Ha', 500000),
('S005', 'Do Minh Quan', 1000000);

-- ================================
-- DỮ LIỆU MẪU CHO BẢNG SUBJECTS
-- ================================

INSERT INTO subjects (subject_id, subject_name, credits)
VALUES
('SB01', 'Co so du lieu', 3),
('SB02', 'Lap trinh Java', 4),
('SB03', 'Mang may tinh', 3),
('SB04', 'He dieu hanh', 4),
('SB05', 'Toan roi rac', 2);

-- ================================
-- DỮ LIỆU MẪU CHO BẢNG GRADES
-- ================================

INSERT INTO grades (student_id, subject_id, score)
VALUES
('S001', 'SB01', 8.5),
('S001', 'SB02', 7.0),
('S001', 'SB03', 9.0),

('S002', 'SB01', 6.5),
('S002', 'SB04', 7.5),
('S002', 'SB05', 8.0),

('S003', 'SB02', 9.5),
('S003', 'SB03', 8.0),

('S004', 'SB01', 5.5),
('S004', 'SB05', 6.0),

('S005', 'SB02', 7.5),
('S005', 'SB04', 8.5);

-- ================================
-- DỮ LIỆU MẪU CHO BẢNG GRADE_LOG
-- ================================

INSERT INTO grade_log (student_id, old_score, new_score)
VALUES
('S001', 7.0, 8.5),
('S002', 5.5, 6.5),
('S003', 8.0, 9.5),
('S004', 4.0, 5.5),
('S005', 6.5, 7.5);

-- cau 1
DELIMITER //
create trigger tg_check_score
before insert 
on grades
for each row
begin
if new.score < 0 then set new.score = 0 ;
elseif new.score > 10 then set new.score = 10 ;
end if;

end //

DELIMITER ;

insert into grades (student_id, subject_id, score)
value('S003','SB01',-10.0);
insert into grades (student_id, subject_id, score)
value('S004','SB03',11.0);


-- cau 2
start transaction;
insert into students (student_id,full_name) 
value('SV02','Ha Bich Ngoc');

update students
set total_debt = 5000000
where student_id = 'SV02';
commit ;

-- cau 3
DELIMITER //
create trigger tg_log_grade_update 
after update 
on grades
for each row
begin
 insert into grade_log(
 student_id,
 old_score ,
 new_scoce,
 change_date 
 )
 value (
 old.student_id,
 old.score,
 new.score,
 now()
 
 );
end //
DELIMITER ;

-- câu 4
DELIMITER //
create procedure sp_pay_tuition ()
begin
declare current_debt decimal(10,2);
start transaction ;
update students
set total_debt = total_debt - 2000000 
where student_id = 'SV01' ;
select total_debt into current_debt
from students
where student_id = 'SV01' ;
if current_debt < 0 then 
ROLLBACK ;
else commit;
end if;


end //
DELIMITER ;

-- câu 5
DELIMITER //
create trigger tg_prevent_pass_update
BEFORE UPDATE 
on grades
for each row

if old.score >= 4.0 then 
signal sqlstate '45000' 
    set message_text = 'không thể sửa đổi điểm vì đã qua môn';
end if //

DELIMITER ;




