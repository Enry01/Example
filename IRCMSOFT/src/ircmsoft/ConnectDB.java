package ircmsoft;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.Statement;
import java.util.ArrayList;


public class ConnectDB {
	public Connection conn;
	
	public Connection getConnection(){
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("jdbc/dsSOFT");
			conn = ds.getConnection("prog", "123");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return conn;	
	}
	
	public void closeConnection() throws SQLException{
		if (conn != null)
			if (!conn.isClosed()) {
				conn.close();
			}
	}
	
	public ResultSet userData() throws SQLException{
		ResultSet rs;
		String sql = "select * from PROG.USERS";
		Statement st = conn.createStatement();
		rs = st.executeQuery(sql);
		
		return rs;
	}
	
	public ResultSet outPutData() throws SQLException{
		ResultSet rs;
		String sql = "select * from PROG.PROGRAMS";
		Statement st = conn.createStatement();
		rs = st.executeQuery(sql);
		
		return rs;
	}
	
	public void insertData(ArrayList<String> arr) throws SQLException{
		String sql = "insert into PROG.PROGRAMS (NAME_PROGRAM, DESCRIPTION, ENVIRONMENT, PATH_SVN, AUTHOR, " + 
				                             "DEVELOPER, WHERE_USED, SERVER, STATUS, TECHNOLOG, SUB) values ('" +
											  arr.get(0) + "', '" + arr.get(1) + "', '" + arr.get(2) + "', '" +
				                              arr.get(3) + "', '" + arr.get(4) + "', '" + arr.get(5) + "', '" +
											  arr.get(6) + "', '" + arr.get(7) + "', '" + arr.get(8) + "', '" +
											  arr.get(9) + "', '" + arr.get(10) + "')";
		Statement st = conn.createStatement();
		st.executeUpdate(sql);
		st.close();
	}
	
	public void updateData(String id, ArrayList<String> arr) throws SQLException{
		String sql = "update PROG.PROGRAMS " +
				 "SET NAME_PROGRAM = '" + arr.get(0) + "', DESCRIPTION = '" + arr.get(1) + "', ENVIRONMENT = '" + arr.get(2) +
					 "', PATH_SVN = '" + arr.get(3) + "', AUTHOR = '" + arr.get(4) + "', DEVELOPER = '" + arr.get(5) +  
					 "', WHERE_USED = '" + arr.get(6) + "', SERVER = '" + arr.get(7) + "', STATUS = '" + arr.get(8) +
					 "', TECHNOLOG = '" + arr.get(9) + "', SUB = '" + arr.get(10) + "'" + 
					 "where ID = " + id;
		Statement st = conn.createStatement();
		st.executeUpdate(sql);
		st.close();
	}
	
	public void deleteData(String id) throws SQLException{
		String sql = "delete from PROG.PROGRAMS " +
	                 "where ID = " + id;
		Statement st = conn.createStatement();
		st.execute(sql);
		st.close();
	}
}
