<html>
<body>

<%

// Grab the variables from the form.
  String name = request.getParameter("fullname");
  String userName = request.getParameter("username");
  String password = request.getParameter("password1");
  String passwordConfirm = request.getParameter("password2");
%>
<%-- Print out the variables. --%>
<h1><%=name%> <%=userName%></h1>
<%=password%>
<%=passwordConfirm%>

</body>
</html>