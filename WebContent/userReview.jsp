<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
<%@ page import="database.MySqlConnection" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <title>Business Reviews</title>
    <link rel="stylesheet" href="stylesheets/main.css" type="text/css" media="all" />
</head>
<body>
	<div class="header linkDiv" onclick="window.location='home.jsp'">
		<div class="headerTitle">
			<span class="headerTitleLeft">business</span>
			<span class="headerTitleRight">reviews</span>
		</div>	
		<%
		String username = null;
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("businessReviewsUsername")) {
				username = cookie.getValue();
				break;
			}
		}
		
		if(username == null) response.sendRedirect("index.jsp");
		%>
		<div class="logoutLink">
			<a href="userReview.jsp">My Reviews</a>
		</div>
		<div class="logoutLink">
			<a href="logoutaction.jsp">Logout</a>
		</div>
	</div>
	<div class="body">
		<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet user = null;
		ResultSet businesses = null;
		try {
			
			conn = MySqlConnection.getConnection();
			stmt = conn.createStatement();
			String query ="SELECT name FROM user WHERE id = '" + username + "';";
			user = stmt.executeQuery(query);
			
			if (!user.first()) response.sendRedirect("index.jsp"); 
			
			HtmlWriter htmlWriter = new HtmlWriter(out);
			htmlWriter.printOpenTag("div", "pageTitle");
			htmlWriter.printOpenTag("h1");
			htmlWriter.println(user.getString("name") + "'s Reviews");
			htmlWriter.printCloseTag("h1");
			htmlWriter.printCloseTag("div");

			query = "SELECT business.id, business.name, business.address, business.city, business.state, business.postal_code, "
					+ "review.stars, review.text "
					+ "FROM business "
					+ "INNER JOIN postal_code ON business.postal_code = postal_code.postal_code "
					+ "INNER JOIN review ON business.id=review.business_id "
					+ "WHERE review.user_id='" + username + "';";

			businesses = stmt.executeQuery(query);
			while (businesses.next()) {
				htmlWriter.printOpenTag("div", "columnCardWrapper");
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
				htmlWriter.printStars(businesses.getDouble("stars"));
				htmlWriter.printCloseTag("div");
				
				htmlWriter.printCloseTag("div");
				htmlWriter.printCloseTag("div");
				htmlWriter.printLinkDiv("columnCard", "business.jsp?id=" + businesses.getString("id"));
				htmlWriter.printOpenTag("div", "cardDetailRow");
				htmlWriter.println(businesses.getString("text"));
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
			if (businesses != null) businesses.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
    	%>
	</div>
</body>
</html>