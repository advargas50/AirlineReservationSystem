<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Q & A</title>
	</head>

	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String str = "SELECT * FROM questions";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
		
		%>
		Search Questions By Keyword
		<form method = "post" action = "searchQA.jsp">
					<input type = "text" maxlength = "500" name = "keyword"/>
					<input type = "hidden" name = "user" value = <%=session.getAttribute("user") %>>
					<br>
					<input type = "submit" value = "Search"/>
				</form>
		
		
		
		<br>
			
			<!--  Make an HTML table to show the results in: -->
		<table>
				<%
				//parse out the results
				while (result.next()) {
					int qid = result.getInt("qid");
					String q = "" + Integer.toString(qid);
					%>
					
					<tr>  
		
						<td>User: <%= result.getString("username") %></td>
					</tr>
					
					<tr>
						<td>Q: <%= result.getString("question") %></td>
					</tr>
					<% 
					Statement state = con.createStatement();
					ResultSet set2 = state.executeQuery("SELECT answer FROM answers WHERE qid = " + qid);
					
					%>
					
				
					<%
					//parse out the results
					while (set2.next()) { %>
					<tr>
						<td>A: <%= set2.getString("answer") %></td>
						
					</tr>


										

				<% }
				%>
				
				
				<%
				out.println("");
				}
				//close the connection.
				db.closeConnection(con);
				%>
				
				<tr>
				<td>
				<form method = "post" action = "answer.jsp">
					<br>
					<input type = "text" maxlength = "500" name = "question"/>
					<input type = "hidden" name = "user" value = <%=session.getAttribute("user") %>>
					<br>
					<input type = "submit" value = "Ask Question"/>
				</form>
				</td>
				</tr>
		</table>
		
		
		
		
	
			<%}catch (Exception e) {
				out.print(e);
			}%>
			<br>
			<a href = "http://localhost:8080/cs336Sample/home.jsp"> Home Page</a>
		

	</body>
</html>