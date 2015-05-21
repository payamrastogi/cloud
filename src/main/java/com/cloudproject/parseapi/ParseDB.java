package com.cloudproject.parseapi;

import java.util.List;

import org.parse4j.Parse;
import org.parse4j.ParseException;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.parse4j.callback.FindCallback;

import com.cloudproject.facebook.FacebookDetails;
import com.cloudproject.main.UserDetails;

public class ParseDB 
{
	public ParseDB()
	{
		Parse.initialize("vwftD52imOBMOLEpUWlTUD52WjoxO8GAlMwIsh63", "xIrh6opaWrQunvl51cKWxSurWJL4x9hfpjeenyq5");
	}

	
	public void submitUserDetails(final FacebookDetails facebookDetails)
	{
		ParseQuery<ParseObject> query = ParseQuery.getQuery("userDetails");
        query.whereEqualTo("facebookId", facebookDetails.getFacebookId());
        query.findInBackground(new FindCallback<ParseObject>()
        {
            @Override
            public void done(List<ParseObject> list, ParseException e) 
            {
                if (e == null) 
                {
                   if(list!=null && list.size()>0)
                   {
                	   System.out.println("user already exists");
                   }
                   else
                   {
                	   ParseObject userDetails = new ParseObject("userDetails");
                	   userDetails.put("facebookId", facebookDetails.getFacebookId());
                	   userDetails.put("firstName", facebookDetails.getFirstName());
                	   System.out.println(facebookDetails.getLastName());
                	   userDetails.put("lastName", facebookDetails.getLastName());
                	   userDetails.put("gender", facebookDetails.getGender());
                	   userDetails.put("email", facebookDetails.getEmail());
                	   userDetails.saveInBackground();
                   }
                } 
                else 
                {
                	e.printStackTrace();
                }
            }
        });
	}
	
	
	public UserDetails getUserDetails(final String facebookId)
	{
		ParseQuery<ParseObject> query = ParseQuery.getQuery("userDetails");
        query.whereEqualTo("facebookId", facebookId);
        final UserDetails userDetails = new UserDetails();
        query.findInBackground(new FindCallback<ParseObject>()
        {
            @Override
            public void done(List<ParseObject> list, ParseException e) 
            {
                if (e == null) 
                {
                   if(list!=null && list.size()>0)
                   {
                	   ParseObject parseObject = list.get(0);
                	   userDetails.setFirstName((String)parseObject.get("firstName"));
                	   userDetails.setLastName((String)parseObject.get("lastName"));
                	   userDetails.setEmail((String)parseObject.get("email"));
                	   userDetails.setGender((String)parseObject.get("gender"));
                	   System.out.println(parseObject.get("firstName"));
                   }
                   else
                   {
                	   //error!!
                   }
                } 
                else 
                {
                	e.printStackTrace();
                }
            }
        });
        return userDetails;
	}
}
