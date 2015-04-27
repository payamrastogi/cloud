package com.cloudproject.fetcher;

public class ResponseParameters 
{
	private String name;
	private double rating;
	private int priceLevel;
	private double latitude;
	private double longitude;
	private boolean openNow;
	
	public String getName() 
	{
		return name;
	}
	
	public void setName(String name) 
	{
		this.name = name;
	}
	
	public double getRating() 
	{
		return rating;
	}
	public void setRating(double rating) 
	{
		this.rating = rating;
	}

	public int getPriceLevel() 
	{
		return priceLevel;
	}

	public void setPriceLevel(int priceLevel) 
	{
		this.priceLevel = priceLevel;
	}

	public double getLatitude() 
	{
		return latitude;
	}

	public void setLatitude(double latitude) 
	{
		this.latitude = latitude;
	}

	public double getLongitude()
	{
		return longitude;
	}

	public void setLongitude(double longitude)
	{
		this.longitude = longitude;
	}

	public boolean isOpenNow()
	{
		return openNow;
	}

	public void setOpenNow(boolean openNow) 
	{
		this.openNow = openNow;
	}
}
