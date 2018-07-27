<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
<%@ page import="database.MySqlConnection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Screen</title>
<link rel="stylesheet" type="text/css" href="stylesheets/main.css" />
</head>
<body>
	<div class="header">
		<span class="headerTitleLeft">business</span>
		<span class="headerTitleRight">reviews</span>
    </div>
    <div class="body">

    <form class="login" action="loginloading.jsp" method="POST">
    	<%if (request.getParameter("fail")=="1"){
            	HtmlWriter htmlWriter = new HtmlWriter(out);
            	htmlWriter.printOpenTag("div", "failState");
    			htmlWriter.printOpenTag("h2");
    			htmlWriter.print("Login Failed");
    			htmlWriter.printCloseTag("h2");
    			htmlWriter.printCloseTag("div");	
        }%>
        <div id="body">
            <input id="id" name="id" placeholder="User Name" required="required" type="text" /><br />
            <input id="pw" name="pw" placeholder="Password" required="required" type="password" /><br />
            <button id="Log in" type="submit" value="Log in"> <span>Log in</span> </button>
        </div>
    <button onclick="window.location.href='signup.jsp'" > Sign up </button>
    </form>
    </div>
</body>
</html>