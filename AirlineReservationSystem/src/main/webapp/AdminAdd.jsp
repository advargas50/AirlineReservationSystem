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
		
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			
			//Run the query against the database.
			
			
			
			
			if (entity.equals("user"))
			{%>
				Add User:
	
				<form name = "user" method = "post" action = "AdminCreate.jsp">
					<table>
					<tr>
						<td>Username: </td> 
						<td> <input type = "text" minlength = "1" maxlength = "50" name = "username"/></td>
					</tr>
					<tr>
						<td> First Name: </td>
						<td><input type = "text" minlength = "1" name = "fname"/></td>
					</tr>
					<tr>
						<td> Last Name: </td>
						<td><input type = "text" minlength = "1" name = "lname"/></td>
					</tr>
					<tr>
						<td> Password: </td>
						<td><input type = "text" minlength = "1" name = "pass"/></td>
					</tr>
					</table>
					<input type = "hidden" name = "command" value = "user">
					<br>
					<input type = "submit" value = "Add User"/>
				</form>
			<% 
			}
			else if (entity.equals("rep"))
			{%>
				Add Customer Representative:
	
				<form name = "user" method = "post" action = "AdminCreate.jsp">
					<table>
					<tr>
						<td>Username: </td> 
						<td> <input type = "text" minlength = "1" maxlength = "50" name = "username"/></td>
					</tr>
					<tr>
						<td> First Name: </td>
						<td><input type = "text" minlength = "1" name = "fname"/></td>
					</tr>
					<tr>
						<td> Last Name: </td>
						<td><input type = "text" minlength = "1" name = "lname"/></td>
					</tr>
					<tr>
						<td> Password: </td>
						<td><input type = "text" minlength = "1" name = "pass"/></td>
					</tr>
					</table>
					<input type = "hidden" name = "command" value = "rep">
					<br>
					<input type = "submit" value = "Add Customer Representative"/>
				</form>
		
			<%
			}
			db.closeConnection(con);
			
		}
		catch (Exception e) {
			out.print(e);
		}%>
			
			
			<br>
			<a href = "AdminSuccess"> Admin Home Page</a>
		

	</body>
</html>