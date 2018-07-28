<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="database.MySqlConnection" %>
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
	Connection conn = null;
	Statement stmt = null;
	ResultSet user = null;
	
	try {
		conn = MySqlConnection.getConnection();
		stmt = conn.createStatement();
		String username = request.getParameter("username");
		user = stmt.executeQuery("SELECT id FROM user WHERE id = '" + username + "';");
		if (user.first()) {
			if (user != null) user.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
			response.sendRedirect("signup.jsp?error=1");
		} else {
			String fullName = request.getParameter("fullname");
			String password = request.getParameter("password");
			
			String insert = "INSERT INTO user(id, name, password) "
				+ "VALUES ('" + username + "', '" + fullName + "', '" + password + "');";
				
			stmt.executeUpdate(insert);
				
			response.sendRedirect("index.jsp");
		}
	} catch (ClassNotFoundException cnfe) {
		response.sendRedirect("error.jsp");
	} catch (SQLException se) {
		response.sendRedirect("error.jsp");
	} finally {
		if (user != null) user.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}
	%>
</div>
</body>
</html>