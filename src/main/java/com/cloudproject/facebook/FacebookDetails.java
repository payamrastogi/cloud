package com.cloudproject.facebook;

public class FacebookDetails
{
	private String facebookId;
	private String email;
	private String firstName;
	private String lastName;
	private String gender;
	
	public String getFacebookId() 
	{
		return facebookId;
	}
	
	public void setFacebookId(String facebookId) 
	{
		this.facebookId = facebookId;
	}

	public String getEmail() 
	{
		return email;
	}

	public void setEmail(String email) 
	{
		this.email = email;
	}

	public String getFirstName()
	{
		return firstName;
	}

	public void setFirstName(String firstName) 
	{
		this.firstName = firstName;
	}

	public String getLastName() 
	{
		return lastName;
	}

	public void setLastName(String lastName) 
	{
		this.lastName = lastName;
	}

	public String getGender() 
	{
		return gender;
	}

	public void setGender(String gender)
	{
		this.gender = gender;
	}
}
