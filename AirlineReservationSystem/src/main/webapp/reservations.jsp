<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Edit Customer Reservations</title>
    
	</head>
	
	<body>
		<% 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement check = con.createStatement();
		String user = request.getParameter("username");
		ResultSet rs1 = check.executeQuery("SELECT username FROM user where username = '" + user + "'");
		
		
        if (!rs1.next())
        {
        	out.print("User does not exist");%>
        	<br>
        	
        	<a href = "http://localhost:8080/cs336Sample/RepHome.jsp"> Customer Representative Home Page</a>
        	
        <% 	
        }
        else
        {

		%>
		Filter
				<form action="Repbrowse_Flights.jsp" method="POST">
		
		<br><u>Where to?</u><br>
			From <input type="text" name="from" placeholder = "ABC" > 
			To <input type="text" name="to" placeholder = "DEF" >
		
		<br><u>Type</u><br>
			<input type="radio" name="button1" value="oneWay"> One-Way
			<input type="radio" name="button1" value="roundTrip"> Round-Trip
		
		<br><u>When?</u><br>
			Departing <input type="date" name="departing" placeholder = "ABC"> <br>
			Returning <input type="date" name="returning" placeholder = "ABC"> (Only applicable for Round Trip) <br>
			Flexible (<=3 Days) <input type="checkbox" name="box1" value="true"> 
			
		<br><u>Filter By</u><br>
			Stops <input type="text" name="numStops"> <br>
			Airline	<input type="text" name="airline" placeholder = "XX"> <br>
			Departure <input type="time" name="departure">
			Arrival <input type="time" name ="arrival"> <br>
		
		<br><u>Sort By</u><br>
			Price (low to high) <input type="radio" name="button2" value = "priceAsc"> Price (high to low) <input type="radio" name="button2" value = "priceDesc"> <br>
			Duration (short to long) <input type="radio" name="button2" value = "durAsc"> Duration (long to short) <input type="radio" name="button2" value = "durDesc"> <br>
			TakeOff (early to late) <input type="radio" name="button2" value = "toffAsc"> TakeOff (late to early) <input type="radio" name="button2" value = "toffDesc"> <br>
			Landing (early to late) <input type="radio" name="button2" value = "landAsc"> Landing (late to early) <input type="radio" name="button2" value = "landDesc"> <br>
		<input type = "hidden" name = "user" value = <%out.print(user); %>>
		<input type="submit" value = "Browse Trips and Flights">
		</form>
		
		<%} %>
		
		
		<br><u><%out.print(user + "'s"); %> Reservations</u><br>
		
		<%
		Statement st = con.createStatement();
		
		/* select fs.ticket_num, sf.from_id, sf.to_id, fs.flight_num,  fs.departure, sf.arrival, fs.seat_num, t.purchase_time
		from flight_seat fs 
		join ticket t on fs.ticket_num = t.ticket_num
		join seat s on fs.seat_num = s.seat_num AND fs.s_reg_num = s.reg_num
		join scheduled_flight sf on fs.line_id = sf.line_id AND fs.flight_num = sf.flight_num AND fs.sf_reg_num = sf.reg_num AND fs.departure = sf.departure
		where t.username = 'benl' */
		
		StringBuilder query1 = new StringBuilder("SELECT fs.ticket_num, sf.from_id, sf.to_id, fs.flight_num,  fs.departure, sf.arrival, fs.seat_num, s.class, fs.fare, t.purchase_time, " +
			
			"IF(sf.arrival < now(), 'PAST', 'UPCOMING') as wtf " +
			"FROM flight_seat fs " +
			"JOIN ticket t ON fs.ticket_num = t.ticket_num " +
			"JOIN seat s ON fs.seat_num = s.seat_num AND fs.s_reg_num = s.reg_num " +
			"JOIN scheduled_flight sf ON fs.line_id = sf.line_id AND fs.flight_num = sf.flight_num AND fs.sf_reg_num = sf.reg_num AND fs.departure = sf.departure " +
			"WHERE t.username = '" + user + "'");
		
		ResultSet set = st.executeQuery(query1.toString());
		
		%>
		
		<table border="5">
        <thead>
            <tr>
                <th>Ticket #</th>
                <th>From</th>
                <th>To </th>
                <th>Flight #</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Seat #</th>
                <th>Class</th>
                <th>Fare</th>
                <th>Date Purchased</th>
                <th>Type</th>
                <th>Action</th>
                
                
            </tr>
        </thead>
        <tbody>
<%
        // Iterate through the result set and generate HTML rows
        while (set.next()) {

%>
            <tr>
                <td><%= set.getString("fs.ticket_num") %></td>
                <td><%= set.getString("sf.from_id") %></td>
                <td><%= set.getString("sf.to_id") %></td>
                <td><%= set.getString("fs.flight_num") %></td>
                <td><%= set.getString("fs.departure") %></td>
                <td><%= set.getString("sf.arrival") %></td>
                <td><%= set.getString("fs.seat_num") %></td>
                <td><%= set.getString("s.class") %></td>
                <td>$<%= set.getString("fs.fare") %> </td>
                <td><%= set.getString("t.purchase_time") %> </td>
                <td><%= set.getString("wtf") %> </td>
                <td>
	                <form action ="cancel.jsp" method = "post">
	                	<button type="submit">Cancel</button>
	                	<input type="hidden" name = "ticketNum" value = "<%= set.getString("fs.ticket_num") %>">
	                	<input type="hidden" name = "class" value = "<%= set.getString("s.class") %>">
	                	<input type="hidden" name = "when" value = "<%= set.getString("wtf") %>">
	                </form>
               	</td>
            </tr>
<%
        }
%>
        </tbody>
    </table>

	</body>
	
</html>