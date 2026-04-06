CREATE DATABASE IF NOT EXISTS smart_office_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE smart_office_db;

DROP TABLE IF EXISTS sys_user_role;
DROP TABLE IF EXISTS sys_role;
DROP TABLE IF EXISTS oa_meeting_apply;
DROP TABLE IF EXISTS oa_meeting_room;
DROP TABLE IF EXISTS oa_goods_item;
DROP TABLE IF EXISTS oa_goods_apply;
DROP TABLE IF EXISTS oa_report;
DROP TABLE IF EXISTS oa_leave;
DROP TABLE IF EXISTS oa_attendance;
DROP TABLE IF EXISTS oa_notice;
DROP TABLE IF EXISTS sys_user;
DROP TABLE IF EXISTS sys_department;

CREATE TABLE sys_department (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    leader_id BIGINT NULL,
    description VARCHAR(255) NULL,
    status TINYINT NOT NULL DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE sys_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    dept_id BIGINT,
    position VARCHAR(50),
    status TINYINT NOT NULL DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE sys_role (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL,
    role_code VARCHAR(50) NOT NULL UNIQUE,
    remark VARCHAR(200),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sys_user_role (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL
);

CREATE TABLE oa_notice (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    publisher_id BIGINT NOT NULL,
    is_top TINYINT NOT NULL DEFAULT 0,
    status TINYINT NOT NULL DEFAULT 1,
    publish_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE oa_attendance (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    attendance_date DATE NULL,
    check_in_time DATETIME NULL,
    check_out_time DATETIME NULL,
    check_in_status VARCHAR(20),
    check_out_status VARCHAR(20),
    day_status VARCHAR(20),
    exception_remark VARCHAR(255),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE oa_leave (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    leave_type VARCHAR(50) NOT NULL,
    start_time DATETIME NULL,
    end_time DATETIME NULL,
    days DECIMAL(5,1) NOT NULL,
    reason VARCHAR(500) NOT NULL,
    status TINYINT NOT NULL DEFAULT 0,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE oa_report (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    report_type VARCHAR(20) NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    plan TEXT,
    status TINYINT NOT NULL DEFAULT 0,
    reviewer_id BIGINT NULL,
    review_opinion VARCHAR(255),
    review_time DATETIME NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE oa_goods_apply (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    goods_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    status TINYINT NOT NULL DEFAULT 0,
    approver_id BIGINT NULL,
    approve_opinion VARCHAR(255),
    approve_time DATETIME NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE oa_goods_item (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    goods_name VARCHAR(100) NOT NULL,
    unit VARCHAR(20),
    stock INT NOT NULL DEFAULT 0,
    status TINYINT NOT NULL DEFAULT 1,
    remark VARCHAR(255),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE oa_meeting_room (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    location VARCHAR(100),
    equipment VARCHAR(255),
    status TINYINT NOT NULL DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE oa_meeting_apply (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    subject VARCHAR(200) NOT NULL,
    content VARCHAR(500),
    start_time DATETIME NULL,
    end_time DATETIME NULL,
    participants VARCHAR(500),
    status TINYINT NOT NULL DEFAULT 0,
    approver_id BIGINT NULL,
    approve_opinion VARCHAR(255),
    approve_time DATETIME NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO sys_role(role_name, role_code, remark) VALUES
('绠＄悊鍛?, 'ADMIN', '绯荤粺绠＄悊鍛?),
('鏅€氬憳宸?, 'EMPLOYEE', '鏅€氬憳宸?);

INSERT INTO sys_department(dept_name, description, status) VALUES
('缁煎悎绠＄悊閮?, '琛屾斂涓庝汉浜嬬鐞?, 1),
('鎶€鏈儴', '绯荤粺寮€鍙戜笌缁存姢', 1),
('璐㈠姟閮?, '璐㈠姟绠＄悊', 1);

INSERT INTO sys_user(username, password, real_name, gender, phone, email, dept_id, position, status) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', '绯荤粺绠＄悊鍛?, '鐢?, '13800000000', 'admin@workhub.com', 1, '绯荤粺绠＄悊鍛?, 1),
('zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '寮犱笁', '鐢?, '13800000001', 'zhangsan@workhub.com', 2, '寮€鍙戝伐绋嬪笀', 1),
('lisi', 'e10adc3949ba59abbe56e057f20f883e', '鏉庡洓', '濂?, '13800000002', 'lisi@workhub.com', 3, '璐㈠姟涓撳憳', 1);

INSERT INTO sys_user_role(user_id, role_id) VALUES (1, 1), (2, 2), (3, 2);

INSERT INTO oa_notice(title, content, publisher_id, is_top, status) VALUES
('绯荤粺涓婄嚎閫氱煡', '鏅烘収鍔炲叕绯荤粺鍩虹鐗堟湰宸插畬鎴愬垵濮嬪寲銆?, 1, 1, 1);

INSERT INTO oa_goods_item(goods_name, unit, stock, status, remark) VALUES
(''A4鎵撳嵃绾?', ''鍖?', 120, 1, ''甯哥敤鍔炲叕鑰楁潗''),
(''涓€х瑪'', ''鐩?', 80, 1, ''0.5mm 榛戣壊''),
(''璁功閽?', ''鐩?', 60, 1, ''24/6 閫氱敤瑙勬牸'');

