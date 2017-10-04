<%@ page import="unsw.comp4920.project.User" %>
<%@ page import="javax.servlet.*" %><%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 25/09/2017
  Time: 9:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
<%@ include file="header.html" %>

<%
    User user = (User)request.getAttribute("currentUser");
    out.println("<h1>"+user.getUsername()+"</h1>");
    request.setAttribute("currentUser",user);
%>

</body>
</html>
