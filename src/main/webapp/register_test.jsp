<%@ page import="unsw.comp4920.project.User" %><%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 26/09/2017
  Time: 9:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>register test</title>
</head>
<body>
<%@ include file="header.html" %>
<%
    User user = (User)request.getAttribute("currentUser");
    out.println("<h1>Username:"+user.getUsername()+"</h1>");
    out.println("<h1>Password:"+user.getPassword()+"</h1>");
%>
</body>
</html>
