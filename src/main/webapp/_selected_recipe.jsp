<%@ page import="java.util.Calendar" %>
<%@ page import="unsw.comp4920.project.User" %>
<%@ page import="unsw.comp4920.project.RecipeNew" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="unsw.comp4920.project.SearchCommons" %><%--suppress ALL --%>
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
<%!
String displayRecipeDetails(RecipeNew r, User user, String displayType, String meal_type, String plan_date, String keyword){
    String out = "";
    Boolean liked = user.getFavouriteList().stream().anyMatch(fav_recipe -> fav_recipe.getId().equals(r.getId()));
    out += "<center><h1 style='color: #21c2f8;font-family: Lato, sans-serif;'>"+r.getName()+"</h1></center><br>\n";
    //recipe details:
    out += "<div class='recipe_display_block'>\n";
    if(liked){
        out += "<a class='btn btn-success' href='/home?action=unlike&&recipe_id="+r.getId()+"&&username=" + user.getUsername() + "'>Unlike</a>";
    }else{
        out += "<a class='btn btn-success' href='/home?action=favourite&&recipe_id="+r.getId()+"&&recipe_name=" + r.getName()+ "'>Like</a>";
    }
    out += "<p style='color: grey;margin-left:80 px;'>";
    /*if(r.get!= null){
        out += "By "+arr[i].creator+"            ";
    }*/

    if(r.getUnixTime() !=null){
        SimpleDateFormat sdf = new SimpleDateFormat("MMMM d, yyyy 'at' h:mm a");
        String date = sdf.format(r.getUnixTime());
        out += "Published date: "+ date;
    }
    out += "</p>\n";



    //picture
    out += "<center><img src='"+r.getImageUrl()+"' onerror=\"this.src='images/no_photo_found.png'\" class='rounded' style='width: 400px;'></center>\n<br>";
    //picture source
    out += "<center>image source: "+r.getImageUrl()+"</center>\n<br><br><br>";

    //description
    out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Description</h2><br>\n";
    if(r.getDescription() == null){
        out += "<h4 style='color: grey;font-family: Lato, sans-serif;'>No description</h4><br><br>\n";
    }else{
        out += "<h4 style='color: grey;font-family: Lato, sans-serif;'>" +r.getDescription()+"</h4><br><br>\n";
    }


    //prepare time:
    if(r.getPrepTime()!=null){
        String prepTime = r.getPrepTime().substring(2);
        out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Preparation Time:  ";
        out += prepTime +"</h3><br><br>\n";
    }

    //cook time:
    if(r.getCookTime()!=null){
        String cookTime = r.getCookTime().substring(2);
        out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Cook Time:  ";
        out += cookTime+"</h3><br><br>\n";
    }

    String []ingredients = null;
    ingredients = r.getIngredients().split("\n");
    out += "<h2 style='color: #21c2f8;font-family: Lato, sans-serif;'>Ingredients</h2><br>\n";
    for(String i : ingredients){
        out += "<h4 style='color: grey;font-family: Lato, sans-serif;'>" +i+"</h4>\n";
    }
    out += "<br><br><br>";

    out += "<br><br><br>";
    if (displayType.equals("calendar")){
        out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
        "       <div class=\"col-6\"><center>            " +
            "       <form action=\"/home\" method=\"get\" tabindex=\"-1\">\n" +
                "           <input type=\"hidden\" name=\"action\" value=\"remove_plan\">\n" +
                "           <input type=\"hidden\" name=\"recipe_id\" value=\""+r.getId()+"\">\n" +
                "           <input type=\"hidden\" name=\"recipe_name\" value=\""+r.getName()+"\">\n" +
                "           <input type=\"hidden\" name=\"plan_date\" value=\""+plan_date+"\">\n" +
                "           <input type=\"hidden\" name=\"meal_type\" value=\""+meal_type+"\">\n" +
                "           <input type=\"submit\" name=\"remove_plan\" value=\"Remove from Plan\" class=\"load-more-btn\">\n" +
                "       </form></div>\n";

        out += "    <div class=\"col-6\"><center><a href='/home' class='button_add_meal' >Back</a></center></div>"
    }else if(displayType.equals("search")){
    //buttons in a line: back       add to plan
        out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
        "       <div class=\"col-6\"><center>            " +
            "       <form action=\"/home\" method=\"get\" tabindex=\"-1\">\n" +
                "           <input type=\"hidden\" name=\"action\" value=\"add_to_plan\">\n" +
                "           <input type=\"hidden\" name=\"recipe_id\" value=\""+r.getId()+"\">\n" +
                "           <input type=\"hidden\" name=\"recipe_name\" value=\""+r.getName()+"\">\n" +
                "           <input type=\"hidden\" name=\"plan_date\" value=\""+plan_date+"\">\n" +
                "           <input type=\"hidden\" name=\"meal_type\" value=\""+meal_type+"\">\n" +
                "           <input type=\"submit\" name=\"add_meal\" value=\"Add to Plan\" class=\"load-more-btn\">\n" +
                "       </form></div>\n";


        out += "    <div class=\"col-6\"><center><a href='/home?action=search_submit&&" + SearchCommons.printRecipeTags(r,plan_date,meal_type,keyword) +
                            " &&submit_search=Search' class='button_add_meal' >Back</a></center></div>";

    }else if(displayType.equals("profile")) {
        out += "<div class=\"row\" style='margin-left: 115px;width: 800px'>\n" +
            "       <div class=\"col-6\"><center>            " +
            "       <button type=\"button\" class='button_add_meal' data-toggle=\"modal\" data-target='#addMeal'>\n" +
            "           Add to Plan\n" +
            "       </button></div>\n";
        out += "    <div class=\"col-6\"><center><a href='/home?action=profile' class='button_add_meal' >Back</a></center></div>";
    }
    return out;
}
%>
<%
    String recipe_id = request.getParameter("recipe_id");
    RecipeNew r = null; // dbo.getRecipie(recipe_id);
    User user = (User) request.getSession().getAttribute("user");
    String plan_date = request.getParameter("plan_date");
    String meal_type = request.getParameter("meal_type");
    String keyword = request.getParameter("search_keyword");

    System.out.println(displayRecipeDetails(r,user,meal_type,plan_date,keyword));

%>

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
                    <input type="hidden" name="recipe_id" value="<%=r.getId()%>">
                    <input type="hidden" name="recipe_name" value="<%=r.getName()%>">
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
