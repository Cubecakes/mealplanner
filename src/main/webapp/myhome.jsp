<%@ page import="unsw.comp4920.project.User" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="unsw.comp4920.project.CalendarDisplay" %>
<%--
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
    <link type="text/css" rel="stylesheet" href="login_register.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <style>
        .main {

            /*background-color: #ffffed;*/
            max-width:1300px;
            margin:auto;
            padding:90px;
            font-family: 'Montserrat', sans-serif;
        }
        .myHeader{
            text-align: center;
            font-size: 48px;
            letter-spacing: 2px;
            width: 480px;
            border-bottom: 2px solid #c3c3c3;
            padding: 20px;
            margin: 0 auto;
            margin-bottom: 20px;
            color: #2f383d;
        }

    </style>
</head>

<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%@ include file="header.html" %>
<div id="main" class="main">

    <%
        HttpSession s = request.getSession();
        Calendar cal = (Calendar) ((Calendar)s.getAttribute("currentDate")).clone();
        User user = (User)s.getAttribute("currentUser");
        out.println("<h1 class = 'myHeader'> Hello "+user.getUsername()+"!</h1>");
    %>

    <ul class="nav justify-content-center">
        <li class="nav-item " style="font-size: 24px">
            <a class="nav-link" href="./home?action=prev_week" title="prev_week" target="_self">Prev week</a>
        </li>

        <li class="nav-item " style="font-size: 24px">
            <a class="nav-link" href="./home?action=curr_week" title="curr_week" target="_self">Current week</a>
        </li>

        <li class="nav-item " style="font-size: 24px">
            <a class="nav-link" href="./home?action=next_week" title="next_week" target="_self">Next week</a>
        </li>
    </ul>

    <%= CalendarDisplay.printCalendar(cal,user)%>



</body>
</html>