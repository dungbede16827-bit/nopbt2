CREATE DATABASE OnlineLearning;
USE OnlineLearning;

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE
);
CREATE TABLE Instructor (
    instructor_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);
CREATE TABLE Course (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100),
    description TEXT,
    total_sessions INT,
    instructor_id VARCHAR(10),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);
CREATE TABLE Enrollment (
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    enroll_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);
CREATE TABLE Result (
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    mid_score FLOAT CHECK (mid_score BETWEEN 0 AND 10),
    final_score FLOAT CHECK (final_score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id, course_id) REFERENCES Enrollment(student_id, course_id)
);

INSERT INTO Student VALUES
('SV01', 'Nguyen Van A', '2003-05-10', 'a@gmail.com'),
('SV02', 'Tran Thi B', '2003-07-12', 'b@gmail.com'),
('SV03', 'Le Van C', '2002-03-21', 'c@gmail.com'),
('SV04', 'Pham Thi D', '2003-11-02', 'd@gmail.com'),
('SV05', 'Hoang Van E', '2002-09-09', 'e@gmail.com');

INSERT INTO Instructor VALUES
('GV01', 'Thay An', 'an@gmail.com'),
('GV02', 'Thay Binh', 'binh@gmail.com'),
('GV03', 'Co Chi', 'chi@gmail.com'),
('GV04', 'Co Dung', 'dung@gmail.com'),
('GV05', 'Thay Em', 'em@gmail.com');

INSERT INTO Course VALUES
('C01', 'SQL', 'Hoc SQL co ban', 20, 'GV01'),
('C02', 'Java', 'Lap trinh Java', 25, 'GV02'),
('C03', 'Python', 'Lap trinh Python', 30, 'GV03'),
('C04', 'Web', 'HTML CSS JS', 15, 'GV04'),
('C05', 'AI', 'Tri tue nhan tao', 40, 'GV05');

INSERT INTO Enrollment VALUES
('SV01', 'C01', '2026-04-01'),
('SV01', 'C02', '2026-04-02'),
('SV02', 'C01', '2026-04-03'),
('SV03', 'C03', '2026-04-04'),
('SV04', 'C04', '2026-04-05');

INSERT INTO Result VALUES
('SV01', 'C01', 7, 8),
('SV01', 'C02', 6, 7),
('SV02', 'C01', 8, 9),
('SV03', 'C03', 5, 6),
('SV04', 'C04', 9, 9);


UPDATE Student
SET email = 'newemail@gmail.com'
WHERE student_id = 'SV01';

UPDATE Course
SET description = 'Hoc SQL nang cao'
WHERE course_id = 'C01';

UPDATE Result
SET final_score = 10
WHERE student_id = 'SV01' AND course_id = 'C01';

DELETE FROM Enrollment
WHERE student_id = 'SV04' AND course_id = 'C04';

DELETE FROM Result
WHERE student_id = 'SV04' AND course_id = 'C04';

SELECT * FROM Student;
SELECT * FROM Instructor;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Result;