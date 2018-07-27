<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
<%@ page import="database.MySqlConnection" %>
<%
    if(null!=request.getAttribute("errorMessage"))
    {
    	out.println(request.getAttribute("errorMessage"));
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Sign up</title>
    <link rel="stylesheet" href="stylesheets/main.css" type="text/css" media="all" />
</head>
<body>
    	<%
    	if (request.getParameter("fail") != null){
            	HtmlWriter htmlWriter = new HtmlWriter(out);
            	htmlWriter.printOpenTag("div", "failState");
    			htmlWriter.printOpenTag("h2");
    			htmlWriter.print("User id already taken. Please select a unique user id.");
    			htmlWriter.printCloseTag("h2");
    			htmlWriter.printCloseTag("div");	
        }%>
    	<form action="signup_loading.jsp" class="login" method="post">
        	<div id="body">
            	<!--content-->
            	<h1 id="title"> Sign Up for Help </h1>
            	<input name="userName" placeholder="User name" required="required" type="text" /><br />
            	<input name="userId" placeholder="User ID" required="required" type="text" /><br />
            	<input name="password" placeholder="Password" required="required" type="password" /><br />
            	<input name="passwordConfirm" placeholder="Confirm Password" required="required" type="password" /> <br />
            	<button name="signupButton" type="submit" value="Sign Up"> <span>Sign Up</span> </button>
            </div>
    	</form>
    <footer>
        <!--footer-->
        Copyright &copy;2018 Help Inc.
    </footer>
    
    <!--check that password and passwordConfirm are the same; if not jump back to signup.jsp-->
    
</body>
</html>