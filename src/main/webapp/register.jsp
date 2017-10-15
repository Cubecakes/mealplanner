<%@ page import="java.util.Calendar" %>
<%@ page import="unsw.comp4920.project.ControllerActions" %>
<%@ page import="unsw.comp4920.project.Controller" %><%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 24/09/2017
  Time: 7:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
</head>
<body>

<div class="form-style-8">
    <h2>Join MealPlanner today</h2>
    <%
        if(request.getAttribute("register_error_info")!=null){
            out.println("<p style='color:red'>"+request.getAttribute("register_error_info")+"</p>");
        }
    %>
    <form action="./control" method="post">
        <input type="text" name="register_username" placeholder="Username" />
        <input type="password" name="register_password" placeholder="Password" />
        <input type="email" name="register_email" placeholder="Email">
        <input type="radio" name="register_gender" value="M"> Male
        <input type="radio" name="register_gender" value="F"> Female
        <br><br>
       <%-- Date of Birth
        <select name="register_dob_year">
            <%
                Calendar now = Calendar.getInstance();   // Gets the current date and time
                int year = now.get(Calendar.YEAR);
                for(int i=1900;i<=year;i++){
                    out.println("<option>"+i+"</option>");
                }
            %>
        </select>
        <select name="register_dob_month">
            <%
                for(int i=1;i<=12;i++){
                    out.println("<option>"+i+"</option>");
                }
            %>
        </select>
        <select name="register_dob_day">
            <%
                for(int i=1;i<=31;i++){
                    out.println("<option>"+i+"</option>");
                }
            %>
        </select>
        <br><br--%>
        <label for="register_photo">Upload profile photo</label>
        <input type="file" id="register_photo" name="register_photo">
        <br><br>
        <input type="hidden" name="action" value="<%=ControllerActions.CHECK_REGISTER%>">
        <input type="submit" value="Sign up">
        <br><br>
        <a href="./control?Action=<%=ControllerActions.GOTO_LOGIN%>" class="commonHyperLink">have an account?</a>
    </form>
</div>
</body>
</html>
