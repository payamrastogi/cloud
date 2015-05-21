package com.cloudproject.fetcher;

import org.json.JSONArray;
import org.json.JSONObject;

public class JSONParser 
{
	public JSONObject parseJson(JSONObject json)
	{
		JSONArray array = json.getJSONArray("results");
		JSONObject result = new JSONObject();
		JSONArray resultArray = new JSONArray();
		System.out.println(json.toString());
		for(int i=0;i<array.length();i++)
		{
			JSONObject temp = array.getJSONObject(i);
			JSONObject obj = new JSONObject();
			obj.put("name", temp.get("name"));
			if(temp.has("vicinity"))
				obj.put("vicinity", temp.get("vicinity"));
			else if(temp.has("formatted_address"))
				obj.put("vicinity",temp.get("formatted_address"));
			if(temp.has("price_level"))
				obj.put("priceLevel", temp.get("price_level"));
			else
				obj.put("priceLevel", "");
			obj.put("longitude", temp.getJSONObject("geometry").getJSONObject("location").get("lng"));
			obj.put("latitude", temp.getJSONObject("geometry").getJSONObject("location").get("lat"));
			if(temp.has("rating"))
				obj.put("rating", temp.get("rating"));
			else
				obj.put("rating", "");
			if(temp.has("opening_hours"))
				obj.put("open", temp.getJSONObject("opening_hours").get("open_now"));
			else
				obj.put("open", "false");
			if(temp.has("photos"))
				obj.put("photoReference", temp.getJSONArray("photos").getJSONObject(0).get("photo_reference"));
			else if(temp.has("icon"))
			{
				obj.put("icon", temp.get("icon"));
				obj.put("photoReference", "");
			}

				
			resultArray.put(obj);
		}
		result.put("result", resultArray);
		//System.out.println(result.toString());
		return result;
	}
}
