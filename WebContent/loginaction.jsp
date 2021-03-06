<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="database.MySqlConnection" %>
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
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			conn = MySqlConnection.getConnection();
			stmt = conn.createStatement();

			String query = "SELECT id FROM user WHERE id = '" + username + "' AND password = '" + password + "';";
			user = stmt.executeQuery(query);
			if (!user.first()) {
				redirectUrl = "index.jsp?error=1";
			} else {
				Cookie usernameCookie = new Cookie("businessReviewsUsername", username);
				usernameCookie.setMaxAge(-1);
				response.addCookie(usernameCookie);
				redirectUrl = "home.jsp";
			}
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