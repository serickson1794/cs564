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
	try {
		Connection conn = MySqlConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet metroAreas = stmt.executeQuery("SELECT * FROM metro_areas ORDER BY name");
		
		HtmlWriter htmlWriter = new HtmlWriter(out);
		while (metroAreas.next()) {
			String metroAreaId = metroAreas.getString("id");
			String metroAreaName = metroAreas.getString("name");
			String metroAreaImageUrl = metroAreas.getString("image_url");
			
			htmlWriter.printOpenTag("div", "metroAreaCard");
			htmlWriter.printOpenTag("div", "metroAreaCardTitle");
			htmlWriter.println(metroAreaName);
			htmlWriter.printCloseTag("div");
			String imageStyle = "background-image: url('" + metroAreaImageUrl + "');";
			htmlWriter.printOpenTag("div", "metroAreaCardInner", imageStyle);
			htmlWriter.printOpenLink("metroAreaLink", "metroarea.jsp?id=" + metroAreaId);
			htmlWriter.printCloseLink();
			htmlWriter.printCloseTag("div");
			htmlWriter.printCloseTag("div");
		}
		
		metroAreas.close();
		stmt.close();
		conn.close();
	} catch (ClassNotFoundException cnfe) {
		response.sendRedirect("error.jsp");
	} catch (SQLException se) {
		response.sendRedirect("error.jsp");
	}
	%>
</div>
</body>
</html>