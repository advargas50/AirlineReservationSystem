<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Browse Trips</title>
    
	</head>
	
	<body>
	
	<%
		String ticketNum = request.getParameter("ticketNum");
		String when = request.getParameter("when");
		String sclass = request.getParameter("class");
		
	if (when.equals("UPCOMING")) {
			
		
		double fee = 0;
		
		if (sclass.equals("E"))
			fee = 50;
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		Statement st = con.createStatement();
		
		StringBuilder update  = new StringBuilder("UPDATE flight_seat " +
			"SET ticket_num = null, available = true " +
			"WHERE ticket_num = " + ticketNum);
		StringBuilder update2  = new StringBuilder("DELETE FROM ticket " +
			"WHERE ticket_num = " + ticketNum);
				
		st.executeUpdate(update.toString());	
		st.executeUpdate(update2.toString());
		
	%>
	
	<b>Cancellation Fee: $<%= fee %></b> <br>
	<b>Reservation for Ticket # <%=ticketNum %> has been cancelled.</b>
	<%
	if (session.getAttribute("user") == null)
	{
	%>
	<a href='RepHome.jsp'>Customer Representative Home</a>
	<%}else
	{
	%>
	<a href='home.jsp'>Home</a>
	<%} %>
<% } else { %>

	<b>Cannot Cancel Past Flight</b> <br>
	<%
	if (session.getAttribute("user") == null)
	{
	%>
	<a href='RepHome.jsp'>Home</a>
	<%}else
	{
	%>
	<a href='home.jsp'>Home</a>
	<%} %>
	
<% } %>

	</body>
	
</html>