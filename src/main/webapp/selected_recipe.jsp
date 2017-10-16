<%--suppress ALL --%>
<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 16/10/2017
  Time: 4:08 PM
  To change this template use File | Settings | File Templates.
--%>
<!--suppress ALL -->
<html>
<head>
    <title>Recipe</title>
    <link type="text/css" rel="stylesheet" href="css/recipe_display.css">
    <link type="text/css" rel="stylesheet" href="login_register.css">
</head>
<body>
<%@ include file="header.html" %>
<div class="recipe_display_block">
    <div id="recipe_info"></div>

    <script type="text/javascript">
        var recipe_id = '<%=(String)request.getAttribute("selected_recipe")%>';
        var xmlhttp = new XMLHttpRequest();
        var url = "recipe_test.json";

        xmlhttp.onreadystatechange = function() {

            if (xmlhttp.readyState == 4 && xmlhttp.status == "200") {
                var arr = JSON.parse(xmlhttp.responseText);
                out = "";

                for(i=0;i<arr.length;i++){
                    if(arr[i]._id['$oid']==recipe_id){
                        out += "<h1>"+arr[i].name+"</h1>";
                        out += "<h3>"+arr[i].descrption+"</h3>";
                        break;
                    }
                }
                out += "<>";
            }

            document.getElementById("recipe_info").innerHTML = out;
        };

        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    </script>
</div>
</body>
</html>
