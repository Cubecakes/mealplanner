<%@ page import="java.util.Calendar" %>
<%@ page import="unsw.comp4920.project.User" %><%--suppress ALL --%>
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

    function printRecipeTags(arr, i, keyword){

        return '&plan_date=<%= request.getParameter("plan_date") %>&meal_type=<%=request.getParameter("meal_type")%>&&recipe_id='
            + arr[i]._id['$oid']+'&&recipe_name=' + arr[i].name + '&&search_keyword=' + keyword;
    }
    var recipe_id = '<%=(String)request.getAttribute("recipe_id")%>';
    var xmlhttp = new XMLHttpRequest();
    var url = "recipe_test.json";
    var queryDict = {}
    location.search.substr(1).split("&").forEach(function(item) {queryDict[item.split("=")[0]] = item.split("=")[1]})

    xmlhttp.onreadystatechange = function() {

        if (xmlhttp.readyState == 4 && xmlhttp.status == "200") {
            var arr = JSON.parse(xmlhttp.responseText);
            out = "";

            for(i=0;i<arr.length;i++){
                if(arr[i]._id['$oid']==recipe_id){
                    var liked = false;
                    var liked_recipes = new Array();
                    <%
                        User user = (User)request.getSession().getAttribute("currentUser");
                        request.getSession().setAttribute("currentUser",user);
                        System.out.println("Selected_recipe page:username====="+user.getUsername());
                        for(int i=0;i<user.getFavouriteList().size();i++){
                            out.println("liked_recipes.push('"+user.getFavouriteList().get(i).getId()+"')");
                        }
                    %>;
                    for(j=0;liked_recipes.length;j++){
                        if(recipe_id==liked_recipes[j]){
                            liked = true;
                            break;
                        }
                    }

                    out += "<center><h1 style='color: #21c2f8;font-family: Lato, sans-serif;'>"+arr[i].name+"</h1></center><br>\n";
                    //recipe details:
                    out += "<div class='recipe_display_block'>\n";
                    /*
                      in one line...
                      creator, if have one:
                      publish date:
                    */
                    if(liked == true){
                        out += "<a class='btn btn-success' href='/home?action=unlike&&recipe_id="+recipe_id+"&&username=" + <%=(String)request.getAttribute("username")%> + "'>Unlike</a>";
                    }else{
                        out += "<a class='btn btn-success' href='/home?action=favourite&&recipe_id="+recipe_id+"&&recipe_name=" + arr[i].name + "'>Like</a>";
                    }

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
                    out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Description</h2><br>\n";
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
                    if ("<%=(String)request.getParameter("display_type")%>" == "calendar"){
                        out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
                            "       <div class=\"col-6\"><center>            " +
                            "       <form action=\"/home\" method=\"get\" tabindex=\"-1\">\n" +
                            "           <input type=\"hidden\" name=\"action\" value=\"remove_plan\">\n" +
                            "           <input type=\"hidden\" name=\"recipe_id\" value=\"<%=(String)request.getParameter("recipe_id")%>\">\n" +
                            "           <input type=\"hidden\" name=\"recipe_name\" value=\"<%=(String)request.getParameter("recipe_name")%>\">\n" +
                            "           <input type=\"hidden\" name=\"plan_date\" value=\"<%=(String)request.getParameter("plan_date")%>\">\n" +
                            "           <input type=\"hidden\" name=\"meal_type\" value=\"<%=(String)request.getParameter("meal_type")%>\">\n" +
                            "           <input type=\"submit\" name=\"remove_plan\" value=\"Remove from Plan\" class=\"load-more-btn\">\n" +
                            "       </form></div>\n";

                        out += "    <div class=\"col-6\"><center><a href='/home' class='button_add_meal' >Back</a></center></div>"
                    }else if("<%=(String)request.getParameter("display_type")%>" == "search") {
                        //buttons in a line: back       add to plan
                        out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
                            "       <div class=\"col-6\"><center>            " +
                            "       <form action=\"/home\" method=\"get\" tabindex=\"-1\">\n" +
                            "           <input type=\"hidden\" name=\"action\" value=\"add_to_plan\">\n" +
                            "           <input type=\"hidden\" name=\"recipe_id\" value=\"<%=(String)request.getParameter("recipe_id")%>\">\n" +
                            "           <input type=\"hidden\" name=\"recipe_name\" value=\"<%=(String)request.getParameter("recipe_name")%>\">\n" +
                            "           <input type=\"hidden\" name=\"plan_date\" value=\"<%=(String)request.getParameter("plan_date")%>\">\n" +
                            "           <input type=\"hidden\" name=\"meal_type\" value=\"<%=(String)request.getParameter("meal_type")%>\">\n" +
                            "           <input type=\"submit\" name=\"add_meal\" value=\"Add to Plan\" class=\"load-more-btn\">\n" +
                            "       </form></div>\n";

                        var keyword = '<%=(String)request.getAttribute("search_keyword")%>';
                        out += "    <div class=\"col-6\"><center><a href='/home?action=search_submit&&" + printRecipeTags(arr, i, keyword) +
                            " &&submit_search=Search' class='button_add_meal' >Back</a></center></div>";

                    }else if("<%=(String)request.getAttribute("display_type")%>" == "profile") {
                        out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
                            "       <div class=\"col-6\"><center>            " +
                            "       <button type=\"button\" class='button_add_meal' data-toggle=\"modal\" data-target='#addMeal'>\n" +
                            "           Add to Plan\n" +
                            "       </button></div>\n";

                        out += "    <div class=\"col-6\"><center><a href='/home?action=profile' class='button_add_meal' >Back</a></center></div>";
                    }else if("<%=(String)request.getParameter("display_type")%>" == "profile") {
                        out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
                            "       <div class=\"col-6\"><center>            " +
                            "       <button type=\"button\" class='button_add_meal' data-toggle=\"modal\" data-target='#addMeal'>\n" +
                            "           Add to Plan\n" +
                            "       </button></div>\n";

                        out += "    <div class=\"col-6\"><center><a href='/home?action=profile' class='button_add_meal' >Back</a></center></div>";
                    }

                    out += "<br><br><br>";
                   // out += "<div class=\"row\" style='margin-left: 115px;width: 800px'><p style='color: grey;margin-left: 80px;'>source: "+arr[i].url+"</p></div>\n";
                    out += "</div><br><br>\n";
                    out += "<center><a href=\""+arr[i].url+"\" style='color: grey;'> view full recipe: </a></center>\n";
                    break;
                }
            }
        }

        document.getElementById("recipe_info").innerHTML = out;
    };

    xmlhttp.open("GET", url, true);
    xmlhttp.send();

