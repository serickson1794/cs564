<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="database.MySqlConnection" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Business Reviews</title>
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet user = null;
		String redirectUrl = null;
		try {
			String username = null;
    		Cookie[] cookies = request.getCookies();
    		if (cookies != null) {
    			for (Cookie cookie : cookies) {
    				if (cookie.getName().equals("businessReviewsUsername")) {
    					username = cookie.getValue();
    					break;
    				}
    			}
    		}
    		if (username == null) response.sendRedirect("index.jsp");
			
			conn = MySqlConnection.getConnection();
			stmt = conn.createStatement();
			
			String businessId = request.getParameter("bid");
			String submitType = request.getParameter("submit");
			if (submitType.equals("Save")) {
				Date today = new Date();
				
				int month = today.getMonth();
				String monthStr;
				if (month < 10) monthStr = "0" + month;
				else monthStr = Integer.toString(month);
				
				int date = today.getDate();
				String dateStr;
				if (date < 10) dateStr = "0" + date;
				else dateStr = Integer.toString(date);
				
				String now = (today.getYear() + 1900) + "-" + monthStr + "-" + dateStr + " 00:00:00";
				String stars = request.getParameter("rating");
				String reviewText = request.getParameter("text");
				
				String update = "INSERT INTO review(business_id, user_id, stars, date, text)"
						+ " VALUES ('" + businessId + "', '" + username + "', '" + stars + "', '" + now + "', '" + reviewText + "')"
						+ " ON DUPLICATE KEY UPDATE stars = '" + stars + "', date = '" + now + "', text = '" + reviewText + "';"; 
						
				stmt.executeUpdate(update);
			} else if (submitType.equals("Remove")) {
				String update = "DELETE FROM review"
						+ " WHERE business_id = '" + businessId + "'"
						+ " AND user_id = '" + username + "';";
						
				stmt.executeUpdate(update);
			}
			redirectUrl = "business.jsp?id=" + businessId;
		} catch (SQLException se) {
			redirectUrl = "error.jsp";
		} finally {
			if (user != null) user.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
			if (redirectUrl != null) response.sendRedirect(redirectUrl);
		}
	%>
</body>
</html>