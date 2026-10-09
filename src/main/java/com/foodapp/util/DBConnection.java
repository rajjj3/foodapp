
package com.foodapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/food_app";

    public static Connection connect()
            throws SQLException, ClassNotFoundException {

        String username =
                System.getenv("FOODAPP_DB_USERNAME");

        String password =
                System.getenv("FOODAPP_DB_PASSWORD");

        if (username == null || password == null) {
            throw new IllegalStateException(
                "Database credentials are not configured. "
                + "Set FOODAPP_DB_USERNAME and "
                + "FOODAPP_DB_PASSWORD."
            );
        }
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
                URL, username, password
        );
    }
    
    public static void disconnect(PreparedStatement pstmt,ResultSet res,Connection con) {
		try {
			if(pstmt!=null) {
				pstmt.close();
			}else {
				System.out.println("statement is null");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		try {
			if(res !=null) {
				res.close();
			}else {
				System.out.println("resultset is null");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		try {
			if(con !=null) {
				con.close();
			}else {
				System.out.println("Connection is null");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}