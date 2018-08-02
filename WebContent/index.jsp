<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="writers.HtmlWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Business Reviews</title>
<link rel="stylesheet" type="text/css" href="stylesheets/main.css" />
</head>
<body>
<div class="header">
	<div class="headerTitle">
		<span class="headerTitleLeft">business</span>
		<span class="headerTitleRight">reviews</span>
	</div>
	<div class="logoutLink">
	</div>
</div>
<div class="body">
	<div class="pageTitle">
		<h1>Log In</h1>
	</div>
    <form method="post" action="loginaction.jsp">
    	<input type="text" name="username" placeholder="Username" required="required" />
        <input type="password" name="password" placeholder="Password" required="required" />
        <input type="submit" value="Log in" />
   		<div class="signUpLink">
   			<a href="signup.jsp">Don't have an account?</a>
   		</div>
    	<%
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
    		if (username != null)
    			response.sendRedirect("home.jsp");

    		if (request.getParameter("error") != null && request.getParameter("error").equals("1")) {
    			HtmlWriter htmlWriter = new HtmlWriter(out);
    			htmlWriter.printOpenTag("span", "error");
    			htmlWriter.println("Invalid username and password combination.");
    			htmlWriter.printCloseTag("span");
    		}
    	%>
    </form>
    </div>
</body>
</html>