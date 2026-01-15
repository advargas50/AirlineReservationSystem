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
	String username = request.getParameter("user");
	String tripNum = request.getParameter("tripNum");
	String ticketNum = "";
	int numFlights = Integer.parseInt(request.getParameter("flightIndex"));
	int totalFare = 0;
	
	// calculate the total fare
	for (int i = 0; i < numFlights; i++) {
		String [] arr = request.getParameter("selection" + i).split("_", 0);
		totalFare += Integer.parseInt(arr[5]); 	
	}
	
	// create a new instance of ticket DONE
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement st = con.createStatement();
	Statement st2 = con.createStatement();
	
	StringBuilder update1 = new StringBuilder("INSERT INTO ticket (ticket_num, username, total_fare, booking_fee, purchase_time, trip_num) " +
		"VALUES (null, '" + username + "', " + totalFare + ", 12, now(), '" + tripNum + "')");
	
	st.executeUpdate(update1.toString());
	
	// get the new ticket number DONE
	
	StringBuilder query1 = new StringBuilder("SELECT ticket_num " +
		"FROM ticket " +
		"WHERE username = '" + username + "' AND trip_num = '" + tripNum + "'");
	
	ResultSet rs1 = st2.executeQuery(query1.toString());
	
	rs1.next();
	ticketNum = rs1.getString("ticket_num");
	
	// update rows of flight_seat 
			
	for (int i = 0; i < numFlights; i++) {
		
		String [] arr = request.getParameter("selection" + i).split("_", 0);
		
		// line_id flight_num reg_num departure seat_num fare
		//update flight_seat
		//set ticket_num = 1, available = false
		// how tf am I going to get the ticket number?
		
		Statement st3 = con.createStatement();
		
		StringBuilder update2 = new StringBuilder("UPDATE flight_seat " +
			
			"SET ticket_num = " + ticketNum + ", available = false " + 	
			"WHERE line_id = '" + arr[0] + "' AND flight_num = '" + arr[1] + "' AND sf_reg_num = '" + arr[2] + "' AND departure = '" + arr[3] + "' AND seat_num = '" + arr[4] + "'");
		
		st3.executeUpdate(update2.toString());
		
	} 
	
	%>
	
	<b>Ticket for <%out.print(username); %> purchased successfully.</b> <br>
	<u>Details:</u> <br>
	
	<!--  need to print details about each flight and seat. -->
	
	<%
		Statement st4 = con.createStatement();
		StringBuilder query2 = new StringBuilder("SELECT fs.ticket_num, fs.line_id, fs.flight_num, fs.departure, fs.seat_num, fs.fare, u.fname, u.lname, t.purchase_time " +
		
				"FROM flight_seat fs " +
				"JOIN ticket t on fs.ticket_num = t.ticket_num " +
				"JOIN user u on t.username = u.username " +
				"WHERE fs.ticket_num = " + ticketNum);
		
		ResultSet rs2 = st4.executeQuery(query2.toString());
	%>
	
	<table border="5">
        <thead>
            <tr>
                <th>Ticket #</th>
                <th>Airline</th>
                <th>Flight #</th>
                <th>Departure</th>
                <th>Seat #</th>
                <th>Fare</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Date Purchased</th>
            </tr>
        </thead>
        <tbody>
<%
        // Iterate through the result set and generate HTML rows
        while (rs2.next()) {

%>
            <tr>
                <td><%= rs2.getString("fs.ticket_num") %></td>
                <td><%= rs2.getString("fs.line_id") %></td>
                <td><%= rs2.getString("fs.flight_num") %></td>
                <td><%= rs2.getString("fs.departure") %></td>
                <td><%= rs2.getString("fs.seat_num") %></td>
                <td>$<%= rs2.getString("fs.fare") %></td>
                <td><%= rs2.getString("u.fname") %></td>
                <td><%= rs2.getString("u.lname") %> </td>
                <td><%= rs2.getString("t.purchase_time") %> </td>
            </tr>
<%
        }
%>
        </tbody>
    </table>
	
	
	<%if (session.getAttribute("user") == null){ %>
	<a href = "http://localhost:8080/cs336Sample/RepHome.jsp"> Customer Representative Home Page</a>
	<%}else{ %>
	<a href = "http://localhost:8080/cs336Sample/home.jsp"> Home Page</a>
	<%} %>
	
	</body>
	
</html>
