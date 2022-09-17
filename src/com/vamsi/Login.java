package com.vamsi;

import java.sql.*;

public class Login {
	public static int validate(String id, String pass) {
		int i = -1;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");	
			PreparedStatement ps = con.prepareStatement("select * from user where email=? and pass=hex(aes_encrypt(?,'mini-project'))");
			ps.setString(1, id);
			ps.setString(2, pass);

			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				i = rs.getInt("id");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}

	public static String getUserName(String id) {
		String name = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");

			PreparedStatement ps = con.prepareStatement("select name from user where email=?");
			ps.setString(1, id);

			ResultSet rs = ps.executeQuery();
			while (rs.next())
				name = rs.getString(1);
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return name;
	}
}