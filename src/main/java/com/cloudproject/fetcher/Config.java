package com.cloudproject.fetcher;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import com.cloudproject.fetcher.Util;

public class Config 
{
	public static final int CONN_TIMEOUT_SEC = 60;
	public static final int SO_TIMEOUT_SEC = 60;
	//https://maps.googleapis.com/maps/api/place/
	private final String hostName;
	private final String key;
	
	Config(Properties prop) 
	{
		this.hostName = prop.getProperty("hostName");
		this.key = prop.getProperty("key");
	}
	
	public Config(File configFile) 
	{
		this(loadProperties(configFile));
	}
	 
	static Properties loadProperties(File file) 
	{
		FileInputStream is = null;
		try 
		{
		    is = new FileInputStream(file);
		    return loadProperties(is);
		} 
		catch (IOException e) 
		{
		    throw new RuntimeException("Error loading property file " + file.getAbsolutePath(), e);
		} 
		finally 
		{
		     Util.close(is);
		}
	}

	static Properties loadProperties(InputStream is) 
	{
		Properties prop = new Properties();
		try 
		{
			prop.load(is);
		} 
		catch (IOException e) 
		{
		    throw new RuntimeException("Error loading property from stream", e);
		}
		return prop;
	}

	public String getHostName()
	{
		return hostName;
	}

	public String getKey() {
		return key;
	}
}
