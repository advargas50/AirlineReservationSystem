<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "java.time.LocalDateTime" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Information Submission</title>
	</head>

	<body>
		<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		
		
		String entity = request.getParameter("command");

		if (entity.equals("aircraft"))
		{
			String registration = request.getParameter("registration");
			int ecocapacity = Integer.parseInt(request.getParameter("ecocapacity"));
			int buscapacity = Integer.parseInt(request.getParameter("buscapacity"));
			int fircapacity = Integer.parseInt(request.getParameter("fircapacity"));
			String lineid = request.getParameter("lineid");
			String model = request.getParameter("model");
			
			String insert = "INSERT INTO aircraft(reg_num, line_id, eco_capacity, bus_capacity, first_capacity, makemodel)"
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ps = con.prepareStatement(insert);
			
			ps.setString(1, registration);
			ps.setString(2, lineid);
			ps.setInt(3, ecocapacity);
			ps.setInt(4, buscapacity);
			ps.setInt(5, fircapacity);
			ps.setString(6, model);
			//Run the query against the DB
			ps.executeUpdate();
			
			out.println("");
			out.print("Aircraft Added Successfully");
		}
		else if (entity.equals("airport"))
		{
			String portid = request.getParameter("portid");
			String city = request.getParameter("city");
			
			String insert = "INSERT INTO airport(port_id, city)" + "VALUES (?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps = con.prepareStatement(insert);
			
			ps.setString(1, portid);
			ps.setString(2, city);
			ps.executeUpdate();
			
			out.println("");
			out.print("Airport Added Successfully");
		}
		
		else if (entity.equals("flight"))
		{
			String flightnum = request.getParameter("flightnum");
			String registration = request.getParameter("registration");
			String fromport = request.getParameter("from");
			String toport = request.getParameter("to");
			String departure = request.getParameter("departure");
			String arrival = request.getParameter("arrival");
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery("SELECT line_id FROM aircraft WHERE reg_num = '" + registration + "'");
			result.first();
	
			String airline = result.getString("line_id");
			String type = request.getParameter("type");
			
			String ddatetime = departure.replace("T", " ") + ":00";
			
			String adatetime = arrival.replace("T", " ") + ":00";
			
			String insert1 = "INSERT INTO flight(line_id, flight_num, from_id, to_id)" +
					"VALUES (?, ?, ?, ?)";
	
			String insert = "INSERT INTO scheduled_flight(line_id, flight_num, reg_num, departure, arrival, from_id, to_id)" 
							+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
					
			
			
				PreparedStatement ps = con.prepareStatement(insert1);
				ps = con.prepareStatement(insert1);
				
				ps.setString(1, airline);
				ps.setString(2, flightnum);
				ps.setString(3, fromport);
				ps.setString(4, toport);
				
				
				ps.executeUpdate();
			
			
			PreparedStatement ps1 = con.prepareStatement(insert);
			ps1 = con.prepareStatement(insert);
			
			ps1.setString(1, airline);
			ps1.setString(2, flightnum);
			ps1.setString(3, registration);
			ps1.setTimestamp(4, Timestamp.valueOf(ddatetime));
			ps1.setTimestamp(5, Timestamp.valueOf(adatetime));
			ps1.setString(6, fromport);
			ps1.setString(7, toport);
			
			ps1.executeUpdate();
		
			
			out.println("");
			out.print("Flight Added Successfully");

		}
		else if(entity.equals("airline"))
		{
			String lineid = request.getParameter("lineid");
			out.println(lineid);
			
			String insert = "INSERT INTO airline(line_id)" + "VALUES (?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps = con.prepareStatement(insert);
			
			ps.setString(1, lineid);
			
			ps.executeUpdate();
			
			out.println("");
			out.print("Airline Added Successfully");
		}
		
		con.close();
		
		
		
		


		
	} catch (Exception ex) {
		out.print(ex);
		out.println("insert failed");
	}
%>
	<br>
	<a href = "http://localhost:8080/cs336Sample/RepHome.jsp"> Customer Representative Home Page</a>

	</body>
</html>