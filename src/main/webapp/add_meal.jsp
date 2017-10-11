
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
    <title>Add meal plan</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
</head>
<body>
<%
    User user = (User)request.getSession().getAttribute("currentUser");
    String meal = request.getParameter("meal");
    String date = request.getParameter("date");
    out.println("User : " + user.getUsername());
    out.println("Meal is " + meal + " on date " +date);
%>

<div class="form-style-8">
    <h2>Add to your meal plan</h2>
    <input type="text" name="add_food" placeholder="eg. Lasagne">
    <input type="hidden" name="meal_type" value="<%=meal%>">
    <input type="hidden" name="plan_date" value="<%=date%>">
    <a href="/home?action=add_meal" class="button_sign_up">Add</a>
    <br><br>
    <a href="/home?action=save_plan" class="button_sign_up">Save</a>
</div>

</body>
</html>
