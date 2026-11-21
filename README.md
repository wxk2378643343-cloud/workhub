# WorkHub 智慧办公系统

![Java 8](https://img.shields.io/badge/Java%208-2563EB?style=flat-square)
![Spring MVC](https://img.shields.io/badge/Spring%20MVC-0F766E?style=flat-square)
![MyBatis](https://img.shields.io/badge/MyBatis-334155?style=flat-square)
![JSP](https://img.shields.io/badge/JSP-B45309?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-6D28D9?style=flat-square)

## 📌 项目简介

面向企业办公场景，覆盖组织与员工管理、公告、考勤请假、工作报告、物品申请和会议室预约。

## 🏗️ 系统架构

- Tomcat 运行 WAR，Spring MVC 控制器处理业务请求并渲染 JSP。
- MyBatis 将业务数据持久化到 MySQL。

## 📁 项目结构

| 路径 | 用途 |
| --- | --- |
| [`src/main/java`](src/main/java) | 控制器、业务和数据访问 |
| [`src/main/webapp`](src/main/webapp) | JSP 与静态资源 |
| [`sql`](sql) | 数据库和演示数据 |
| [`compose.yaml`](compose.yaml) | 本地部署配置 |

## 🚀 如何启动

Docker 负责构建 WAR 并启动 Tomcat 与 MySQL。

### Docker 本地部署

需要 Docker 和 Compose v2。在仓库根目录创建 `.env`，填写以下变量。

```dotenv
DB_ROOT_PASSWORD=replace_with_a_mysql_root_password
DB_PASSWORD=replace_with_an_app_database_password
APP_PORT=8080
```

```sh
docker compose config --quiet
docker compose up -d --build
docker compose ps
```

打开 [http://localhost:8080/smart-office/](http://localhost:8080/smart-office/) 并使用演示账号 `admin / 123456` 登录。

Dockerfile 构建 WAR 并部署到 Tomcat 9。Compose 用独立数据库用户连接 MySQL，初始化脚本只在空的数据库数据卷上运行。应用使用演示账号和旧式密码散列，部署范围限定在本地演示。

使用 `docker compose logs --tail=100` 查看日志。使用 `docker compose down` 停止服务并保留数据卷。

### 本地开发

需要 JDK 8、Maven、Tomcat 9 和 MySQL 8。在独立的本地数据库环境中，用有建库权限的 MySQL 账号执行 [初始化脚本](sql/smart_office_init.sql)。该脚本会重建 `smart_office_db` 中的应用表，清除其中的现有应用数据。执行后，然后在 [jdbc.properties](src/main/resources/jdbc.properties) 中设置本机数据库连接。在仓库根目录执行 `mvn clean package`，将 `target/smart-office.war` 放入 Tomcat 的 `webapps/` 后启动 Tomcat。应用地址为 `http://localhost:8080/smart-office/`。

## 项目结构

- [src/main/java](src/main/java/) 是 Web 控制器、业务和数据访问代码。
- [src/main/webapp](src/main/webapp/) 是 JSP 页面和静态资源。
- [src/main/resources](src/main/resources/) 是 Spring、MyBatis 和数据库连接配置。
- [sql/smart_office_init.sql](sql/smart_office_init.sql) 用于建立演示数据库和初始数据。
