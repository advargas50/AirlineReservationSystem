<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login</title>
	</head>

	<body>

		<form method="post" action="checklogin.jsp">
			<table>
				<tr>    
					<td>UserName</td><td><input type="text" name="user"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="password" name="pass"></td>
				</tr>
			</table>
			<input type="submit" value="GO">
		</form>
		
		<a href="http://localhost:8080/cs336Sample/RepLogin.jsp">Cusomer Representative Login</a>
		<br>
		<a href="AdminLogin.jsp">Admin Login</a>

	</body>
</html>