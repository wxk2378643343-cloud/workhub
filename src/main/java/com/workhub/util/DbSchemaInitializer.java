package com.workhub.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@Component
public class DbSchemaInitializer {
    private static final Logger log = LoggerFactory.getLogger(DbSchemaInitializer.class);

    @Resource
    private DataSource dataSource;

    @PostConstruct
    public void initGoodsItemTable() {
        String existsSql =
                "SELECT COUNT(1) FROM information_schema.tables " +
                "WHERE table_schema = DATABASE() AND table_name = 'oa_goods_item'";

        String createTableSql =
                "CREATE TABLE IF NOT EXISTS oa_goods_item (" +
                "id BIGINT PRIMARY KEY AUTO_INCREMENT," +
                "goods_name VARCHAR(100) NOT NULL," +
                "unit VARCHAR(20)," +
                "stock INT NOT NULL DEFAULT 0," +
                "status TINYINT NOT NULL DEFAULT 1," +
                "remark VARCHAR(255)," +
                "create_time DATETIME DEFAULT CURRENT_TIMESTAMP," +
                "update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" +
                ")";

        String seedSql =
                "INSERT INTO oa_goods_item(goods_name, unit, stock, status, remark) VALUES " +
                "('A4 Paper', 'pack', 120, 1, 'default item')," +
                "('Pen', 'box', 80, 1, 'default item')," +
                "('Staple', 'box', 60, 1, 'default item')";

        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {
            int exists = 0;
            try (ResultSet rs = statement.executeQuery(existsSql)) {
                if (rs.next()) {
                    exists = rs.getInt(1);
                }
            }

            // Only initialize when table does not exist.
            if (exists == 0) {
                statement.execute(createTableSql);
                statement.executeUpdate(seedSql);
                log.info("Created and seeded table: oa_goods_item");
            } else {
                log.info("Table already exists, skipped initialization: oa_goods_item");
            }
        } catch (SQLException e) {
            log.error("Failed to initialize table oa_goods_item", e);
        }
    }
}
