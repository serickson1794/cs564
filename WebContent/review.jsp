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
	    <div class="pageTitle">
			<h1>Reviews</h1>
		</div>
	    <div class="leftPane">
	    	<div class="columnContainer">
		    	<div class="columnTitle">
		    		<h2>Information</h2>
		    	</div>
		    	<div class="columnCard">
		    	<div class="cardDetailLeft">
		    		<div class="cardDetailRow">
		    			<span class="businessName">The Old Fashioned</span>
		    		</div>
		    		<div class="cardDetailRow">
		    			23 N Pinckney St 
		    			<br>
		    			Madison, WI 53703
		    		</div>
		    	</div>
		    	<div class="cardDetailRight">
		    		<div class = "cardDetailRow">
		 		   		<img src="images/star.jpg" width="20 px" height="20px">
		    			<img src="images/star.jpg" width="20 px" height="20px">
		    			<img src="images/star.jpg" width="20 px" height="20px">
		    			<img src="images/star.jpg" width="20 px" height="20px">
		    			<img src="images/star.jpg" width="20 px" height="20px">
		    			<br>
		    			588 reviews
		    		</div>
		    	</div>
	    		<%-- <%
				Connection conn = null;
				Statement stmt = null;
				ResultSet metroArea = null;
				ResultSet businesses = null;
				ResultSet category = null;
				try {
					conn = MySqlConnection.getConnection();
					stmt = conn.createStatement();
					
					//need to tie business link in metro area page to set bid parameter
					String metroAreaId = request.getParameter("bid");
					
					//display business card 
					
					
					//display other user reviews
					
					String query = "SELECT name from metro_area WHERE id = " + metroAreaId;
					Business = stmt.executeQuery(query);
					String metroAreaName = "";
					if (metroArea.first()) metroAreaName = metroArea.getString("name");
					
					HtmlWriter htmlWriter = new HtmlWriter(out);
					htmlWriter.printOpenTag("div", "pageTitle");
					htmlWriter.printOpenTag("h1");
					htmlWriter.println(metroAreaName);
					htmlWriter.printCloseTag("h1");
					htmlWriter.printCloseTag("div");
					
					htmlWriter.printOpenTag("div", "columnContainer");
					for (int col = 1; col <= 3; col++) {
						query = "SELECT category FROM category WHERE id = " + col + ";"; // 1 = restaurants, 2 = apartments, 3 = car dealers
						category = stmt.executeQuery(query);
						String categoryName = "";
						if (category.first()) categoryName = category.getString("category");
						
						if (col == 1) htmlWriter.printOpenTag("div", "column leftColumn");
						else if (col == 2) htmlWriter.printOpenTag("div", "column centerColumn");
						else if (col == 3) htmlWriter.printOpenTag("div", "column rightColumn");
						htmlWriter.printOpenTag("div", "columnTitle");
						htmlWriter.printOpenTag("h2");
						htmlWriter.print(categoryName);
						htmlWriter.printCloseTag("h2");
						htmlWriter.printCloseTag("div");
						query = "SELECT business.id, business.name, business.address, business.city, business.state, business.postal_code, "
									+ "COUNT(review.id) AS review_count, AVG(review.stars) AS review_stars"
								+ " FROM business"
								+ " INNER JOIN postal_code ON business.postal_code = postal_code.postal_code"
								+ " INNER JOIN review ON business.id = review.business_id"
								+ " WHERE postal_code.metro_area_id = " + metroAreaId
									+ " AND business.category_id = " + col
									+ " AND business.is_open = 1"
								+ " GROUP BY business.id, review.stars"
								+ " ORDER BY review_stars DESC, review_count DESC"
								+ " LIMIT 5;";
						businesses = stmt.executeQuery(query);
						while (businesses.next()) {
							htmlWriter.printOpenTag("div", "columnCard");
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
							int scale = (int) Math.pow(10, 1);
							Double stars = businesses.getDouble("review_stars");
							while (stars > 0) {
								stars = (double) Math.round(stars * scale) / scale;
								if (stars <= 0.2) {
									
								} else if (stars <= 0.7) {
									htmlWriter.printImage("images/halfstar.jpg", "20px", "20px");
								} else {
									htmlWriter.printImage("images/star.jpg", "20px", "20px");
								}
								stars = stars - 1.0;
							}
							htmlWriter.printBreak();
							htmlWriter.println(businesses.getString("review_count") + " reviews");
							htmlWriter.printCloseTag("div");
							
							htmlWriter.printCloseTag("div");
							htmlWriter.printCloseTag("div");
						}
						htmlWriter.printCloseTag("div");
					}
					htmlWriter.printCloseTag("div");
					
					htmlWriter.printOpenTag("div", "columnContainer");
					for (int col = 1; col <= 3; col++) {
						if (col == 1) htmlWriter.printOpenTag("div", "column leftColumn");
						else if (col == 2) htmlWriter.printOpenTag("div", "column centerColumn");
						else if (col == 3) htmlWriter.printOpenTag("div", "column rightColumn");
						htmlWriter.printOpenTag("div", "columnCard");
						htmlWriter.printOpenTag("div", "cardDetailLeft");
						htmlWriter.printOpenTag("div", "cardDetailRowCentered");
						htmlWriter.printOpenLink("metrocatarea.jsp?id=" + metroAreaId + "&category=" + col);
						htmlWriter.println("View All");
						htmlWriter.printCloseLink();
						htmlWriter.printCloseTag("div");
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
				%> --%>
    		</div>
    			<div class="columnTitle">
    				<h2>Reviews</h2>
    			</div>
    			<div class="columnCard">
    				<div class="cardDetailLeft">
    					<div class="cardDetailRow">
    						<span class="businessName">Melinda</span>
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
    			</div>
    		</div>
    	</div>
    	<div class="rightPane">
    		<form>
    			<div class="rating">
					<input id=star5 type="radio" name="rating" value="5">
					<label for=star5></label>
					<input id=star4 type="radio" name="rating" value="4"/>
					<label for=star4></label>
					<input id=star3 type="radio" name="rating" value="3"/>
					<label for=star3></label>
					<input id=star2 type="radio" name="rating" value="2"/>
					<label for=star2></label>
					<input id=star1 type="radio" name="rating" value="1"/>
					<label for=star1></label>	
				</div>
				<textarea id="review" name="review" placeholder="Enter your review here." style="height:200px"></textarea>
				<input type="submit" value="Submit">
    		</form>
    	</div>
    </div>
</body>
</html>