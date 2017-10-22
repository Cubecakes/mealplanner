<%@ page import="unsw.comp4920.project.DatabaseOperation" %>
<%@ page import="unsw.comp4920.project.RecipeNew" %>
<%@ page import="java.util.List" %>
<%@ page import="unsw.comp4920.project.SearchCommons" %><%--
  Created by IntelliJ IDEA.
  User: Darren
  Date: 21-Oct-17
  Time: 4:56 PM
  To change this template use File | Settings | File Templates.

  TO BE DONE SOON
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Results</title>
    <link type="text/css" rel="stylesheet" href="recipe_list.css">
    <link type="text/css" rel="stylesheet" href="css/buttons.css">
    <link type="text/css" rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" ref="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<%@ include file="header.html" %>
<div id="demo" class="container"></div>
<%
    String keyword = request.getParameter("search_keyword");
    if (keyword == null) {
        keyword = "";
    }
    keyword = keyword.toLowerCase();
    String plan_date = request.getParameter("plan_date");
    String meal_type = request.getParameter("meal_type");
%>

<%!


    String printRecipe(RecipeNew r, String plan_date, String meal_type, String keyword) {
        String out = "";
        out += "<div class=\"col-xs-12 col-md-6\">\n" +
                "    <div class=\"prod-info-main prod-wrap clearfix\">\n" +
                "\n" +
                "      <div class=\"row\">\n" +
                "\n" +
                "        <div class=\"col-md-5 col-sm-12 col-xs-12\">\n" +
                "\n" +
                "          <div class=\"product-image\">" +
                "               <img src='" + r.getImageUrl() + "' onerror='this.src=\"images/no_photo_found.png\";' class='img-responsive'>" +
                "           </div>\n" +
                "\n" +
                "           </div>\n" +
                "\n" +
                "           <div class=\"col-md-7 col-sm-12 col-xs-12\">\n" +
                "\n" +
                "               <div class=\"product-deatil\">\n" +
                "\n" +
                "                   <h5 class='name'><a href='./home?action=show_recipe&display_type=search" + SearchCommons.printRecipeTags(r, plan_date, meal_type,keyword) + "'>" + r.getName() + "</a></h5> " +
                "                   <br>" +
                "                   <a class='btn btn-info' href='/home?action=favourite&" + SearchCommons.printRecipeTags(r, plan_date, meal_type,keyword) + "'>Like!</a>" +
                "               </div>\n" +
                "               <div class=\"description\">" +
                "                   </n><p style='color: grey'>Description</p>";

        if (r.getDescription() == null || r.getDescription().equals("null")) {
            out += "<p>No description</p>\n";
        } else {
            out += "<p>" + r.getDescription().substring(0, Math.min(r.getDescription().length(),100)) + "...</p>\n";
        }
        out += "    </div>\n" +
                "               <div class=\"product-info smart-form\">\n" +
                "\n" +
                "                   <div class=\"row\">\n" +
                "\n" +
                "                       <div class=\"col-md-12\">\n" +
                "\n" +
                "                           <a href='./home?action=add_to_plan" + SearchCommons.printRecipeTags(r, plan_date, meal_type,keyword) +
                "' class='load-more-btn'>Add to Plan</a>\n" +
                "\n" +
                "                           <a href='./home?action=show_recipe&display_type=search" + SearchCommons.printRecipeTags(r, plan_date, meal_type,keyword) + "' class='load-more-btn'>More info</a>\n" +
                "\n" +
                "                       </div>\n" +
                "\n" +
                "                   </div>\n" +
                "\n" +
                "               </div>\n" +
                "\n" +
                "           </div>\n" +
                "\n" +
                "       </div>\n" +
                "    </div>\n" +
                "\n" +
                "   <!-- end product -->\n" +
                "\n" +
                "  </div>\n";
        return out;
    }
%>

<%
    DatabaseOperation dbo = new DatabaseOperation();
    List<RecipeNew> recipes = dbo.getMatchingRecipes(keyword);
    for (RecipeNew r : recipes){
        out.println(printRecipe(r,plan_date,meal_type,keyword));
    }
    if (recipes.size() == 0){
        out.println("<h1>Oops, no result...</h1>");
    }

%>

</body>
</html>
