<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 3/10/2017
  Time: 10:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Meal Your Day™..🎈</title>
    <link rel="stylesheet" media="screen" href="/css/email.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
</head>
<body>



   <h1 class="myh1">Sorry, your account is not activated...🎈 </h1>
   <h1 class="myh2">Didn't get activation email? </h1>

   <div class="line2"></div>

   <div class="home_lower_wrapper">
       <a href="./control?action=resend_confirm_email" targe="_blank" class="button">Resend👌</a>
   </div>

    <!--a href="./control?action=resend_confirm_email" class="commonHyperLink">Re-send Email</a-->
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
