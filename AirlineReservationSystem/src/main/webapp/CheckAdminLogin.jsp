<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Check Admin Login</title>
	</head>
	
	<body>
		
		<%
		String aduserid = request.getParameter("Username");
		String adpwd = request.getParameter("Password");
		
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proje?allowPublicKeyRetrieval=true&useSSL=false","root", "(luxuriouslack777)");
		
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from admin where adminuser='" + aduserid + "' and adminpass='" + adpwd + "'");
		

		if (rs.next()) {
			session.setAttribute("user", aduserid); // the username will be stored in the session
			out.println("welcome " + aduserid);
			out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("AdminSuccess.jsp");
		} else {
			out.println("Invalid password <a href='RepLogin.jsp'>try again</a>");
		}
		%>
		
	</body>

</html>