<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
	<head>
		<meta charset="UTF-8">
		<title>Customer Representative Login</title>
	</head>
	
	<body>
		<form method="post" action="CheckRep.jsp">
			<table>
				<tr>    
					<td>UserName</td><td><input type="text" name="repuser"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="password" name="reppass"></td>
				</tr>
			</table>
			<input type="submit" value="GO">
		</form>
		
		<a href="login.jsp">User Login</a>
		<br>
		<a href="AdminLogin.jsp">Admin Login</a>
	</body>
	
	
</html>