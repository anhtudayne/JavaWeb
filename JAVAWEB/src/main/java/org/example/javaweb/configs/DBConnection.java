package org.example.javaweb.configs;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/userdb";
    private static final String USER = "vovantu";
    private static final String PASSWORD = "vovantu123!!!";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver"); // load driver
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}