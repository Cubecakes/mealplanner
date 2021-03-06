<%@ page import="unsw.comp4920.project.ControllerActions" %><%--
  Created by IntelliJ IDEA.
  User: Darren
  Date: 15-Oct-17
  Time: 9:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Meal Your Day™</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
    <link rel="stylesheet" media="screen" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <style>
        /* This styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk */

        .loader {
            position: absolute;
            /*margin: 0 0 2em;*/
            margin-left: 50px;
            margin-top: 10px;
            height: 30px;
            width: 30px;
            text-align: center;
            /*padding: 2em;*/
            /*margin: 0 auto 1em;*/
            display: inline-block;
            vertical-align: top;
        }

        svg path,
        svg rect {
            fill: rgb(255, 255, 255);
        }

    </style>
</head>

<body>

    <!--header-->
    <header class="upheaderxx">
        <!--animation-->
        <div class="loader loader--style5">
            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"  x="0px" y="0px" width="24px" height="30px" viewBox="0 0 24 30" style="enable-background:new 0 0 50 50;" xml:space="preserve">
            <rect x="0" y="0" width="4" height="10" fill="#333">
              <animateTransform attributeType="xml"
                attributeName="transform" type="translate"
                values="0 0; 0 20; 0 0"
                begin="0" dur="0.6s" repeatCount="indefinite" />
            </rect>
            <rect x="10" y="0" width="4" height="10" fill="#333">
              <animateTransform attributeType="xml"
                attributeName="transform" type="translate"
                values="0 0; 0 20; 0 0"
                begin="0.2s" dur="0.6s" repeatCount="indefinite" />
            </rect>
            <rect x="20" y="0" width="4" height="10" fill="#333">
              <animateTransform attributeType="xml"
                attributeName="transform" type="translate"
                values="0 0; 0 20; 0 0"
                begin="0.4s" dur="0.6s" repeatCount="indefinite" />
            </rect>
              </svg>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>

        <!--header-->
        <nav>
            <ul>
                <li><a class="axx" href="./control?action=<%=ControllerActions.GOTO_LOGIN%>">Login</a></li>
                <li><a class="axx" href="./control?action=<%=ControllerActions.GOTO_REGISTER%>">Register</a></li>
            </ul>
        </nav>
    </header>

    <!--title-->
    <div class="myTitle">
        <h1>Hi,Welcome to Meal Your Day™</h1>
        <h2>Meal Planner</h2>
    </div>

    <div class="home_upper_line">
        <img src="/images/line.PNG" alt="#">
    </div>


<!--
Copyright (c) 2017 by Captain Anonymous (http://codepen.io/anon/pen/dWgZNm)


Fork of an original work by Sean Codes (http://codepen.io/sean_codes/pen/VbWdRd)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
    <!--wrapper-->
    <div class="container">
        <div class="top">
            <div class="title">Come and Plan Your Daily Meal!</div>
        </div>
        <div class="view">
            <div class="code"></div>
            <div class="example"></div>
            <div class="handle">
                <div class="tracker"></div>
            </div>
        </div>
    </div>
    <script src="/js/show_hide.js"></script>


    <div class="home_lower_line">
        <img src="/images/line.PNG" alt="#">
    </div>

    <div class="home_lower_wrapper">
        <div class="home_lower_article">
            <h1>What is Meal Your Day™?</h1>
            <p>
                Meal Your Day is a personalized meal planner designed to make it easier for you to plan your meals.
                You can customize your meal planner with pizzas and fries, check back on what you had for breakfast on Thursday morning and have the app recommend your something to eat!
            </p>
            <h1>Intuitive. Creative. Free.</h1>
            <p>
                Get started by registering now!
                Or login if you have an account already.
            </p>
            <a href="login.jsp" targe="_blank" class="button"> Login </a>
        </div>
        <a href="register.jsp" targe="_blank" class="button"> Register </a>
    </div>


    <!--footer-->
    <div class="footer">
        <div class="footer-meme">
            <p>MADE WITH. 💗</p>
            <p>POWERED BY Meal Your Day™..🎈</p>
        </div>

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
