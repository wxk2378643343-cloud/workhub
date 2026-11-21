# WorkHub · Smart Office

基于 Spring MVC、MyBatis、JSP 和 MySQL 的办公管理应用。包括用户和部门管理、公告、考勤与请假、工作报告、物品申请、会议室预约和统计。

## 项目结构

- [src/main/java](src/main/java/) 是 Web 控制器、业务和数据访问代码。
- [src/main/webapp](src/main/webapp/) 是 JSP 页面和静态资源。
- [src/main/resources](src/main/resources/) 是 Spring、MyBatis 和数据库连接配置。
- [sql/smart_office_init.sql](sql/smart_office_init.sql) 用于建立演示数据库和初始数据。

## Docker 本地部署

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

## 本地开发

需要 JDK 8、Maven、Tomcat 9 和 MySQL 8。在独立的本地数据库环境中，用有建库权限的 MySQL 账号执行 [初始化脚本](sql/smart_office_init.sql)。该脚本会重建 `smart_office_db` 中的应用表，清除其中的现有应用数据。执行后，然后在 [jdbc.properties](src/main/resources/jdbc.properties) 中设置本机数据库连接。在仓库根目录执行 `mvn clean package`，将 `target/smart-office.war` 放入 Tomcat 的 `webapps/` 后启动 Tomcat。应用地址为 `http://localhost:8080/smart-office/`。
