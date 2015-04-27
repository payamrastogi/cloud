package com.cloudproject.main;

import java.io.IOException;
import java.sql.Connection;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cloudproject.database.DBConnection;
import com.cloudproject.database.DBWorker;
import com.cloudproject.facebook.FBConnection;
import com.cloudproject.facebook.FBGraph;
import com.cloudproject.facebook.FacebookDetails;

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
		
		FacebookDetails fbDetails = new FacebookDetails();
		fbDetails.setFacebookId(fbProfileData.get("id"));
		fbDetails.setFirstName(fbProfileData.get("first_name"));
		fbDetails.setLastName(fbProfileData.get("last_name"));
		fbDetails.setEmail(fbProfileData.get("email"));
		fbDetails.setGender(fbProfileData.get("gender"));
		
		ExecutorService executor = Executors.newFixedThreadPool(2);
		DBConnection dbConnection = new DBConnection();
		Connection connection = dbConnection.connect();
		executor.submit(new DBWorker(connection, fbDetails));
		
		HttpSession session = request.getSession();
		session.setAttribute("facebookId", fbProfileData.get("id"));
		
		RequestDispatcher rd = request.getRequestDispatcher("landingPage.jsp");
		rd.forward(request, response);
		/*out.println("<h1>Facebook Login using Java</h1>");
		out.println("<h2>Application Main Menu</h2>");
		out.println("<div>Welcome "+fbProfileData.get("first_name"));
		out.println("<div>Your Email: "+fbProfileData.get("email"));
		out.println("<div>You are "+fbProfileData.get("gender"));	*/	
	}

}
