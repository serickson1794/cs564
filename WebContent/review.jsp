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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="row">
    	<div class="column" style="background-color:#aaa;">
    			<p>hello</p>
    	</div>
    	<div class="column" style="background-color:#ccc;">
    		<form>
    			<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star"></span>
				<span class="fa fa-star"></span>
				<textarea id="review" name="review" placeholder="Enter your review here." style="height:200px"></textarea>
				<input type="submit" value="Submit">
    		</form>
    	</div>
    </div>
</body>
</html>