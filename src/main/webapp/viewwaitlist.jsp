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

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String flightnum = request.getParameter("flightnum");
		String regnum = request.getParameter("regnum");
		String depart = request.getParameter("departure");
		String time = request.getParameter("time");
		String departure = depart + " " + time;
		ResultSet result = stmt.executeQuery("SELECT * FROM waitlist JOIN user USING (username)"
											+ "WHERE flight_num = '" + flightnum + "' AND reg_num = '" + regnum + "' AND departure = '"
											+ departure + "'");
		%>
		<table>
			<tr>
				<td>Username</td>
				<td>First Name</td>
				<td>Last Name</td>
			</tr>
		<% 
		while (result.next())
		{%>
			<tr>
				<td><%=result.getString("username") %></td>
				<td><%=result.getString("fname") %></td>
				<td><%=result.getString("lname") %></td>
			</tr>
			
		
		<%
		}
		//close the connection.
		db.closeConnection(con);
		%>
		</table>
		<%
		}catch (Exception ex) {
		out.print(ex);
	}
%>
	<br>
	<a href = "http://localhost:8080/cs336Sample/RepHome.jsp"> Customer Representative Home Page</a>

	</body>
</html>