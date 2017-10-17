<%@ page import="unsw.comp4920.project.ControllerActions" %>
<%@ page import="unsw.comp4920.project.Controller" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign in</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
    <style>
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


    <nav>
        <ul>
            <li><a class="axx" href="./control?action=<%=ControllerActions.NOTHING%>">Home</a></li>
            <li><a class="axx" href="./control?action=<%=ControllerActions.GOTO_LOGIN%>">Login</a></li>
            <li><a class="axx " href="./control?action=<%=ControllerActions.GOTO_REGISTER%>">Register</a></li>
        </ul>
    </nav>
</header>







<div class="form-style-8">
    <h2>Login to your account</h2>
    <%
        if(request.getAttribute("error_info")!=null){
            out.println("<p style='color:red'>"+request.getAttribute("error_info")+"</p>");
        }
    %>
    <form action="./control" method="post">
        <input type="text" name="username" placeholder="Username" />
        <input type="password" name="password" placeholder="Password" />
        <input type="hidden" name="action" value="<%=ControllerActions.CHECK_LOGIN%>">
        <input type="submit" value="Log in" />
        <br><br>
        <a href="./control?action=<%=ControllerActions.NOTHING%>" class="commonHyperLink">Forget password?</a>
        <a href="./control?action=<%=ControllerActions.GOTO_REGISTER%>" class="commonHyperLink">New to meal planner?</a>
    </form>
</div>
</body>
</html>
