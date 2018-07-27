<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="writers.HtmlWriter" %>
<%@ page import="database.MySqlConnection" %>
<%@ page import="java.io.Console" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

<%
  
  // set SQL variables
  ResultSet queryResult = null;
  Connection conn = null;
  Statement stmt = null; 
  
  try{
	  
	  // Grab the variables from the form.
	  String userName = request.getParameter("userName");
	  String userId = request.getParameter("userId");
	  String password = request.getParameter("password");
	  
	  // Initialize SQL connection
	  conn = MySqlConnection.getConnection();
	  stmt = conn.createStatement();
	  
	  String query = "SELECT name FROM user WHERE id='"+ userId + "';";
	  
	  queryResult = stmt.executeQuery(query);
	  
	  // Return to sign in page and display an error if an existing user with the 
	  // given id exists in the database
	  if (queryResult.next()){
	      if (stmt != null) stmt.close();
	      if (queryResult != null) queryResult.close();
	      if (conn != null) conn.close();
	      response.sendRedirect("signup.jsp?fail=1");
	  }
	  
	  query = "INSERT INTO user(id,name,password) VALUES ('" + userId + "','" + userName + "','" + password + "');";
	  
	  queryResult = stmt.executeQuery(query);
	  
	  response.sendRedirect("loginscreen.jsp");
	  
  } catch (ClassNotFoundException cnfe) {
	  response.sendRedirect("error.jsp");
  } catch (SQLException se) {
	  response.sendRedirect("error.jsp");
  } finally {
	  if (stmt != null) stmt.close();
      if (queryResult != null) queryResult.close();
      if (conn != null) conn.close();
  }
%>

</body>
</html>