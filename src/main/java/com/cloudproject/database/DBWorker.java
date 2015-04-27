package com.cloudproject.database;

import java.sql.Connection;

import com.cloudproject.facebook.FacebookDetails;

public class DBWorker implements Runnable
{
	private FacebookDetails facebookDetails;
	private DBQuery dbQuery;
	
	public DBWorker(Connection connection, FacebookDetails facebookDetails)
	{
		this.facebookDetails = facebookDetails;
		this.dbQuery = new DBQuery(connection);
	}
	
	public void run()
	{
		this.dbQuery.submitUserDetails(facebookDetails);
	}
}
