package com.cloudproject.websocket;

import java.io.File;
import java.io.IOException;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.cloudproject.fetcher.Config;
import com.cloudproject.fetcher.HttpFetcher;
import com.cloudproject.fetcher.JSONParser;
import com.cloudproject.fetcher.RequestParameters;


@ServerEndpoint("/websocket")
public class WebSocketServer 
{
	@OnOpen
	public void onOpen(Session session) 
	{
		System.out.println(session.getId() + " has opened a connection");
	}

	@OnMessage
	public void onMessage(String message, Session session) 
	{
		try
		{
			System.out.println("Message from " + session.getId() + ": " + message);
			String[] location = message.split(",");
			File homedir = new File(System.getProperty("user.home"));
			System.out.println(homedir);
			//File file = new File("/Users/payamrastogi/Dropbox/repositories/cloud/src/main/resources/config.properties");
			File file = new File("/home/ubuntu/apache-tomcat-8.0.22/webapps/config.properties");
			Config config = new Config(file);
			RequestParameters requestParam = new RequestParameters();
			if(!message.contains("@"))
			{
				requestParam.setLatitude(Double.parseDouble(location[0]));
				requestParam.setLongitude(Double.parseDouble(location[1]));
				requestParam.setRadius(10000);
				requestParam.setRankby("distance");
				requestParam.setOpenNow(false);
				requestParam.setNearBySearch(true);
			}
			else
			{
				message = message.replaceAll("\\s", "+");
				requestParam.setLatitude(0.0);
				requestParam.setLongitude(0.0);
				requestParam.setNearBySearch(false);
				requestParam.setQuery(message.substring(1));
				requestParam.setRadius(10000);
				requestParam.setRankby("distance");
				requestParam.setOpenNow(false);
			}
			String[] types = { "cafe", "bakery", "restaurant" };
			requestParam.setTypes(types);
			HttpFetcher httpFetcher = new HttpFetcher(config, requestParam);
			JSONParser parser = new JSONParser();
			JSONObject json = parser.parseJson(httpFetcher.readJsonFromUrl());
			System.out.println(json.toString());
			session.getBasicRemote().sendText(json.toString());
		}
		catch(IOException | JSONException e)
		{
			e.printStackTrace();
		}
	}

	@OnClose
	public void onClose(Session session) 
	{
		System.out.println("Session " + session.getId() + " has ended");
	}
}
