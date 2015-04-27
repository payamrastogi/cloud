package com.cloudproject.foursquare;

import fi.foyt.foursquare.api.FoursquareApi;
import fi.foyt.foursquare.api.FoursquareApiException;
import fi.foyt.foursquare.api.Result;
import fi.foyt.foursquare.api.entities.CompactVenue;
import fi.foyt.foursquare.api.entities.VenuesSearchResult;

public class TestFourSquare 
{
	public void searchVenues(String ll) throws FoursquareApiException 
	{
	    // First we need a initialize FoursquareApi. 
	    FoursquareApi foursquareApi = new FoursquareApi("DYEPKYVZFCTHVLBCER0CKCMOHHBN4CILMWOMPVEEN0UIAKIV", "FPMLSYYCQSEX5JKFH4JIDEB4OAMKDB12JSRM244CXTODFN2J", "Callback URL");

	    // After client has been initialized we can make queries.
	    Result<VenuesSearchResult> result = foursquareApi.venuesSearch(ll, null, null, null, null, null, null, null, null, null, null);

	    if (result.getMeta().getCode() == 200)
	    {
	    	// if query was ok we can finally we do something with the data
	    	for (CompactVenue venue : result.getResult().getVenues()) 
	    	{
	    		// TODO: Do something we the data
	    		System.out.println(venue.getName());
	    	}
	    } 
	    else 
	    {
	    	// TODO: Proper error handling
	    	System.out.println("Error occured: ");
	    	System.out.println("  code: " + result.getMeta().getCode());
	    	System.out.println("  type: " + result.getMeta().getErrorType());
	    	System.out.println("  detail: " + result.getMeta().getErrorDetail()); 
	    }
	}
	
	public static void main(String args[]) throws FoursquareApiException
	{
		TestFourSquare t = new TestFourSquare();
		t.searchVenues("40.7,-74");
	}
}
