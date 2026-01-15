<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Check Rep Login</title>
	</head>
	
	<body>
		
		<%
		String repuserid = request.getParameter("repuser");
		String reppwd = request.getParameter("reppass");
		
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proje?allowPublicKeyRetrieval=true&useSSL=false","root", "(luxuriouslack777)");
		
		Statement st = con.createStatement();
		ResultSet rsRep;
		rsRep = st.executeQuery("select * from rep where username='" + repuserid + "' and password='" + reppwd + "'");
		

		if (rsRep.next()) {
			session.setAttribute("repuser", repuserid); // the username will be stored in the session
			out.println("welcome " + repuserid);
			out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("RepHome.jsp");
		} else {
			out.println("Invalid password <a href='RepLogin.jsp'>try again</a>");
		}
		%>
		
	</body>

</html>