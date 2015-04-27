package com.cloudproject.websocket;

import java.io.File;
import java.io.IOException;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONException;
import org.json.JSONObject;

import com.cloudproject.fetcher.Config;
import com.cloudproject.fetcher.HttpFetcher;
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
			File file = new File(homedir, "workspace/CloudProject/src/main/resources/config.properties");
			Config config = new Config(file);
			RequestParameters requestParam = new RequestParameters();
			requestParam.setLatitude(Double.parseDouble(location[0]));
			requestParam.setLongitude(Double.parseDouble(location[1]));
			requestParam.setRadius(1000);
			requestParam.setRankby("distance");
			requestParam.setOpenNow(true);
			String[] types = { "cafe", "bakery", "restaurant" };
			requestParam.setTypes(types);
			HttpFetcher httpFetcher = new HttpFetcher(config, requestParam);
			JSONObject json = httpFetcher.readJsonFromUrl();
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
