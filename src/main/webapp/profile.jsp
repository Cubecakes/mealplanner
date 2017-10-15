<%@ page import="unsw.comp4920.project.User" %>
<%--
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
    <link rel="shortcut icon" href="images/profolio.PNG" type="image/x-icon" />
    <link rel="stylesheet" media="screen" href="css/profile.css">

</head>
<body>

<%@ include file="header.html" %>

<!--%
    User user = (User)request.getSession().getAttribute("currentUser");
    request.setAttribute("currentUser",user);
    //show profile picture in the middle
    //show gender as a icon

    out.println("Username:  "+user.getUsername());
    out.println("<br><br>Email:  "+user.getEmail());
    out.println("<br><br>Gender:  "+user.getGender());
    out.println("<br><br>You have used meal planner for ... days<br><br><center>");
%-->



<div class="contact_wrapper">
    <header class="contact_header">
        <%
            User user = (User)request.getSession().getAttribute("currentUser");
            request.setAttribute("currentUser",user);
            out.println("<h1 class=\"myname\"> Hello! "+user.getUsername()+".</h1>");
            // <h1 class="myh1">Hi! Would U like to have a coffee & chat?</h1>
        %>
        <h1 class="myh1">Welcome to Meal Your Day!</h1>
    </header>
    <section>
        <img src="images/profolio.PNG">

        <div class="arrow-up"></div>
        <form id="contact" class="form-horizontal" role="form">

            <%
                out.println("<h3 class=\"myh3\">USERNAME:</h3>");
                out.println("<h3 class=\"myh233\">"+user.getUsername()+"</h3>");

                out.println("<h3 class=\"myh3\">email:</h3>");
                out.println("<h3 class=\"myh233\">"+user.getEmail()+"</h3>");

                out.println("<h3 class=\"myh3\">gender:</h3>");
                out.println("<h3 class=\"myh233\">"+user.getGender()+"</h3>");

                out.println("<h3 class=\"myh3\">You have used meal planner for ... days</h3>");

            %>

            <!--button id="send" name="/edit_profile.jsp?username=<%=user.getUsername()%>" class="btn btn-block">Edit</button-->

            <a href="/edit_profile.jsp?username=<%=user.getUsername()%>" class="btn btn-info btn-block" style="margin-top: 40px;">Edit Profile</a>
        </form>
    </section>


</div>

<!--background animation-->
<!--fork from http://vincentgarreau.com/particles.js/-->
<!-- particles.js container -->
<div id="particles-js">
</div>
<!-- scripts -->
<script src="/js/particles.js"></script>
<script src="/js/app.js"></script>

</body>
</html>