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
	ResultSet businesses = null;
	ResultSet category = null;
	try {
		conn = MySqlConnection.getConnection();
		stmt = conn.createStatement();
		
		String metroAreaId = request.getParameter("id");
		String query = "SELECT name from metro_area WHERE id = " + metroAreaId;
		metroArea = stmt.executeQuery(query);
		String metroAreaName = "";
		if (metroArea.first()) metroAreaName = metroArea.getString("name");
		
		String categoryId = request.getParameter("category");
		query = "SELECT category FROM category WHERE id = " + categoryId + ";"; // 1 = restaurants, 2 = apartments, 3 = car dealers
		category = stmt.executeQuery(query);
		String categoryName = "";
		if (category.first()) categoryName = category.getString("category");
		
		HtmlWriter htmlWriter = new HtmlWriter(out);
		htmlWriter.printOpenTag("div", "pageTitle");
		htmlWriter.printOpenTag("h1");
		htmlWriter.println(metroAreaName);
		htmlWriter.printCloseTag("h1");
		htmlWriter.printCloseTag("div");
		
			
			htmlWriter.printOpenTag("div");
			htmlWriter.printOpenTag("div", "columnTitle");
			htmlWriter.printOpenTag("h2");
			htmlWriter.print(categoryName);
			htmlWriter.printCloseTag("h2");
			htmlWriter.printCloseTag("div");
			query = "SELECT business.id, business.name, business.address, business.city, business.state, business.postal_code, "
						+ "COUNT(*) AS review_count, AVG(review.stars) AS review_stars"
					+ " FROM business"
					+ " INNER JOIN postal_code ON business.postal_code = postal_code.postal_code"
					+ " INNER JOIN review ON business.id = review.business_id"
					+ " WHERE postal_code.metro_area_id = " + metroAreaId
						+ " AND business.category_id = " + categoryId
						+ " AND business.is_open = 1"
					+ " GROUP BY business.id"
					+ " ORDER BY review_stars DESC, review_count DESC"
					+ " LIMIT 1000;";
			businesses = stmt.executeQuery(query);
			while (businesses.next()) {
				htmlWriter.printLinkDiv("columnCard", "business.jsp?id=" + businesses.getString("id"));
				htmlWriter.printOpenTag("div", "cardDetailLeft");
				
				htmlWriter.printOpenTag("div", "cardDetailRow");
				htmlWriter.printOpenTag("span", "businessName");
				htmlWriter.println(businesses.getString("name"));
				htmlWriter.printCloseTag("span");
				htmlWriter.printCloseTag("div");
				
				htmlWriter.printOpenTag("div", "cardDetailRow");
				htmlWriter.println(businesses.getString("address"));
				htmlWriter.printBreak();
				htmlWriter.println(businesses.getString("city") + ",");
				htmlWriter.println(businesses.getString("state"));
				htmlWriter.println(businesses.getString("postal_code"));
				htmlWriter.printCloseTag("div");
				
				htmlWriter.printCloseTag("div");
				htmlWriter.printOpenTag("div", "cardDetailRight");
				
				htmlWriter.printOpenTag("div", "cardDetailRow");
				// round to 1 decimal place
				htmlWriter.printStars(businesses.getDouble("review_stars"));
				htmlWriter.printBreak();
				htmlWriter.println(businesses.getString("review_count") + " reviews");
				htmlWriter.printCloseTag("div");
				
				htmlWriter.printCloseTag("div");
				htmlWriter.printCloseTag("div");
			}
		htmlWriter.printCloseTag("div");
	} catch (ClassNotFoundException cnfe) {
		response.sendRedirect("error.jsp");
	} catch (SQLException se) {
		response.sendRedirect("error.jsp");
	} finally {
		if (category != null) category.close();
		if (businesses != null) businesses.close();
		if (metroArea != null) metroArea.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}
	%>
</div>
</body>
</html>