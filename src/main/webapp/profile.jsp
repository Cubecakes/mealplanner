<%@ page import="unsw.comp4920.project.User" %><%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 27/09/2017
  Time: 4:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
    <style>
        a[class="button_edit"]{
            -moz-box-shadow: inset 0px 1px 0px 0px #AAB7B8;
            -webkit-box-shadow: inset 0px 1px 0px 0px #839192;
            box-shadow: inset 0px 1px 0px 0px #4D4D4D;
            background-color: #333333;
            border: 1px solid black;
            display: inline-block;
            cursor: pointer;
            color: #FFFFFF;
            font-family: 'Open Sans Condensed', sans-serif;
            font-size: 14px;
            padding: 8px 18px;
            text-decoration: none;
            text-transform: uppercase;
        }
        a[class="button_edit"]:hover {
            background:linear-gradient(to bottom, #000000 5%, #17202A 100%);
            background-color:#4D4D4D;
        }

        .profile_img{
            margin:10px auto;
            border: 1px dotted #000000; /*border: 1px solid #000000;*/
            -webkit-border-radius: 50%;
            border-radius: 50%
        }
    </style>
</head>
<body>
<%@ include file="header.html" %>
<br><br><br>
<center>
    <img src="/images/no_picture.jpg" style="width: 200px;
     height: 200px;
     background-size: cover;
     display: block;
     border-radius: 100px;
     -webkit-border-radius: 100px;
     -moz-border-radius: 100px;"/>
</center>
<div class="display_block">

<%
    User user = (User)request.getSession().getAttribute("currentUser");
    request.setAttribute("currentUser",user);
    //show profile picture in the middle
    //show gender as a icon
    out.println("Username:  "+user.getUsername());
    out.println("<br><br>Email:  "+user.getEmail());
    out.println("<br><br>Gender:  "+user.getGender());
    out.println("<br><br>You have used meal planner for ... days<br><br><center>");
%>
    <a href="/edit_profile.jsp?username=<%=user.getUsername()%>" class="button_sign_up">Edit Profile</a></center>

</div>

</body>
</html>
