<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 27/09/2017
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign in</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
</head>
<body>
<div class="form-style-8">
    <h2>Login to your account</h2>
    <%
        if(request.getAttribute("error_info")!=null){
            out.println("<p style='color:red'>"+request.getAttribute("error_info")+"</p>");
        }
    %>
    <form action="/control" method="post">
        <input type="text" name="username" placeholder="Username" />
        <input type="password" name="password" placeholder="Password" />
        <input type="hidden" name="action" value="check_login">
        <input type="submit" value="Log in" />
        <br><br>
        <a href="/control?action=forget_password" class="commonHyperLink">Forget password?</a>
        <a href="/register.jsp" class="commonHyperLink">New to MealPlanner?</a>
    </form>
</div>
</body>
</html>
