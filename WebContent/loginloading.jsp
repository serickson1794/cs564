<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
<%@ page import="database.MySqlConnection" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Loading</title>
</head>
<body>
	<%
	ResultSet nameQuery = null;
	Statement stmt = null;
	Connection conn = null;
	try{
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	conn = MySqlConnection.getConnection();
	stmt = conn.createStatement();
	
	String query = "SELECT u.name FROM user u WHERE u.id='"+id+"' and u.password = '"+pw+"';";
	nameQuery = stmt.executeQuery(query);
	if (!nameQuery.next()){
		if (stmt != null) stmt.close();
		if (nameQuery != null) nameQuery.close();
		if (conn != null) conn.close();
		response.sendRedirect("loginscreen.jsp?fail=1");
	}
	String name = nameQuery.getString("name");
	//TODO make cookie here
	
	response.sendRedirect("index.jsp");
	} catch (Exception se) {
		//response.sendRedirect("error.jsp");
		out.print(se.getMessage());
	} finally {
		if (stmt != null) stmt.close();
		if (nameQuery != null) nameQuery.close();
		if (conn != null) conn.close();
	}
	%>
</body>
</html>