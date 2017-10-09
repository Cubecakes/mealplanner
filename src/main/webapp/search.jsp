<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 10/10/2017
  Time: 10:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search</title>
</head>
<body>
<%@ include file="header.html" %>
<center><form>
    <input type="hidden" name="action" value="search_submit">
    <input type="text" name="search" placeholder="Search for recipes">
    <input type="submit" name="search_submit" value="Search!">
</form></center>
</body>
</html>
