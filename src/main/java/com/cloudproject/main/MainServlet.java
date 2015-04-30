package com.cloudproject.main;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cloudproject.facebook.FBConnection;
import com.cloudproject.facebook.FBGraph;
import com.cloudproject.facebook.FacebookDetails;
import com.cloudproject.parseapi.ParseDB;

public class MainServlet extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	private String code="";

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		code = request.getParameter("code");
		if (code == null || code.equals("")) 
		{
			throw new RuntimeException("ERROR: Didn't get code parameter in callback.");
		}
		FBConnection fbConnection = new FBConnection();
		String accessToken = fbConnection.getAccessToken(code);

		FBGraph fbGraph = new FBGraph(accessToken);
		String graph = fbGraph.getFBGraph();
		Map<String, String> fbProfileData = fbGraph.getGraphData(graph);
		
		FacebookDetails facebookDetails = new FacebookDetails();
		facebookDetails.setFacebookId(fbProfileData.get("id"));
		facebookDetails.setFirstName(fbProfileData.get("first_name"));
		facebookDetails.setLastName(fbProfileData.get("last_name"));
		facebookDetails.setEmail(fbProfileData.get("email"));
		facebookDetails.setGender(fbProfileData.get("gender"));
		
		ParseDB parseDB = new ParseDB();
		parseDB.submitUserDetails(facebookDetails);
		
		HttpSession session = request.getSession();
		session.setAttribute("facebookId", fbProfileData.get("id"));
		
		RequestDispatcher rd = request.getRequestDispatcher("landingPage.jsp");
		rd.forward(request, response);
		
	}

}
//ExecutorService executor = Executors.newFixedThreadPool(2);
//DBConnection dbConnection = new DBConnection();
//Connection connection = dbConnection.connect();
//executor.submit(new DBWorker(connection, fbDetails));

/*out.println("<h1>Facebook Login using Java</h1>");
out.println("<h2>Application Main Menu</h2>");
out.println("<div>Welcome "+fbProfileData.get("first_name"));
out.println("<div>Your Email: "+fbProfileData.get("email"));
out.println("<div>You are "+fbProfileData.get("gender"));	*/	
