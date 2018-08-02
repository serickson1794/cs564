<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Business Reviews</title>
</head>
<body>
	<%
		Cookie usernameCookie = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("businessReviewsUsername")) {
					usernameCookie = cookie;
					break;
				}
			}
		}
		if (usernameCookie != null) {
			usernameCookie.setMaxAge(0);
			response.addCookie(usernameCookie);
		}

		response.sendRedirect("index.jsp");
	%>
</body>
</html>