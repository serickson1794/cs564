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
	<div class="header">
		<span class="headerTitleLeft">business</span>
		<span class="headerTitleRight">reviews</span>
	</div>
	<div class="body">
		<%
		Connection conn = null;
		Statement stmt = null;
		/* ResultSet user = null; */
		ResultSet businesses = null;
		try {
			String username = null;
			/* Cookie[] cookies = request.getCookies();
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("businessReviewsUsername")) {
					username = cookie.getValue();
					break;
				}
			}
			
			if(username == null) response.sendRedirect("index.jsp");
			
			conn = MySqlConnection.getConnection();
			stmt = conn.createStatement();
			String query ="SELECT id FROM user WHERE id = '" + username + "';";
			user = stmt.executeQuery(query);
			
			if (!user.first()) response.sendRedirect("index.jsp"); */
			
			HtmlWriter htmlWriter = new HtmlWriter(out);
			htmlWriter.printOpenTag("div", "pageTitle");
			htmlWriter.printOpenTag("h1");
			htmlWriter.println(username + "'s Reviews");
			htmlWriter.printCloseTag("h1");
			htmlWriter.printCloseTag("div");
			
			conn = MySqlConnection.getConnection();
			stmt = conn.createStatement();
			String query = "SELECT business.id, business.name, business.address, business.city, business.state, business.postal_code, "
					+ "review.stars "
					+ "FROM business "
					+ "INNER JOIN postal_code ON business.postal_code = postal_code.postal_code "
					+ "INNER JOIN review ON business.id=review.business_id "
					+ "WHERE review.user_id='" + "-2tJ7A886B1OnuSwPXcFRQ" + "';";

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
			if (businesses != null) businesses.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
    	%>
<!-- 		<div class="columnCard">
			<div class="cardDetailLeft">
				<div class="cardDetailRow">
					<span class="businessName">The Old Fashioned</span>
				</div>
				<div class="cardDetailRow">
					<img src="images/star.jpg" width="20 px" height="20px">
					<img src="images/star.jpg" width="20 px" height="20px">
					<img src="images/star.jpg" width="20 px" height="20px">
					<img src="images/star.jpg" width="20 px" height="20px">
					<img src="images/star.jpg" width="20 px" height="20px">
				</div>
				<div class="cardDetailRow">
					Review text goes here. There may be quite a lot of text, so it is good to have a long sample hence all this typing I am doing. 
			
				</div>
			</div>
			<div class="cardDetailRight">
				<div class="cardDetailRow">
					7/29/2018
				</div>
			</div>
		</div> -->
	</div>
</body>
</html>