package com.cloudproject.main;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.parse4j.ParseException;

import com.cloudproject.parseapi.ParseDB;

public class ProfileServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		String s = (String)session.getAttribute("facebookId");
		ParseDB parseDb = new ParseDB();
		parseDb.getUserDetails(s);
		System.out.println(s);
		request.setAttribute("userDetails", parseDb.getUserDetails(s));
		RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
		rd.forward(request, response);
	}
}
