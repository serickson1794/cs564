<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
<%@ page import="database.MySqlConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Sign up</title>
    <link rel="stylesheet" href="stylesheets/main.css" type="text/css" media="all" />
</head>
<body>
    	<form action="action_page.jsp" class="login" method="post">
        	<div id="body">
            	<!--content-->
            	<h1 id="title"> Sign Up for Help </h1>
            	<input name="name" placeholder="Name" required="required" type="text" /><br />
            	<input name="userName" placeholder="User Name" required="required" type="text" /><br />
            	<input name="password" placeholder="Password" required="required" type="password" /><br />
            	<input name="passwordConfirm" placeholder="Confirm Password" required="required" type="password" /> <br />
            	<button name="signupButton" type="submit" value="Sign Up"> <span>Sign Up</span> </button>
            </div>
    	</form>
    <footer>
        <!--footer-->
        Copyright &copy;2018 Help Inc.
    </footer>
    
    <!--check if username taken; if so jump back to signup.jsp-->
  
    <!--check that password and passwordConfirm are the same; if not jump back to signup.jsp-->
    
    
</body>
</html>