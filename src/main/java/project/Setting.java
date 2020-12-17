package project;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class Setting {
    Context context;
    Context envContext;
    DataSource dataSource;

    public Connection getConnection() throws Exception {
        context = new InitialContext();
        envContext = (Context) context.lookup("java:comp/env");
        dataSource = (DataSource) envContext.lookup("jdbc/mysql");
        return dataSource.getConnection();
    }
}
