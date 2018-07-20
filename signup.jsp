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
    <form action="action_page.jsp" method="get">
        <div id="body">
            <!--content-->
            <h1 id="title"> Sign Up for Help </h1>
            <input id="name" placeholder="Name" required="required" type="text" /><br />
            <input id="userName" placeholder="User Name" required="required" type="text" /><br />
            <input id="password" placeholder="Password" required="required" type="password" /><br />
            <input id="passwordConfirm" placeholder="Confirm Password" required="required" type="password" /> <br />
            <button id="signupButton" type="submit" value="Sign Up"> <span>Sign Up</span> </button>
        </div>
    </form>
    <footer>
        <!--footer-->
        Copyright &copy;2018 Help Inc.
    </footer>
</body>
</html>