package database;

import java.sql.*;

public class MySqlConnection {
	private static String username = "cs564@yelpmysql";
	private static String password = "1979milkyway!";
	private static String jdbcUrl = "jdbc:mysql://yelpmysql.mysql.database.azure.com:3306/yelp_db?useSSL=true&requireSSL=false";
	
	private MySqlConnection() {}
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, username, password);
		} catch (ClassNotFoundException cnfe) {
			throw cnfe;
		} catch (SQLException se) {
			throw se;
		}
		return conn;
	}
}
