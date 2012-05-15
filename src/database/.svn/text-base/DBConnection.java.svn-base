package database;

import java.sql.*;

public class DBConnection {
	
	static String account = "ccs108seantana";
	static String password = "aodahzie";
	static String server = "mysql-user.stanford.edu"; 
	static String database = "c_cs108_seantana";

	private Connection con;
	private Statement stmt;
	
	
	private static DBConnection sharedConnection;
	
	public static DBConnection getSharedConnection() {
		if(sharedConnection == null) sharedConnection = new DBConnection();
		return sharedConnection;
	}
	
	
	public DBConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver"); 
			con = DriverManager.getConnection( "jdbc:mysql://" + server, account ,password);
			stmt = con.createStatement(java.sql.ResultSet.TYPE_FORWARD_ONLY,java.sql.ResultSet.CONCUR_UPDATABLE);
			stmt.executeQuery("USE " + database); 
		} catch (SQLException e) { 
			throw new RuntimeException("ERR: SQL Exception in initial connection");
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("ERR: class not found");
		}
	}
	
	public synchronized ResultSet queryDB(String query) {
		try {
			return stmt.executeQuery(query);
		} catch (SQLException e) {
			throw new RuntimeException("ERR: SQL Exception when querying the database");
		}
	}
	
	public synchronized void updateDB(String statement) {
		try {
			stmt.executeUpdate(statement);
		} catch (SQLException e) {
			throw new RuntimeException("ERR: SQL Exception when updating the database");
		}
	}
	
	public synchronized ResultSet getGeneratedKeys() {
		try {
			return stmt.getGeneratedKeys();
		} catch (SQLException e) {
			throw new RuntimeException("ERR: SQL Exception when getting generated keys");
		}		
	}
	
	public synchronized ResultSet updateDBWithKeys(String statement) {
		try {
			stmt.executeUpdate(statement, Statement.RETURN_GENERATED_KEYS);
			return stmt.getGeneratedKeys();
		} catch (SQLException e) {
			throw new RuntimeException("ERR: SQL Exception when updating the database with keys");
		}
	}
}
