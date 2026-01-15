<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Admin Login</title>
</head>
<body>
	<form action="CheckAdminLogin.jsp" method="POST">
       Username: <input type="text" name="Username"/> <br/>
       Password: <input type="password" name="Password"/> <br/>
       <input type="submit" value="GO"/>
     </form>
     
     <a href="login.jsp">User Login</a>
     <br>
     <a href="RepLogin.jsp">Customer Representative Login</a>
</body>

</html>