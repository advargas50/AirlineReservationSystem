<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reservations by flight</title>
</head>
<body>

<%@ page import ="java.sql.*" %> 
<p style="float: right;"><a href="AdminLogout.jsp">Log out</a></p>

<% 
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	String user = request.getParameter("user");
	String flightnum = request.getParameter("flightnum");
	
	if (flightnum == null)
	{
		%>
	
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
            
        </tr>
<%
    }
%>
    </tbody>
</table>
		
		<% 
	}else 
	{%>
		<br><u><%out.print(flightnum); %> Reservations</u><br>
	
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
		"WHERE fs.flight_num = '" + flightnum + "'");
	
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
          
        </tr>
<%
    }
%>
    </tbody>
</table>
		
		
	
		
		<%
	}
	con.close();
	
	%>
	
</body>
</html>