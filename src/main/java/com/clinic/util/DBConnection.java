package com.clinic.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/PAS"; // ✅ Database name
    private static final String USER = "root"; // ✅ MySQL username
    private static final String PASSWORD = "root"; // ✅ MySQL password

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // ✅ Load MySQL JDBC Driver
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ JDBC Driver Not Found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Database Connection Failed: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }


}