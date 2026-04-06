# Smart Office

基于 `Spring MVC + Spring + MyBatis + JSP + MySQL` 的企业级智慧办公系统骨架。

## 技术栈

- `Spring MVC`
- `Spring`
- `MyBatis`
- `JSP + Bootstrap + jQuery + ECharts`
- `MySQL`
- `Maven`

## 已实现模块

- 登录鉴权
- 首页仪表盘
- 用户管理
- 部门管理
- 公告管理
- 考勤管理
- 请假管理
- 工作报告
- 物品申请
- 会议室管理
- 会议预约
- 数据统计

## 初始化步骤

1. 创建 MySQL 数据库并执行 [sql/smart_office_init.sql](/G:/project/WorkHub/sql/smart_office_init.sql)
2. 修改 [src/main/resources/jdbc.properties](/G:/project/WorkHub/src/main/resources/jdbc.properties) 中的数据库账号密码
3. 使用 Maven 构建并部署到 Tomcat

## 默认账号

- 管理员：`admin`
- 密码：`123456`

密码存储方式：MD5，数据库中已写入 `123456` 的 MD5 值 `e10adc3949ba59abbe56e057f20f883e`
