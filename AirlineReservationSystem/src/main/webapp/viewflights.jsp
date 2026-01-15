<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "java.time.LocalDateTime" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title><%=request.getParameter("airport") %> Flights</title>
	</head>

	<body>
		<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement st = con.createStatement();
		Statement availability = con.createStatement();
		
		String airport = request.getParameter("airport");
		StringBuilder query = new StringBuilder ("SELECT  sf.line_id, sf.flight_num, sf.reg_num, sf.departure, sf.arrival, sf.from_id, sf.to_id\n" +
	            "FROM scheduled_flight sf " +
	         	"WHERE sf.from_id = '" + airport + "' OR sf.to_id = '" + airport + "'");
		
		ResultSet rs1 = st.executeQuery(query.toString());

		%>
		<u>Flights</u>
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
		//close the connection.
		db.closeConnection(con);
		%>
		<%
		}catch (Exception ex) {
		out.print(ex);
	}
%>
	<br>
	<a href = "http://localhost:8080/cs336Sample/RepHome.jsp"> Customer Representative Home Page</a>

	</body>
</html>