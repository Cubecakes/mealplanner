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
    </style>
</head>
<body>
<%@ include file="header.html" %>
<div>
    <table>

<%
    User user = (User)request.getAttribute("currentUser");
    request.setAttribute("currentUser",user);
    //show profile picture in the middle
    //show gender as a icon
    out.println("<tr>\n<td>Username</td>\n<td>"+user.getUsername()+"</td></tr>");
    out.println("<tr>\n<td>Email</td>\n<td>"+user.getEmail()+"</td></tr>");
    out.println("You have used meal planner for ... days");
%>
    </table>
    <form action="/home" method="post">
        <a href="/home?action=edit_profile" class="button_edit">Edit Profile</a>
    </form>

</div>

</body>
</html>
