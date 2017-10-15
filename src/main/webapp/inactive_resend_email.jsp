<%@ page import="unsw.comp4920.project.ControllerActions" %><%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 3/10/2017
  Time: 10:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
    <header class="upheaderxx">
        <!--animation-->
        <div class="loader loader--style5">
            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="30px" viewBox="0 0 24 30" style="enable-background:new 0 0 50 50;" xml:space="preserve">
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


    </header>

<div>
    Sorry, your account is not activated...
    <br>
    Didn't get activation email?
    <a href="./control?action=<%=ControllerActions.SEND_RECONFIRMATION_EMAIL%>" class="commonHyperLink">Re-send Email</a>
</div>
</body>
</html>
