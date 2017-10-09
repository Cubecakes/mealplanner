<%@ page import="java.util.Calendar" %>
<%@ page import="unsw.comp4920.project.User" %>
<%@ page import="unsw.comp4920.project.DatabaseOperation" %><%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 9/10/2017
  Time: 10:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Profile</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
</head>
<body>

<div class="form-style-8">
    <h2>Edit profile</h2>
    <%
        if(request.getAttribute("edit_error_info")!=null){
            out.println("<p style='color:red'>"+request.getAttribute("edit_error_info")+"</p>");
        }
    %>
    <form action="/home?action=edit_profile" method="post">
        Password: <input type="password" name="edit_password"/>
        Email: <input type="email" name="edit_email">
        <label for="edit_photo">Upload profile photo</label>
        <input type="file" id="edit_photo" name="edit_profile_photo">
        <br><br>
        <input type="hidden" name="action" value="edit_profile">
        <input type="submit" value="Save change">
    </form>
</div>
</body>
</html>
