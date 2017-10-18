<%@ page import="java.util.Calendar" %><%--suppress ALL --%>
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
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-reboot.min.css" rel="stylesheet">
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
                    out += "<center><h1 style='color: #21c2f8;font-family: Lato, sans-serif;'>"+arr[i].name+"</h1></center>\n";
                    //recipe details:
                    out += "<div class='recipe_display_block'>\n";
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


                    //picture
                    out += "<center><img src='"+arr[i].image+"' onerror=\"this.src='images/no_photo_found.png'\" class='rounded' style='width: 400px;'></center>\n<br>";
                    //picture source
                    out += "<center>image source: "+arr[i].image+"</center>\n<br><br><br>";

                    //description
                    out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Descirption</h2><br>\n";
                    if(arr[i].description==null){
                        out += "<h4 style='color: grey;font-family: Lato, sans-serif;'>No description</h4><br><br>\n";
                    }else{
                        out += "<h4 style='color: grey;font-family: Lato, sans-serif;'>" +arr[i].description+"</h4><br><br>\n";
                    }


                    //prepare time:
                    var prep_time = arr[i].prepTime;
                    if(prep_time!=null){
                        prep_time = prep_time.substring(2);
                        out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Preparation Time:  ";
                        out += prep_time+"</h3><br><br>\n";
                    }
                    //cook time:
                    var cook_time = arr[i].cookTime;
                    if(cook_time!=null){
                        cook_time = cook_time.substring(2);
                        out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Cook Time:  ";
                        out += cook_time+"</h3><br><br>\n";
                    }

                    //ingredients:

                    var ingredients = new Array();
                    ingredients = arr[i].ingredients.split("\n");
                    out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Ingredients</h2><br>\n";
                    for(j=0;j<ingredients.length;j++){
                        out += "<h4 style='color: grey;font-family: Lato, sans-serif;'>" +ingredients[j]+"</h4>\n";
                    }
                    //out += "<h5 style='color: grey;font-family: Lato, sans-serif;'>" +arr[i].ingredients+"</h5><br><br><br>\n";
                    out += "<br><br><br>";

                    //buttons in a line: back       add to plan
                    out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
                        "       <div class=\"col-6\"><center><a href='#add_meal_modal' class='button_add_meal' data-toggle='modal'>Add to Plan</a></center></div>\n";

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

<div class="modal fade" id="add_meal_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <center><h4 class="modal-title" id="myModalLabel">Add to plan</h4></center>
                <%--button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button--%>
            </div>
            <div class="modal-body">
                <form action="/home" method="post">
                    <div class="form-style-8" style="width: 400px;">

                        <div class="styled-select slate">
                            <%
                                Calendar now = Calendar.getInstance();   // Gets the current date and time
                                int year = now.get(Calendar.YEAR);
                                out.println("<select name='add_to_plan_year'>");

                                for(int i=year;i<=year+30;i++){
                                    out.println("<option>"+i+"</option>");
                                }
                                out.println("</select>\n<select name='add_to_plan_month'>");

                                for(int i=1;i<=12;i++){
                                    out.println("<option>"+i+"</option>");
                                }
                                out.println("</select>\n<select name='add_to_plan_day'>");

                                for(int i=1;i<=31;i++){
                                    out.println("<option>"+i+"</option>");
                                }

                                out.println("</select>");
                            %>
                        </div>
                        <br><br>
                        <input type="radio" name="add_to_plan_type" value="Breakfast"> Breakfast
                        <input type="radio" name="add_to_plan_type" value="Lunch"> Lunch
                        <input type="radio" name="add_to_plan_type" value="Dinner"> Dinner

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="load-more-btn" data-dismiss="modal">Close</button>
                        <input type="hidden" name="action" value="add_to_plan">
                        <input type="hidden" name="recipe_id" value="<%=(String)request.getParameter("selected_recipe")%>">
                        <input type="hidden" name="recipe_name" value="<%=(String)request.getParameter("recipe_name")%>">
                        <input type="submit" name="add_meal" value="Add to Plan" class="load-more-btn">
                        <%--a href='./home?action=add_to_plan&&recipe_id=<%=(String)request.getAttribute("selected_recipe")%>' class="load-more-btn">Add to plan</a--%>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
