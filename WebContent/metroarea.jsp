<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
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
	ResultSet metroArea = null;
	ResultSet postalCodes = null;
	try {
		conn = MySqlConnection.getConnection();
		stmt = conn.createStatement();
		
		String metroAreaId = request.getParameter("id");
		String query = "SELECT name from metro_area WHERE id = " + metroAreaId;
		metroArea = stmt.executeQuery(query);
		metroArea.first();
		String metroAreaName = metroArea.getString("name");
		
		HtmlWriter htmlWriter = new HtmlWriter(out);
		htmlWriter.printOpenTag("h1");
		htmlWriter.println(metroAreaName);
		htmlWriter.printCloseTag("h1");
		
		htmlWriter.printOpenTag("h2");
		htmlWriter.println("Postal Codes");
		htmlWriter.printCloseTag("h2");
		query = "SELECT postal_code FROM postal_code WHERE metro_area_id = " + metroAreaId;
		postalCodes = stmt.executeQuery(query);
		while (postalCodes.next()) {
			htmlWriter.println(postalCodes.getString("postal_code"));
		}
	} catch (ClassNotFoundException cnfe) {
		response.sendRedirect("error.jsp");
	} catch (SQLException se) {
		response.sendRedirect("error.jsp");
	} finally {
		if (postalCodes != null) postalCodes.close();
		if (metroArea != null) metroArea.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}
	%>
</div>
</body>
</html>