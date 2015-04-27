package com.cloudproject.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cloudproject.facebook.FacebookDetails;


public class DBQuery 
{
	private Connection connection;
	
	public DBQuery(Connection connection)
	{
		this.connection = connection;
	}
	
	public void submitUserDetails(FacebookDetails facebookDetails)
	{
		if(!isUserExists(facebookDetails))
		{
			this.insertUserDetails(facebookDetails);
		}
	}
	
	public boolean isUserExists(FacebookDetails facebookDetails)
	{
		try
		{
			PreparedStatement preparedStmt = connection.prepareStatement("select count(*) as userCounts from userDetails where facebookId=?");
			preparedStmt.setString(1, facebookDetails.getFacebookId());
			ResultSet result = preparedStmt.executeQuery();
			if(result.getInt("userCounts")==0)
			{
				return false;
			}
			else if(result.getInt("userCounts")==1)
			{
				return true;
			}
			else
			{
				throw new Exception();
			}
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}
	
	public synchronized void insertUserDetails(FacebookDetails facebookDetails)
	{
		try
		{
			PreparedStatement preparedStmt = connection.prepareStatement("Insert into userDetails (facebookId, firstName, lastName, gender, email)  values (?,?,?,?,?)");
			preparedStmt.setString(1, facebookDetails.getFacebookId());
			preparedStmt.setString(2, facebookDetails.getFirstName());
			preparedStmt.setString(3, facebookDetails.getLastName());
			preparedStmt.setString(4, facebookDetails.getGender());
			preparedStmt.setString(5, facebookDetails.getEmail());
			preparedStmt.executeQuery();
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
	}
}
