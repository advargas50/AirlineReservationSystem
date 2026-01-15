<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "java.time.LocalDateTime" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Information Submission</title>
	</head>

	<body>
		<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		
		
		String entity = request.getParameter("command");

		if (entity.equals("user"))
		{
			String username = request.getParameter("username");
			String fname = request.getParameter("fname");
			String lname = request.getParameter("lname");
			String pass = request.getParameter("pass");
			
			String insert = "INSERT INTO user(username, fname, lname, password)"
					+ "VALUES (?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ps = con.prepareStatement(insert);
			
			ps.setString(1, username);
			ps.setString(2, fname);
			ps.setString(3, lname);
			ps.setString(4, pass);
			//Run the query against the DB
			ps.executeUpdate();
			
			out.println("");
			out.print("User Added Successfully");
		}
		else if (entity.equals("rep"))
		{
			String username = request.getParameter("username");
			String fname = request.getParameter("fname");
			String lname = request.getParameter("lname");
			String pass = request.getParameter("pass");
			
			String insert = "INSERT INTO rep(username, fname, lname, password)"
					+ "VALUES (?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ps = con.prepareStatement(insert);
			
			ps.setString(1, username);
			ps.setString(2, fname);
			ps.setString(3, lname);
			ps.setString(4, pass);
			//Run the query against the DB
			ps.executeUpdate();
			
			out.println("");
			out.print("Customer Representative Added Successfully");
		}
		
		
		con.close();
		
		
		
		


		
	} catch (Exception ex) {
		out.print(ex);
		out.println("insert failed");
	}
%>
	<br>
	<a href = "AdminSuccess.jsp"> Admin Home Page</a>

	</body>
</html>