</script>

<!-- Modal -->

<div class="modal fade bs-example-modal-lg" id="addMeal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Add to Plan</h4>
            </div>
            <form action="/home">
                <div class="modal-body"><center>
                    <select name="add_to_plan_year">
                        <%
                            Calendar now = Calendar.getInstance();   // Gets the current date and time
                            int year = now.get(Calendar.YEAR);
                            for(int i=year;i<=year+30;i++){
                                out.println("<option>"+i+"</option>");
                            }
                        %>
                    </select >

                    <select name="add_to_plan_month">
                        <%
                            for(int i=1;i<=12;i++){
                                out.println("<option>"+i+"</option>");
                            }
                        %>
                    </select>

                    <select name="add_to_plan_day">
                        <%
                            for(int i=1;i<=31;i++){
                                out.println("<option>"+i+"</option>");
                            }
                        %>
                    </select>
                    <br><br><br>
                    <input type="radio" name="meal_type" value="Breakfast"> Breakfast
                    <input type="radio" name="meal_type" value="Lunch"> Lunch
                    <input type="radio" name="meal_type" value="Dinner"> Dinner
                </center></div>
                <div class="modal-footer"><center>
                    <button type="button" class="load-more-btn" data-dismiss="modal">Close</button>
                    <input type="hidden" name="recipe_id" value="<%=(String)request.getParameter("recipe_id")%>">
                    <input type="hidden" name="recipe_name" value="<%=(String)request.getParameter("recipe_name")%>">
                    <input type="hidden" name="action" value="add_to_plan_without_plan_date">
                    <input type="hidden" name="parent_page" value="selected_recipe">
                    <input type="submit" class="load-more-btn" value="Add">
                </center></div>
            </form>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>

</body>
</html>
