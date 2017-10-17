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
    <link type="text/css" rel="stylesheet" href="recipe_display.css">
    <link type="text/css" rel="stylesheet" href="login_register.css">
</head>
<body>
<%@ include file="header.html" %>
<div id="recipe_info" style="margin-top: 120px;"></div>

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
                    //name
                    out += "<center><h1 style='color: #21c2f8;font-family: Lato, sans-serif;'>"+arr[i].name+"</h1></center><br>\n";
                    /*
                      in one line...
                      creator, if have one:
                      publish date:
                    */
                    out += "<p style='color: grey;margin-left:80 px;'>";
                    if(arr[i].creator != null){
                        out += "By "+arr[i].creator+"            ";
                    }

                    if(arr[i].datePublished!=null){
                        out += "Published date: "+arr[i].datePublished;
                    }
                    out += "</p>\n";
                    out += "<p style='color: grey;margin-left: 80px;'>source: "+arr[i].url+"</p>\n";

                    //recipe details:
                    out += "<div class='recipe_display_block'>\n";
                    //picture
                    out += "<center><img src='"+arr[i].image+"' onerror=\"this.src='images/logonew.png'\" class=''></center>\n<br>";
                    //picture source
                    out += "<center>image source: "+arr[i].image+"</center>\n<br><br><br>";

                    //description
                    out += "<h3 style='color: #21c2f8;font-family: Lato, sans-serif;'>Descirption</h3><br>\n";
                    if(arr[i].description==null){
                        out += "<h5 style='color: grey;font-family: Lato, sans-serif;'>No description</h5><br><br>\n";
                    }else{
                        out += "<h5 style='color: grey;font-family: Lato, sans-serif;'>" +arr[i].description+"</h5><br><br>\n";
                    }


                    //prepare time:
                    var prep_time = arr[i].prepTime;
                    if(prep_time!=null){
                        prep_time = prep_time.substring(2);
                        out += "<h3 style='color: #21c2f8;font-family: Lato, sans-serif;'>Preparation Time:  ";
                        out += prep_time+"</h3><br><br>\n";
                    }
                    //cook time:
                    var cook_time = arr[i].cookTime;
                    if(cook_time!=null){
                        cook_time = cook_time.substring(2);
                        out += "<h3 style='color: #21c2f8;font-family: Lato, sans-serif;'>Cook Time:  ";
                        out += cook_time+"</h3><br><br>\n";
                    }

                    //ingredients:


                    out += "<h3 style='color: #21c2f8;font-family: Lato, sans-serif;'>Ingredients</h3><br>\n" +
                        "<h5 style='color: grey;font-family: Lato, sans-serif;'>" +arr[i].ingredients+"</h5>\n";


                    out += "</div>\n";
                    //buttons in a line: back       add to plan
                    break;
                }
            }
        }

        document.getElementById("recipe_info").innerHTML = out;
    };

    xmlhttp.open("GET", url, true);
    xmlhttp.send();
</script>
</body>
</html>
