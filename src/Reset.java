import java.sql.*;
public class Reset {
	public static int validate(String email) {
		int i = -1;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");	
			PreparedStatement ps = con.prepareStatement("select id from user where email=?");
			ps.setString(1, email);
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
	public static int check(String email,String answer) {
		int i = -1;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");	
			PreparedStatement ps = con.prepareStatement("select id from user where email=? and answer=hex(aes_encrypt(?,'mini-project'))");
			ps.setString(1, email);
			ps.setString(2, answer);
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
}
