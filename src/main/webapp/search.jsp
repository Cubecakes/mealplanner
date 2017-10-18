<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 10/10/2017
  Time: 10:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
    <style>
        /*input[type=text] {*/
            /*width: 50px;*/
            /*box-sizing: border-box;*/
            /*border: 2px solid #ccc;*/
            /*border-radius: 4px;*/
            /*font-size: 16px;*/
            /*background-color: white;*/
            /*background-image: url('searchicon.png');*/
            /*background-position: 10px 10px;*/
            /*background-repeat: no-repeat;*/
            /*padding: 12px 20px 12px 40px;*/
            /*-webkit-transition: width 0.4s ease-in-out;*/
            /*transition: width 0.4s ease-in-out;*/
        /*}*/

        /*input[type=text]:focus {*/
            /*width: 50%;*/
        /*}*/




        .container {
            margin:auto;
            width: 50%;
            left: 38%;
            top: 18%;

        }

        .search-box input[type="text"] {
            border: none;
            background: none;
            z-index: 1;
            width: 25px;
            height: 25px;
            transition: all .25s ease-in .25s;
            color: transparent;
            font-size: .75rem;
            line-height: 25px;
        }
        .search-box input[type="text"]:hover {
            cursor: pointer;
        }
        .search-box input[type="text"]:hover:focus {
            cursor: text;
        }
        .search-box input[type="text"]:hover + span {
            background: rgba(169, 71, 134, 0.2);
        }
        .search-box input[type="text"]:focus {
            width: 200px;
            padding: 0 10px;
            outline: none;
            color: black;
            background: none;
            color: #d05ba0;
        }
        .search-box input[type="text"]:focus + span {
            width: 200px;
        }
        .search-box input[type="text"]:focus + span::before {
            width: 2px;
            opacity: 0;
            transition: all .25s ease-in;
        }
        .search-box input[type="text"] + span {
            z-index: -1;
            position: absolute;
            border: 2px solid #d05ba0;
            top: 0;
            width: 25px;
            height: 25px;
            transition: all .25s ease-in .25s;
            border-radius: 25px;
            left: 0;
        }
        .search-box input[type="text"] + span::before {
            transition: all .25s ease-in .5s;
            transform-origin: left top;
            content: '';
            position: absolute;
            width: 10px;
            height: 5px;
            border-radius: 5px;
            background: #d05ba0;
            transform: rotate(45deg) translate(26px, -2px);
        }

    </style>

</head>
<body>
<%@ include file="header.html" %>
    <div class="form-style-8" style="margin-top: 200px;margin-bottom:100px;width:700px;">
        <form action="/home">
            <input type="hidden" name="action" value="search_submit" width="100">
            <input type="text" name="search_keyword" placeholder="Search for recipes by name, ingredients...">
            <center>
                <input type="submit" name="submit_search" value="Search">
            </center>
        </form>

        <center><a href="/home?action=search_all" class="button_add_meal">Show all recipes</a></center>

    </div>
    <%--div class="container" width="300">
        <div class="search-box" width="300">
            <form action="/home" method="post">
            <input type="hidden" name="action" value="search_submit" width="100">
            <input type="text" name="search_keyword" placeholder="Search for recipes">
            <input type="submit" name="submit_search" value="Search">
            </form>
            <span></span>
        </div>
    </div--%>

<!--div id="particles-js">
</div-->
<!-- scripts -->
<!--script src="/js/particles.js"></script>
<script src="/js/app.js"></script-->

</body>
</html>
