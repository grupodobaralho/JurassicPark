package model;

import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.pool.OracleDataSource;

/***
 * Class that has methods to connect to an existing Oracle Database.
 */
public class Database {

	private static String mJdbcUrl = "jdbc:oracle:thin:@camburi.pucrs.br:1521:facin11g";
	private static String mUser = "BG104267";
	private static String mPassword = "BG104267";
	private static OracleDataSource mDataSource = null;

	/**
	 * Gets a new database connection.
	 * 
	 * @return Connection New connection.
	 * @throws SQLException.
	 */
	public static Connection getConnection() throws SQLException {
		if (mDataSource == null) {
			initialize();
		}

		return mDataSource.getConnection(mUser, mPassword);
	}

	/**
	 * Initializes the database, creating a new Data Source and set its Jdbc
	 * URL.
	 * 
	 * @throws SQLException
	 */
	public static void initialize() throws SQLException {
		mDataSource = new OracleDataSource();
		mDataSource.setURL(mJdbcUrl);
	}
}
