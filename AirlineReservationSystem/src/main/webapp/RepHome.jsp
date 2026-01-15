<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Representative Home</title>
	</head>
	
	<body>

		<%
		if ((session.getAttribute("repuser") == null)) {
		%>
			You are not logged in<br/>
			<a href="RepLogin.jsp">Please Login</a>
		<% 
		} else { 
		%>
			Welcome Customer Representative <%=session.getAttribute("repuser")%> 
			
			
			<br>
			<br>
			
			
			
			Add Information For:
			<form method="post" action="information.jsp">
			  <input type="radio" name="command" value="aircraft"/>Aircrafts
			  <br>
			  <input type="radio" name="command" value="airport"/>Airports
			  <br>
			  <input type="radio" name="command" value="flight"/>Flights
			  <br>
			  <input type="submit" value="Add Information" />
			</form>
			<br>
			
			Add Airline:
	
			<form method = "post" action = "add.jsp">
				<table>
				<tr>
					<td>Airline ID: </td> 
					<td> <input type = "text" maxlength = "2" minlength = "2" name = "lineid"/></td>
				</tr>
				</table>
				<input type = "hidden" name = "command" value = "airline">
				<input type = "submit" value = "Add Airline"/>
			</form>
			<br>
			
			View Flights For:
			<%
				try
				{
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
	
				//Create a SQL statement
				Statement stmt = con.createStatement();
				ResultSet result = stmt.executeQuery("SELECT * FROM airport");
				%>
				<form method = "post" action = "viewflights.jsp">
				<table>
				<tr>
					<td>
					<label for = "label">Airport</label>
					<select name="airport" id = "label">
					<%
					while(result.next())
					{%>
						<option value = <%=result.getString("port_id")%>> <%out.print(result.getString("port_id")); %></option>
					<% 
					}
					%>
					</select>&nbsp;<br>
					</td>
				</tr>
				</table>
				<input type = "submit" value = "View Flights"/>
				</form><br>
				
				<% 
				db.closeConnection(con);
				}catch(Exception e) {
					out.print(e);
				}
		}
			
				%>
				
				
				Flight Reservation:
				<form method="post" action="reservations.jsp">
					<label for = "label">User:</label>
				  <input type = "text" id = "label" name = "username" >
				  <br>
				  <input type="submit" value="Make User Reservations" />
				</form>
			<br>
				
				
				User Questions:
				<form method="post" action="show.jsp">
				  <input type="hidden" name="command" value="questions"/>
				  <input type="submit" value="View and Answer User Questions" />
				</form>
			<br>
				
			
			
			
			
			<a href='logout.jsp'>Log out</a>

		
	</body>

</html>