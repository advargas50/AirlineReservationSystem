<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Submission</title>
	</head>

	<body>
		<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		if(session.getAttribute("user") == null)
		{
			//Get parameters from the HTML form at the index.jsp
			String answer = request.getParameter("command");
			int qid = Integer.parseInt(request.getParameter("qid"));
			String rep = request.getParameter("repuser");
			String user = request.getParameter("user");
			
			
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO answers(qid, username, answer, repusername)"
					+ "VALUES (?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, qid);
			ps.setString(2, user);
			ps.setString(3, answer);
			ps.setString(4, rep);
			//Run the query against the DB
			ps.executeUpdate();
			//Run the query against the DB
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			out.print("Question Answered Successfully");
		}
		else 
		{
			String question = request.getParameter("question");
			String user = request.getParameter("user");
			
			String insert = "INSERT INTO questions(question, username) VALUES (?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps = con.prepareStatement(insert);
			
			ps.setString(1, question);
			ps.setString(2, user);
			
			ps.executeUpdate();
			
			con.close();
			out.print("Question Asked Successfully");
		}


		
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>
	<br>
	<%if (session.getAttribute("user") == null){ %>
	<a href = "show.jsp"> Customer Questions</a>
	<%}else{ %>
	<a href = "http://localhost:8080/cs336Sample/questions.jsp"> Questions</a>
	<%} %>
	</body>
</html>