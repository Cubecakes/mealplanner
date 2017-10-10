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




        /**profile pic **/
        /**script down from https://codepen.io/wifeo/pen/eDnwh **/
        .fond{position:absolute;padding-top:85px;
            top: 45px;left:0; right:0;bottom:0;
            /**background-image:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/173024/fond.jpg);background-size:cover;**/}

        .principal
        {
            width: 230px;
            height: 230px;
            background-color:#DD4545;
            border-radius: 170px;
            padding: 30px;
        }
        .principal_petit
        {
            width: 170px;
            height: 170px;
            background-color: #ffffff;
            border-radius: 170px;
            -webkit-transition:all 0.2s ease-in;
            -moz-transition:all 0.2s ease-in;
            -ms-transition:all 0.2s ease-in;
            -o-transition:all 0.2s ease-in;
            transition:all 0.2s ease-in;
        }
        .principal_petit:hover
        {
            -webkit-transform: scale(1.1);
            -webkit-transition:all 0.2s ease-in;
            -moz-transform: scale(1.1);
            -moz-transition:all 0.2s ease-in;
            -ms-transform: scale(1.1);
            -ms-transition:all 0.2s ease-in;
            -o-transform: scale(1.1);
            -o-transition:all 0.2s ease-in;
            transform: scale(1.1);
            transition:all 0.2s ease-in;
        }
        .principal_img
        {
            -webkit-transition:all 0.2s ease-in;
            -moz-transition:all 0.2s ease-in;
            -ms-transition:all 0.2s ease-in;
            -o-transition:all 0.2s ease-in;
            transition:all 0.2s ease-in;
        }
        .principal_img:hover
        {
            -webkit-transform: scale(0.7);
            -webkit-transition:all 0.2s ease-in;
            -moz-transform: scale(0.7);
            -moz-transition:all 0.2s ease-in;
            -ms-transform: scale(0.7);
            -ms-transition:all 0.2s ease-in;
            -o-transform: scale(0.7);
            -o-transition:all 0.2s ease-in;
            transform: scale(0.7);
            transition:all 0.2s ease-in;
        }

    </style>


</head>
<body>

<%@ include file="header.html" %>
<br><br><br>


    <link  rel='stylesheet' type='text/css'>

    <div align="center" class="fond">

        <a href="">
            <div class="principal">
                <div class="principal_petit">
                    <div class="principal_img">
                        <img src="/images/pro_pic.png" border="0" align="center"/>
                    </div>
                </div>
            </div>
        </a>
       
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
%><center>
 <a href="/edit_profile.jsp?username=<%=user.getUsername()%>" class="button_sign_up">Edit Profile</a></center>


</div>

</body>
</html>
