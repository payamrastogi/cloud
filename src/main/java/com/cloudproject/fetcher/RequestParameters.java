package com.cloudproject.fetcher;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class RequestParameters 
{
	private String key;
	private double latitude;
	private double longitude;
	private int radius;
	private String rankby; //distance, prominence
	private String keyword;
	private boolean openNow;
	private String[] types;
	private String query;
	
	public String getKey() 
	{
		return key;
	}
	
	public void setKey(String key) 
	{
		this.key = key;
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
	
	public int getRadius() 
	{
		return radius;
	}
	
	public void setRadius(int radius) 
	{
		this.radius = radius;
	}
	
	public String getRankby() 
	{
		return rankby;
	}
	
	public void setRankby(String rankby) 
	{
		this.rankby = rankby;
	}
	
	public String getKeyword() 
	{
		return keyword;
	}
	
	public void setKeyword(String keyword) 
	{
		this.keyword = keyword;
	}
	
	public boolean isOpenNow()
	{
		return openNow;
	}
	
	public void setOpenNow(boolean openNow) 
	{
		this.openNow = openNow;
	}
	
	public String[] getTypes() 
	{
		return types;
	}
	
	public void setTypes(String[] types) 
	{
		this.types = types;
	}
	
	public String getQuery() 
	{
		return query;
	}
	
	public void setQuery(String query) 
	{
		this.query = query;
	}
	
	public String generateUrlNearBySearch() throws UnsupportedEncodingException
	{
		StringBuilder sb = new StringBuilder();
		sb.append("/nearbysearch").append("/")
		.append("json").append("?")
		.append("key=").append(this.getKey()).append("&")
		.append("location=").append(this.getLatitude()).append(",").append(this.getLongitude()).append("&")
		.append("radius=").append(this.getRadius()).append("&");
		if(this.isOpenNow())
			sb.append("opennow").append("&");
		sb.append("types=");
		String s="";
		for(String type:types)
			s += type + "|";
		sb.append(URLEncoder.encode(s, "UTF-8"));
		return sb.toString();
		
	}
}
