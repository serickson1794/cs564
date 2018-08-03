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
    
    <script type="text/javascript">
    
    function setDate() {
    	var dateStr = "";
    	var today = new Date();
    	
    	var year = today.getFullYear();
    	dateStr += year;
    	
    	dateStr += "-";
    	var month = today.getMonth() + 1;
    	if (month < 10) dateStr += "0";
    	dateStr += month;
    	
    	dateStr += "-";
    	var day = today.getDate();
    	if (day < 10) dateStr += "0";
    	dateStr += day;
    	
    	dateStr += " 00:00:00";
    	document.getElementById('date').value = dateStr;
    }
    
    </script>
</head>
<body onload="setDate();">
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
		ResultSet business = null;
		ResultSet reviews = null;
		ResultSet usersreview = null;
		try {
			String businessId = request.getParameter("id");
			if (businessId == null)
				response.sendRedirect("home.jsp");

			conn = MySqlConnection.getConnection();
			stmt = conn.createStatement();
			String query = "SELECT business.id, business.name, business.address, business.city, business.state, business.postal_code, "
					+ "COUNT(*) AS review_count, AVG(review.stars) AS review_stars" + " FROM business"
					+ " INNER JOIN review ON business.id = review.business_id" + " WHERE business.id = '"
					+ businessId + "';";
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

			query = "SELECT review.date, review.text, review.stars, user.name" + " FROM review"
					+ " INNER JOIN user ON review.user_id = user.id" + " WHERE review.business_id = '" + businessId
					+ "'" + " ORDER BY review.date DESC;";
			reviews = stmt.executeQuery(query);
			while (reviews.next()) {
				htmlWriter.printOpenTag("div", "columnCardWrapper");
				htmlWriter.printOpenTag("div", "columnCard");
				htmlWriter.printOpenTag("div", "cardDetailLeft");

				htmlWriter.printOpenTag("div", "cardDetailRow");
				htmlWriter.printOpenTag("span", "reviewUserName");
				htmlWriter.println(reviews.getString("name"));
				htmlWriter.printCloseTag("span");
				htmlWriter.printCloseTag("div");

				htmlWriter.printCloseTag("div");
				htmlWriter.printOpenTag("div", "cardDetailRight");

				htmlWriter.printOpenTag("div", "cardDetailRow");
				htmlWriter.printStars(reviews.getDouble("stars"));
				htmlWriter.printBreak();
				htmlWriter.printDate(reviews.getString("date"));
				htmlWriter.printCloseTag("div");

				htmlWriter.printCloseTag("div");
				htmlWriter.printCloseTag("div");

				htmlWriter.printOpenTag("div", "columnCard");

				htmlWriter.printOpenTag("div", "cardDetailRow");
				htmlWriter.println(reviews.getString("text"));
				htmlWriter.printCloseTag("div");

				htmlWriter.printCloseTag("div");
				htmlWriter.printCloseTag("div");
			}

			htmlWriter.printCloseTag("div");
			htmlWriter.printCloseTag("div");

			htmlWriter.printOpenTag("div", "rightPane");
			htmlWriter.printOpenForm("reviewaction.jsp?bid=" + businessId);

			query = "SELECT text, stars FROM review WHERE business_id = '" + businessId + "' AND user_id = '" + username + "';";
			usersreview = stmt.executeQuery(query);
			int userStar = 0;
			String userText = null;
			boolean userHasReview = usersreview.first();
			if (userHasReview) {
				userText = usersreview.getString("text");
				userStar = Integer.parseInt(usersreview.getString("stars"));
			}

			htmlWriter.printOpenTag("div", "rating");
			for (int i = 5; i > 0; i--) {
				String id = "star" + i;
				if (i != userStar) htmlWriter.printRadio(id, "rating", Integer.toString(i), false, true);
				else htmlWriter.printRadio(id, "rating", Integer.toString(i), true, true);
				htmlWriter.printOpenLabel(id);
				htmlWriter.printCloseTag("label");
			}
			htmlWriter.printCloseTag("div");

			htmlWriter.printOpenTextArea("reviewText", "text", "Write a review...", true);
			if (userText != null) {
				htmlWriter.println(userText);
			}
			htmlWriter.printCloseTag("textarea");
			htmlWriter.printHidden("date", "date");
			htmlWriter.printSubmit("submit", "Save", true);
			htmlWriter.printSubmit("submit", "Remove", userHasReview);
			htmlWriter.printCloseTag("form");

			htmlWriter.printCloseTag("div");
		} catch (ClassNotFoundException cnfe) {
			response.sendRedirect("error.jsp");
		} catch (SQLException se) {
			response.sendRedirect("error.jsp");
		} finally {
			if (reviews != null)
				reviews.close();
			if (business != null)
				business.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
	%>
    </div>
</body>
</html>