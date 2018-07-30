<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="writers.HtmlWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Business Reviews</title>

<link rel="stylesheet" type="text/css" href="stylesheets/main.css" />

<script>
function validatePassword() {
	if (document.getElementById("password1").value != document.getElementById("password2").value) {
		document.getElementById("error").innerHTML = "Passwords do not match.";
		return false;
	} else {
		document.getElementById("error").innerHTML = "";
		return true;
	}
}
</script>
</head>
<body>
<div class="header">
	<span class="headerTitleLeft">business</span>
	<span class="headerTitleRight">reviews</span>
</div>
<div class="body">
	<div class="pageTitle">
		<h1>Create Account</h1>
	</div>
	<form method="post" action="signupaction.jsp" onsubmit="return validatePassword();">
		<input type="text" name="fullname" placeholder="Full name" required="required" />
		<input type="text" name="username" placeholder="Username" required="required" />
		<input type="password" id="password1" name="password" placeholder="Password" required="required" />
		<input type="password" id="password2" placeholder="Confirm password" required="required" />
		<input type="submit" value="Sign up" />
		<span id="error" class="error">
		<%
		String username = null;
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("businessReviewsUsername")) {
				username = cookie.getValue();
				break;
			}
		}
		if (username != null) response.sendRedirect("home.jsp");
		
		if (request.getParameter("error") != null && request.getParameter("error").equals("1")) {
			HtmlWriter htmlWriter = new HtmlWriter(out);
			htmlWriter.println("An account with that username already exists.");
		}
		%>
		</span>
	</form>
</div>
</body>
</html>