<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "java.time.LocalDateTime" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Title</title>
	</head>

	<body>
		<%
	try {
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String username = request.getParameter("username");

	
			String flightnum = request.getParameter("flightnum");
			String departure = request.getParameter("departure");
			String time = request.getParameter("time");
			String depart = departure + " " + time;
			String regnum = request.getParameter("regnum");
			
			String insert = "INSERT INTO waitlist(username, flight_num, reg_num, departure)" 
					+ "VALUES (?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps = con.prepareStatement(insert);
			
			ps.setString(1, username);
			ps.setString(2, flightnum);
			ps.setString(3, regnum);
			ps.setTimestamp(4, Timestamp.valueOf(depart));
			
			
			ps.executeUpdate();
			
			out.println("");
			out.print("Added to Waitlist");
	


		
		
		con.close();
		
		
		
		


		
	} catch (Exception ex) {
		out.print(ex);
		out.println("failed");
	}
%>
	<br>
	<%if (session.getAttribute("user") == null){ %>
	<a href = "http://localhost:8080/cs336Sample/RepHome.jsp"> Customer Representative Home Page</a>
	<%}else{ %>
	<a href = "http://localhost:8080/cs336Sample/home.jsp"> Home Page</a>
	<%} %>
	</body>
</html>