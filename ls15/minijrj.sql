CREATE DATABASE mini_social;
USE mini_social;


CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT NOT NULL,
    like_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
);


CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (post_id)
    REFERENCES posts(post_id)
    ON DELETE CASCADE,

    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
);


CREATE TABLE likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    UNIQUE(user_id, post_id),

    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE,

    FOREIGN KEY (post_id)
    REFERENCES posts(post_id)
    ON DELETE CASCADE
);

CREATE TABLE friends (
    friendship_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    friend_id INT,
    status VARCHAR(20) DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE,

    FOREIGN KEY (friend_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
);

-- cn 1
CREATE VIEW view_user_info AS
SELECT user_id,username,email,created_at
FROM users;

-- đăng ký tk
DELIMITER //

CREATE PROCEDURE sp_add_user(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE total_user INT;
    SELECT COUNT(*)
    INTO total_user
    FROM users
    WHERE username = p_username
    OR email = p_email;
    IF total_user > 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username hoac Email da ton tai';
    ELSE
        INSERT INTO users(username, password, email)
        VALUES(p_username,SHA2(p_password,256),p_email);
    END IF;
END //
DELIMITER ;
-- CHỨC NĂNG 3
-- TỰ ĐỘNG ĐẾM TƯƠNG TÁC
DELIMITER //
CREATE TRIGGER tg_after_like_insert
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    UPDATE posts
    SET like_count = like_count + 1
    WHERE post_id = NEW.post_id;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER tg_after_like_delete
AFTER DELETE ON likes
FOR EACH ROW
BEGIN

    UPDATE posts
    SET like_count =
    CASE
        WHEN like_count > 0 THEN like_count - 1
        ELSE 0
    END
    WHERE post_id = OLD.post_id;

END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER tg_after_comment_insert
AFTER INSERT ON comments
FOR EACH ROW
BEGIN

    UPDATE posts
    SET comment_count = comment_count + 1
    WHERE post_id = NEW.post_id;

END //

DELIMITER ;


DELIMITER //
CREATE TRIGGER tg_after_comment_delete
AFTER DELETE ON comments
FOR EACH ROW
BEGIN

    UPDATE posts
    SET comment_count =
    CASE
        WHEN comment_count > 0 THEN comment_count - 1
        ELSE 0
    END
    WHERE post_id = OLD.post_id;

END //

DELIMITER ;

-- CHỨC NĂNG 4
-- THỐNG KÊ HOẠT ĐỘNG

DELIMITER //
CREATE PROCEDURE sp_user_activity_report()
BEGIN
    SELECT u.user_id,u.username,COUNT(DISTINCT p.post_id) AS total_posts,
		COUNT(DISTINCT l.like_id) AS total_likes,
        COUNT(DISTINCT c.comment_id) AS total_comments
    FROM users u
    LEFT JOIN posts p ON u.user_id = p.user_id
    LEFT JOIN likes l ON u.user_id = l.user_id
    LEFT JOIN comments c ON u.user_id = c.user_id
    GROUP BY u.user_id, u.username;
END //
DELIMITER ;

-- CHỨC NĂNG 5
-- XÓA TÀI KHOẢN TOÀN VẸN

DELIMITER //
CREATE PROCEDURE sp_delete_user(
    IN p_user_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
    DELETE FROM likes
    WHERE user_id = p_user_id;
    DELETE FROM comments
    WHERE user_id = p_user_id;

    DELETE FROM friends
    WHERE user_id = p_user_id
    OR friend_id = p_user_id;

    DELETE FROM posts
    WHERE user_id = p_user_id;

    DELETE FROM users
    WHERE user_id = p_user_id;

    COMMIT;

END //

DELIMITER ;

-- CHỨC NĂNG 6
-- KIỂM SOÁT KẾT BẠN


DELIMITER //
CREATE TRIGGER tg_before_friend_insert
BEFORE INSERT ON friends
FOR EACH ROW
BEGIN
    DECLARE total_friend INT;
    IF NEW.user_id = NEW.friend_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong the ket ban voi chinh minh';
    END IF;
    SELECT COUNT(*)
    INTO total_friend
    FROM friends
    WHERE user_id = NEW.user_id
    AND friend_id = NEW.friend_id;

    IF total_friend > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Da ton tai loi moi ket ban';
    END IF;

    SELECT COUNT(*)
    INTO total_friend
    FROM friends
    WHERE user_id = NEW.friend_id
    AND friend_id = NEW.user_id;

    IF total_friend > 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Da ton tai loi moi nguoc chieu';

    END IF;

END //

DELIMITER ;

CREATE INDEX idx_post_user
ON posts(user_id);

CREATE INDEX idx_comment_post
ON comments(post_id);

CREATE INDEX idx_like_post
ON likes(post_id);


INSERT INTO users(username, password, email)
VALUES
('dung','123','dung@gmail.com'),
('an','123','an@gmail.com');

INSERT INTO posts(user_id, content)
VALUES
(1,'Hello MySQL'),
(2,'I love database');

INSERT INTO likes(user_id, post_id)
VALUES
(2,1);

INSERT INTO comments(post_id, user_id, content)
VALUES
(1,2,'Hay qua');

SELECT * FROM users;

SELECT * FROM posts;
SELECT * FROM comments;

SELECT * FROM likes;

SELECT * FROM friends;

SELECT * FROM view_user_info;

CALL sp_user_activity_report();