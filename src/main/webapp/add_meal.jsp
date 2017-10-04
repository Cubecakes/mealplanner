
<%@ page import="unsw.comp4920.project.User" %>
<%--

  Created by IntelliJ IDEA.
  User: Darren
  Date: 04-Oct-17
  Time: 4:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    User user = (User)request.getSession().getAttribute("currentUser");
    String meal = request.getParameter("meal");
    String date = request.getParameter("date");
    out.println("User : " + user.getUsername());
    out.println("Meal is " + meal + " on date " +date);
%>

</body>
</html>
