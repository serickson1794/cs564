<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
<%@ page import="database.MySqlConnection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
	ResultSet business = null;
	ResultSet reviews = null;
	try {
		String businessId = request.getParameter("id");
		
		conn = MySqlConnection.getConnection();
		stmt = conn.createStatement();
		String query = "SELECT business.id, business.name, business.address, business.city, business.state, business.postal_code, "
				+ "COUNT(*) AS review_count, AVG(review.stars) AS review_stars"
				+ " FROM business"
				+ " INNER JOIN review ON business.id = review.business_id"
				+ " WHERE business.id = '" + businessId + "';";
		business = stmt.executeQuery(query);
		business.first();
		
		HtmlWriter htmlWriter = new HtmlWriter(out);
		htmlWriter.printOpenTag("div", "pageTitle");
	    htmlWriter.printOpenTag("h1");
		htmlWriter.println(business.getString("name"));
		htmlWriter.printCloseTag("h1");
		htmlWriter.printCloseTag("div");
		
		htmlWriter.printOpenTag("div", "leftPane");
		htmlWriter.printOpenTag("div", "columnContainer");
		htmlWriter.printOpenTag("div", "columnTitle");
		htmlWriter.printOpenTag("h2");
		htmlWriter.println("Information");
		htmlWriter.printCloseTag("h2");
		htmlWriter.printCloseTag("div");
		
		htmlWriter.printOpenTag("div", "columnCard");
		htmlWriter.printOpenTag("div", "cardDetailLeft");
		
		htmlWriter.printOpenTag("div", "cardDetailRow");
		htmlWriter.printOpenTag("span", "businessName");
		htmlWriter.println(business.getString("name"));
		htmlWriter.printCloseTag("span");
		htmlWriter.printCloseTag("div");
		
		htmlWriter.printOpenTag("div", "cardDetailRow");
		htmlWriter.println(business.getString("address"));
		htmlWriter.printBreak();
		htmlWriter.println(business.getString("city") + ", ");
		htmlWriter.println(business.getString("state"));
		htmlWriter.println(business.getString("postal_code"));
		htmlWriter.printCloseTag("div");
		
		htmlWriter.printCloseTag("div");
		htmlWriter.printOpenTag("div", "cardDetailRight");
		
		htmlWriter.printOpenTag("div", "cardDetailRow");
		htmlWriter.printStars(business.getDouble("review_stars"));
		htmlWriter.printBreak();
		htmlWriter.println(business.getString("review_count") + " reviews");
		htmlWriter.printCloseTag("div");
		    				
		htmlWriter.printCloseTag("div");
		htmlWriter.printCloseTag("div");
		
		htmlWriter.printOpenTag("div", "columnTitle");
		htmlWriter.printOpenTag("h2");
		htmlWriter.println("Reviews");
		htmlWriter.printCloseTag("h2");
		htmlWriter.printCloseTag("div");
		
		query = "SELECT review.date, review.text, review.stars, user.name"
				+ " FROM review"
				+ " INNER JOIN user ON review.user_id = user.id"
				+ " WHERE review.business_id = '" + businessId + "'"
				+ " ORDER BY review.date DESC;";
		reviews = stmt.executeQuery(query);
		while (reviews.next()) {
			htmlWriter.printOpenTag("div", "columnCard");
   			htmlWriter.printOpenTag("div", "cardDetailLeft");
   		
    		htmlWriter.printOpenTag("div", "cardDetailRow");
    		htmlWriter.printOpenTag("span", "reviewUserName");
    		htmlWriter.println(reviews.getString("name"));
    		htmlWriter.printCloseTag("span");
    		htmlWriter.printCloseTag("div");
    		
    		htmlWriter.printOpenTag("div", "cardDetailRow");
    		htmlWriter.println(reviews.getString("text"));
    		htmlWriter.printCloseTag("div");
    		
    		htmlWriter.printCloseTag("div");
    		htmlWriter.printOpenTag("div", "cardDetailRight");
    		
    		htmlWriter.printOpenTag("div", "cardDetailRow");
    		htmlWriter.printStars(reviews.getDouble("stars"));
    		htmlWriter.printBreak();
    		htmlWriter.printDate(reviews.getString("date"));
    		htmlWriter.printCloseTag("div");
    		
    		htmlWriter.printOpenTag("div", "cardDetailRow");
    		htmlWriter.printCloseTag("div");
    		
    		htmlWriter.printCloseTag("div");
    		htmlWriter.printCloseTag("div");
		}
		
		htmlWriter.printCloseTag("div");
		htmlWriter.printCloseTag("div");
		
		htmlWriter.printOpenTag("div", "rightPane");
    	htmlWriter.printOpenTag("form");
    	
    	htmlWriter.printOpenTag("div", "rating");
    	for (int i = 5; i > 0; i--) {
    		String id = "star" + i;
    		htmlWriter.printRadio(id, "rating", Integer.toString(i));//Integer.toString((6 - i)));
    		htmlWriter.printOpenLabel(id);
    		htmlWriter.printCloseTag("label");
    	}	
		htmlWriter.printCloseTag("div");
		
		htmlWriter.printOpenTextArea("reviewText", "text", "Write a review...");
		htmlWriter.printCloseTag("textarea");
		htmlWriter.printSubmit("save", "Save");
		htmlWriter.printSubmit("remove", "Remove");
   		htmlWriter.printCloseTag("form");
   		
    	htmlWriter.printCloseTag("div");
	} catch (ClassNotFoundException cnfe) {
		response.sendRedirect("error.jsp");
	} catch (SQLException se) {
		response.sendRedirect("error.jsp");
	} finally {
		if (reviews != null) reviews.close();
		if (business != null) business.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}
    %>
    </div>
</body>
</html>