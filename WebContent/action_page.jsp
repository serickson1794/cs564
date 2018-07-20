<html>
<body>

<%

// Grab the variables from the form.
  String name = request.getParameter("name");
  String userName = request.getParameter("userName");
  String password = request.getParameter("password");
  String passwordConfirm = request.getParameter("passwordConfirm");
%>
<%-- Print out the variables. --%>
<h1><%=name%> <%=userName%></h1>
<%=password%>
<%=passwordConfirm%>

</body>
</html>