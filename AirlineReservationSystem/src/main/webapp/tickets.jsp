<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Browse Tickets</title>
	</head>
	
	<body>
	
	<%
	if (session.getAttribute("user") == null)
	{
		String user = request.getParameter("user");
	}
	
	String user = "";
	String tripNum = request.getParameter("tripNum");
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement st = con.createStatement();
	
	StringBuilder query = new StringBuilder("SELECT ts.trip_num, ts.line_id, ts.flight_num, ts.reg_num, ts.departure, sf.arrival, sf.from_id, sf.to_id\n" +
            "FROM trip_sequence ts " +
            "JOIN scheduled_flight sf ON ts.line_id = sf.line_id " +
            "AND ts.flight_num = sf.flight_num " +
            "AND ts.reg_num = sf.reg_num " +
            "AND ts.departure = sf.departure " +
            "WHERE ts.trip_num = '" + tripNum + "'");
	
	ResultSet rs1 = st.executeQuery(query.toString());

	%>
	<u>Flights Included</u>
    <table border="5">
        <thead>
            <tr>
                <th>From</th>
                <th>To</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Airline</th>
                <th>Flight #</th>
                <th>Registration #</th>
            </tr>
        </thead>
        <tbody>
        
<%
        // Iterate through the result set and generate HTML rows
        while (rs1.next()) {	
%>
            <tr>
                <td><%= rs1.getString("from_id") %></td>
                <td><%= rs1.getString("to_id") %></td>
                <td><%= rs1.getString("departure") %></td>
                <td><%= rs1.getString("arrival") %></td>
                <td><%= rs1.getString("line_id") %></td>
                <td><%= rs1.getString("flight_num") %></td>
                <td><%= rs1.getString("reg_num") %></td>
            </tr>
<%
        }
%>
        </tbody>
    </table>    
<%
	rs1.beforeFirst();
	
	int flightIndex = 0;
	while (rs1.next()) {
%> 
		<u><%=rs1.getString("from_id")%> -----> <%=rs1.getString("to_id")%></u> <br>
<% 
		
		String flight_num = rs1.getString("flight_num");
		String reg_num = rs1.getString("reg_num");
		String line_id = rs1.getString("line_id");
		String departure = rs1.getString("departure");
		
		StringBuilder query2 = new StringBuilder("SELECT fs.seat_num, s.class, fs.fare, fs.line_id, fs.flight_num, fs.sf_reg_num, fs.departure, fs.available " +
			"FROM flight_seat fs " +
			"JOIN seat s ON fs.s_reg_num = s.reg_num AND fs.seat_num = s.seat_num " +
			"WHERE line_id = '" + line_id + "' AND flight_num = '" + flight_num + "' AND sf_reg_num = '" + reg_num + "' AND departure = '" + departure + "' AND available = true"
			
		); 
		
		Statement st2 = con.createStatement();
		ResultSet rs2 = st2.executeQuery(query2.toString());
		
		
%>
		<form action = "purchase.jsp" method = "post">
	    <table border="5">
	        <thead>
	            <tr>
	                <th>Seat #</th>
	                <th>Class</th>
	                <th>Fare</th>
	                <th>Select</th>
	                
	            </tr>
	        </thead>
	        <tbody>
	        
	<%
	        // Iterate through the result set and generate HTML rows
	        while (rs2.next()) {	
	%>
	            <tr>
	                <td><%= rs2.getString("seat_num") %></td>
	                <td><%= rs2.getString("class") %></td>
	                <td>$<%= rs2.getString("fare") %></td> 
	                <td>
	                	<input type="radio" name = "selection<%= flightIndex%>" value = "<%= line_id %>_<%= flight_num %>_<%= reg_num %>_<%= departure %>_<%= rs2.getString("seat_num") %>_<%= rs2.getString("fare") %>">
	            </tr>
	<%
	        }
	%>
	        </tbody>
	    </table>  			
<% 		
	flightIndex++;
	}
%>      
		<b>Booking Fee: $12.00</b> <br>
		<input type="hidden" name = "flightIndex" value = <%= flightIndex %>>
		<input type="hidden" name = "tripNum" value = <%= tripNum %>>
		<input type ="hidden" name = "user" value = <%out.print(user); %>>
		<input type="submit" value = "Purchase">
	</form>
	</body>
	
</html>