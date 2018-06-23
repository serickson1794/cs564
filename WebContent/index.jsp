<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Business Reviews</title>

<link rel="stylesheet" type="text/css" href="stylesheets/main.css" />
</head>
<body>
<div class="header">
	<span class="headerTitleLeft">business</span>
	<span class="headerTitleRight">reviews</span>
</div>
<div class="body">
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url ="jdbc:mysql://yelpmysql.mysql.database.azure.com:3306/yelp_db?useSSL=true&requireSSL=false";
		Connection myDbConn = DriverManager.getConnection(url, "cs564@yelpmysql", "1979milkyway!");
	} catch (Exception e) {
		out.println("Could not connect to database. " + e.getMessage());
	}
	%>
	<div class="metroAreaCard">
		<div class="metroAreaCardTitle">
			Madison
		</div>
		<div class="metroAreaCardInner" style="background-image: url('http://images.midwestliving.mdpcdn.com/sites/midwestliving.com/files/styles/large/public/101170660_1w.jpg?itok=w6j2uzsd');">
			<a class="metroAreaLink" href="">
				
			</a>
		</div>
	</div>
	
	<div class="metroAreaCard">
		<div class="metroAreaCardTitle">
			Las Vegas
		</div>
		<div class="metroAreaCardInner" style="background-image: url('http://www.todayifoundout.com/wp-content/uploads/2014/07/las-vegas.jpg');">
			<a class="metroAreaLink" href="">
				
			</a>
		</div>
	</div>
</div>
</body>
</html>