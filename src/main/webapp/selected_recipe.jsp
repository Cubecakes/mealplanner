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
    <link type="text/css" rel="stylesheet" href="recipe_list.css">
    <link type="text/css" rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" ref="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
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

                    //recipe details:
                    out += "<div class='recipe_display_block'>\n";
                    //picture
                    out += "<center><img src='"+arr[i].image+"' onerror=\"this.src='images/no_photo_found.png'\" style='width: 500px;'></center>\n<br>";
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
                        "<h5 style='color: grey;font-family: Lato, sans-serif;'>" +arr[i].ingredients+"</h5><br><br><br>\n";

                    //buttons in a line: back       add to plan
                    out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
                        "       <div class=\"col-6\"><center><a href='/home?action=add_to_plan&&recipe="+arr[i]._id['$oid']+ "' class='button_add_meal'>Add to plan</a></center></div>\n";

                    var keyword = '<%=(String)request.getAttribute("search_keyword")%>';
                    out += "    <div class=\"col-6\"><center><a href='/home?action=search_submit&&search_keyword="+keyword+"&&submit_search=Search' class='button_add_meal' >Back</a></center>" +
                        "   </div><br><br><br>";
                   // out += "<div class=\"row\" style='margin-left: 115px;width: 800px'><p style='color: grey;margin-left: 80px;'>source: "+arr[i].url+"</p></div>\n";
                    out += "</div><br><br>\n";
                    out += "<p style='color: grey;margin-left: 80px;'>source: "+arr[i].url+"</p>\n";
                    break;
                }
            }
        }

        document.getElementById("recipe_info").innerHTML = out;
    };

    xmlhttp.open("GET", url, true);
    xmlhttp.send();

</script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</body>
</html>
