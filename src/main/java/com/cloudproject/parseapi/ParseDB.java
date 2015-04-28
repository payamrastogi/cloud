package com.cloudproject.parseapi;

import java.util.List;

import org.parse4j.Parse;
import org.parse4j.ParseException;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.parse4j.callback.FindCallback;

import com.cloudproject.facebook.FacebookDetails;

public class ParseDB 
{
	public ParseDB()
	{
		Parse.initialize("", "");
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
}
