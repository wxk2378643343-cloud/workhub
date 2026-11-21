CREATE DATABASE IF NOT EXISTS smart_office_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE smart_office_db;
SET NAMES utf8mb4;

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
('管理员', 'ADMIN', '系统管理员'),
('普通员工', 'EMPLOYEE', '普通员工');

INSERT INTO sys_department(dept_name, description, status) VALUES
('综合管理部', '行政与人事管理', 1),
('技术部', '系统开发与维护', 1),
('财务部', '财务管理', 1);

INSERT INTO sys_user(username, password, real_name, gender, phone, email, dept_id, position, status) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', '男', '13800000000', 'admin@workhub.com', 1, '系统管理员', 1),
('zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三', '男', '13800000001', 'zhangsan@workhub.com', 2, '开发工程师', 1),
('lisi', 'e10adc3949ba59abbe56e057f20f883e', '李四', '女', '13800000002', 'lisi@workhub.com', 3, '财务专员', 1);

INSERT INTO sys_user_role(user_id, role_id) VALUES (1, 1), (2, 2), (3, 2);

INSERT INTO oa_notice(title, content, publisher_id, is_top, status) VALUES
('系统上线通知', '智慧办公系统已完成初始化。', 1, 1, 1);

INSERT INTO oa_goods_item(goods_name, unit, stock, status, remark) VALUES
('A4打印纸', '包', 120, 1, '常用办公耗材'),
('中性笔', '盒', 80, 1, '0.5mm 黑色'),
('订书钉', '盒', 60, 1, '24/6 通用规格');
