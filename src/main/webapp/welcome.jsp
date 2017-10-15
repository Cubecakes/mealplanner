<%@ page import="unsw.comp4920.project.ControllerActions" %>
<html>
<head>
    <title>Welcome!</title>
    <link type="text/css" rel="stylesheet" href="login_register.css">
</head>
<body>

<div class="form-style-8">
    <h2>Login to your account</h2>
    <%
        if(request.getAttribute("error_info")!=null){
            out.println("<p style='color:red'>"+request.getAttribute("error_info")+"</p>");
        }
    %>
    <form action="control" method="post">
        <input type="text" name="username" placeholder="Username" />
        <input type="password" name="password" placeholder="Password" />
        <input type="hidden" name="action" value="check_login">
        <input type="submit" value="Log in" />
        <br><br>
        <a href="./control?action=<%=ControllerActions.FORGET_PASSWORD%>" class="commonHyperLink">Forget password?</a>
    </form>
</div>
<div class="form-style-8">
    <h1>New to MealPlanner?</h1>
    <h3 style="color: #4D4D4D">Sign up now to plan your everyday diet!</h3>
    <a href="register.jsp" class="button_sign_up">Sign up</a>
</div>
</body>
</html>

