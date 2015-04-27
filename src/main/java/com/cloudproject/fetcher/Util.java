package com.cloudproject.fetcher;

import java.io.Closeable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Util 
{
	static final Logger logger = LoggerFactory.getLogger(Util.class);

	private Util() 
	{
		// this class is not designed to be instantiated
	}

	public static void close(Closeable c) 
	{
		if (c != null) 
		{
			try 
			{
				c.close();
			} 
			catch (Exception e) 
			{
				logger.warn(e.getMessage(), e);
			}
		}
	}
}
