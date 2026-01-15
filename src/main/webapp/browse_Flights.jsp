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
		<title>Browse Trips</title>
    
	</head>
	
	<body>
	
	<%
	
	/* <form action="browse_Flights.jsp" method="POST">
	
	<br><u>Where to?</u><br>
		From <input type="text" name="from" placeholder = "ABC" required> 
		To <input type="text" name="to" placeholder = "DEF" required>
	
	<br><u>Type</u><br>
		<input type="radio" name="button1" value="oneWay"> One-Way
		<input type="radio" name="button1" value="roundTrip"> Round-Trip
	
	<br><u>When?</u><br>
		Departing <input type="date" name="departing" placeholder = "ABC"> <br>
		Returning <input type="date" name="returning" placeholder = "ABC"> (Only applicable for Round Trip) <br>
		Flexible (<=3 Days) <input type="checkbox" name="box1" value="yes"> 
		
	<br><u>Filter By</u><br>
		Stops <input type="text" name="numStops"> <br>
		Airline	<input type="text" name="airline" placeholder = "XX"> <br>
		Departure <input type="time" name="departure">
		Arrival <input type="time" name ="arrival"> <br>
	
	<input type="submit" value = "Browse Trips and Flights">
	</form> */

	
	String from = request.getParameter("from");
	String to = request.getParameter("to");
	
	String type = request.getParameter("button1");
	
	String departing = request.getParameter("departing");
	String returning = request.getParameter("returning");
	
	String flexible = request.getParameter("box1");
	
	String stops = request.getParameter("numStops");
	String airline = request.getParameter("airline");
	String departureTime = request.getParameter("departure");
	String arrivalTime = request.getParameter("arrival");
	
	String sortBy = request.getParameter("button2");
	
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement st = con.createStatement();
	
	StringBuilder query = new StringBuilder ("SELECT " +
		"t.trip_num, " +
	    "a_from.city AS from_airport, " +
	    "a_to.city AS to_airport, " +
	    "t.departure, " +
	    "t.arrival, " +
	    "t.stops, " +
	    "t.line_id AS airline, " +
	    "t.round_trip, " +
	    "t.eco_fare " +
	"FROM " +
	    "trip t " +
	"JOIN " +
	    "airport a_from ON t.from_id = a_from.port_id " +
	"JOIN " +
	    "airport a_to ON t.to_id = a_to.port_id ");
	
	// airports
	
	if (from != null && !from.isEmpty()) {
		query.append("AND t.from_id = '" + from + "' ");
	}
	
	if (to != null && !to.isEmpty()) {
		query.append("AND t.to_id = '" + to + "' ");
	}
	
	// flight type 
	
	if (type != null && !type.isEmpty()) {
		if (type.equals("roundTrip")) 
			query.append("AND t.round_trip = true ");
		else
			query.append("AND t.round_trip = false ");
	}
	
	// stops filter
	
	if (stops != null && !stops.isEmpty()) {
		query.append("AND t.stops = " + stops + " ");
	}
	
	if (airline != null && !airline.isEmpty()) {
		query.append("AND line_id = '" + airline + "' ");
	}
	
	// search by date 
	
	boolean flex = Boolean.parseBoolean(flexible);
	
	
	if (departing != null && !departing.isEmpty() && !flex) {
		query.append("AND t.departure >= '" +  departing + "' AND t.departure < adddate('" + departing + "', INTERVAL 1 DAY) ");	
	}
	
	if (returning != null && !returning.isEmpty() && !flex) {
		query.append("AND t.arrival >= '" +  returning + "' AND t.arrival < adddate('" + returning + "', INTERVAL 1 DAY) ");	
	} 
	
	// flexible search by date 
	
	if (departing != null && !departing.isEmpty()) {
		query.append("AND t.departure >= adddate('" + departing + "', INTERVAL -3 DAY) AND t.departure < adddate('" + departing + "', INTERVAL 3 DAY) ");	
	}

	if (returning != null && !returning.isEmpty()) {
		query.append("AND t.arrival >= adddate('" + returning + "', INTERVAL -3 DAY) AND t.arrival < adddate('" + returning + "', INTERVAL 3 DAY) ");
	} 
	
	// search by time
	
	if (departureTime != null && !departureTime.isEmpty()) {
		String hour = departureTime.substring(0,2);
		query.append ("AND hour(t.departure) = " + hour);
	}
	
	if (arrivalTime != null && !arrivalTime.isEmpty()) {
		String hour = arrivalTime.substring(0,2);
		query.append ("AND hour(t.arrival) = " + hour);
	}
	
	
	/* <br><u>Sort By</u><br>
	Price (low to high) <input type="radio" name="button2" value = "priceAsc"> Price (high to low) <input type="radio" name="button2" value = "priceDesc"> <br>
	Duration (short to long) <input type="radio" name="button2" value = "durAsc"> Duration (long to short) <input type="radio" name="button2" value = "durDesc"> <br>
	TakeOff (early to late) <input type="radio" name="button2" value = "toffAsc"> TakeOff (late to early) <input type="radio" name="button2" value = "toffDesc"> <br>
	Landing (early to late) <input type="radio" name="button2" value = "landAsc"> Landing (late to early) <input type="radio" name="button2" value = "landDesc"> <br> */

	if (sortBy != null && !sortBy.isEmpty()) {
		
		if (sortBy.equals("priceAsc")) {
			query.append (" ORDER BY t.eco_fare ASC");
		}
		else if (sortBy.equals("priceDesc")) {
			query.append (" ORDER BY t.eco_fare DESC");
		}
		else if (sortBy.equals("durAsc")) {
			query.append(" ORDER BY t.arrival - t.departure ASC");
		}
		else if (sortBy.equals("durDesc")) {
			query.append(" ORDER BY t.arrival - t.departure DESC");
		}
		else if (sortBy.equals("toffAsc")) {
			query.append(" ORDER BY hour(t.departure) ASC");
		}
		else if (sortBy.equals("toffDesc")) {
			query.append(" ORDER BY hour(t.departure) DESC");
		}
		else if (sortBy.equals("landAsc")) {
			query.append(" ORDER BY hour(t.arrival) ASC");
		}
		else if (sortBy.equals("landDesc")) {
			query.append(" ORDER BY hour(t.arrival) DESC");
		}
		
	}
	
	ResultSet rs = st.executeQuery(query.toString());
	
	%>
	
    <table border="5">
        <thead>
            <tr>
                <th>From</th>
                <th>To</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th># Stops</th>
                <th>Airline</th>
                <th>Round Trip</th>
                <th>Eco Fare</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
<%
        // Iterate through the result set and generate HTML rows
        while (rs.next()) {

%>
            <tr>
                <td><%= rs.getString("from_airport") %></td>
                <td><%= rs.getString("to_airport") %></td>
                <td><%= rs.getString("departure") %></td>
                <td><%= rs.getString("arrival") %></td>
                <td><%= rs.getString("stops") %></td>
                <td><%= rs.getString("airline") %></td>
                <td><%= rs.getString("round_trip") %></td>
                <td>$<%= rs.getString("eco_fare") %> </td>
                <td>
	                <form action ="tickets.jsp" method = "post">
	                	
	                	<input type="hidden" name = "tripNum" value = <%=rs.getString("trip_num")%>>
	                	<button type="submit">Tickets</button>
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