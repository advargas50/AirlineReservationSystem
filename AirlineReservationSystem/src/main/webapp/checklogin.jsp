<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Check Login</title>
	</head>
	
	<body>
		
		<%
		String userid = request.getParameter("user");
		String pwd = request.getParameter("pass");
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?allowPublicKeyRetrieval=true&useSSL=false","root", "(luxuriouslack777)");
		
		Statement st = con.createStatement();
		ResultSet rsUser;
		ResultSet rsAdmin;
		ResultSet rsRep;
		rsUser = st.executeQuery("select * from user where username='" + userid + "' and password='" + pwd + "'");
		
		
		if (rsUser.next()) {
			session.setAttribute("user", userid); // the username will be stored in the session
			out.println("welcome " + userid);
			out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("home.jsp");
		} else {
			out.println("Invalid password <a href='login.jsp'>try again</a>");
		}

		%>
		
	</body>

</html>