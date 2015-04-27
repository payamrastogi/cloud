package com.cloudproject.fetcher;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.file.Paths;

import org.json.JSONException;
import org.json.JSONObject;

public class HttpFetcher 
{
	final Config config;
	RequestParameters requestParam;
	
	public HttpFetcher(Config config, RequestParameters requestParam)
	{
		this.config = config;
		this.requestParam = requestParam;
		this.requestParam.setKey(this.config.getKey());
	}
	
	private String readAll(Reader rd) throws IOException
	{
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = rd.read()) != -1) 
		{
			sb.append((char) cp);
		}
		return sb.toString();
	}

	public JSONObject readJsonFromUrl() throws IOException, JSONException 
	{
		String url = config.getHostName() + this.requestParam.generateUrlNearBySearch();
		System.out.println(url);
		InputStream is = new URL(url).openStream();
		try 
		{
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = readAll(rd);
			JSONObject json = new JSONObject(jsonText);
			return json;
		} 
		finally 
		{
			is.close();
		}
	}

	public static void main(String[] args) throws IOException, JSONException
	{
		File file = new File("src/main/resources/config.properties");
		Config config = new Config(file);
		RequestParameters requestParam = new RequestParameters();
		requestParam.setLatitude(40.7329808);
		requestParam.setLongitude(-74.0711359);
		requestParam.setRadius(500);
		requestParam.setRankby("distance");
		requestParam.setOpenNow(true);
		String[] types = {"cafe", "bakery", "restaurant"};
		requestParam.setTypes(types);
		HttpFetcher httpFetcher = new HttpFetcher(config, requestParam);
		JSONObject json = httpFetcher.readJsonFromUrl();
		System.out.println(json.toString());
		//System.out.println(json.get("id"));
	}
}
