<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Edit <%=request.getParameter("command") %> Information</title>
	</head>

	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			ResultSet lineids = stmt4.executeQuery("SELECT * FROM airline");
			ResultSet aircrafts = stmt2.executeQuery("SELECT reg_num FROM aircraft");
			ResultSet airports = stmt3.executeQuery("SELECT * FROM airport");
			
			
			if (entity.equals("aircraft"))
			{%>
				Add Aircraft:
	
				<form name = "air" method = "post" action = "add.jsp">
					<table>
					<tr>
						<td>Registration Number: </td> 
						<td> <input type = "text" minlength = "1" maxlength = "8" name = "registration"/></td>
					</tr>
					<tr>
						<td>Airline ID: </td> 
						<td> 
						<select name="lineid">
						<%
						while(lineids.next())
						{%>
							<option value = <%=lineids.getString("line_id")%>> <%out.print(lineids.getString("line_id")); %></option>
						<% 
						}
						%>
						</select>&nbsp;<br>
						</td>
					</tr>
					<tr>
						<td> Economic Class Capacity: </td>
						<td><input type = "number" min = "0" name = "ecocapacity"/></td>
					</tr>
					<tr>
						<td> Business Class Capacity: </td>
						<td><input type = "number" min = "0" name = "buscapacity"/></td>
					</tr>
					<tr>
						<td> First Class Capacity: </td>
						<td><input type = "number" min = "0" name = "fircapacity"/></td>
					</tr>
					<tr>
						<td> Model: </td>
						<td><input type = "text" minlength = "1" name = "model"/></td>
					</tr>
					</table>
					<input type = "hidden" name = "command" value = "aircraft">
					<br>
					<input type = "submit" value = "Add Aircraft"/>
				</form>
			<% 
			}
			else if (entity.equals("airport"))
			{%>
				Add Airport:
		
					<form method = "post" action = "add.jsp">
						<table>
						<tr>
							<td>Airport ID: </td> 
							<td> <input type = "text" maxlength = "3" minlength = "3" name = "portid"/></td>
						</tr>
						<tr>
							<td>City: </td> 
							<td> <input type = "text" minlength = "1" name = "city"/></td>
						</tr>
						</table>
						<input type = "hidden" name = "command" value = "airport">
						<br>
						<input type = "submit" value = "Add Airport"/>
					</form>
			<%
			}
			else if (entity.equals("flight"))
			{%>
				Add Flight:
		
					<form method = "post" action = "add.jsp">
						<table>
						<tr>
							<td>Flight Number: </td> 
							<td> <input type = "text" minlength = "1" maxlength = "7" name = "flightnum"/></td>
						</tr>
						<tr>
							<td>Aircraft Registration Number: </td>
							<td> 
							<select name="registration">
							<%
							while(aircrafts.next())
							{%>
								<option value = <%= aircrafts.getString("reg_num") %>> <%out.print(aircrafts.getString("reg_num")); %></option>
							<% 
							}
							%>
							</select>&nbsp;<br>
							</td>
						</tr>
						<tr>
							<td>From: </td>
							<td>
							<select name="from">
							<%
							while(airports.next())
							{%>
								<option value = <%=airports.getString("port_id")%>> <%out.print(airports.getString("port_id")); %></option>
							<% 
							}
							airports.beforeFirst();
							%>
							</select>&nbsp;<br>
							</td>
						</tr>
						<tr>
							<td>To: </td>
							<td>
							<select name="to">
							<%
							while(airports.next())
							{%>
								<option value = <%=airports.getString("port_id")%>> <%out.print(airports.getString("port_id")); %></option>
							<% 
							}
							%>
							</select>&nbsp;<br>
							</td>
						</tr>
						<tr>
							<td>Departure: </td>
							<td><input type = "datetime-local" min= "2024-01-01T00:00" max = "2025-01-01T00:00"name = "departure"></td>
						</tr>
						<tr>
							<td>Arrival: </td>
							<td><input type = "datetime-local" min= "2024-01-01T00:00" max = "2025-01-01T00:00"name = "arrival"></td>
						</tr>
						<tr>
							<td>Type: </td>
							<td><input type="radio" name="type" value="international"/>International
								  <br>
								  <input type="radio" name="type" value="domestic"/>Domestic
								  <br></td>
						</tr>
						</table>
						<input type = "hidden" name = "command" value = "flight">
						<br>
						<input type = "submit" value = "Add Flight"/>
					</form>

			<%
			}
			db.closeConnection(con);
			
		}
		catch (Exception e) {
			out.print(e);
		}%>
			
			
			<br>
			<a href = "http://localhost:8080/cs336Sample/RepHome.jsp"> Customer Representative Home Page</a>
		

	</body>
</html>