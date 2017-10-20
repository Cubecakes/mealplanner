<%@ page import="unsw.comp4920.project.User" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 27/09/2017
  Time: 4:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <link rel="shortcut icon" href="images/profolio.PNG" type="image/x-icon" />
    <link rel="stylesheet" media="screen" href="css/profile.css">
    <link type="text/css" rel="stylesheet" href="recipe_list.css">
    <link type="text/css" rel="stylesheet" href="css/buttons.css">
    <link type="text/css" rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" ref="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<%@ include file="header.html" %>

<!--%
    User user = (User)request.getSession().getAttribute("currentUser");
    request.setAttribute("currentUser",user);
    //show profile picture in the middle
    //show gender as a icon

    out.println("Username:  "+user.getUsername());
    out.println("<br><br>Email:  "+user.getEmail());
    out.println("<br><br>Gender:  "+user.getGender());
    out.println("<br><br>You have used meal planner for ... days<br><br><center>");
%-->



<div class="contact_wrapper">
    <header class="contact_header">
        <%
            User user = (User)request.getSession().getAttribute("currentUser");
            request.getSession().setAttribute("currentUser",user);
            out.println("<h1 class=\"myname\"> Hello! "+user.getUsername()+".</h1>");
        %>
        <h1 class="myh1">Welcome to Meal Your Day!</h1>
    </header>
    <section>

        <img src="images/<%=user.getPhotourl()%>" onerror="this.src='images/profolio.PNG'">

        <div class="arrow-up"></div>
        <form id="contact" class="form-horizontal" role="form">

            <%
                out.println("<h3 class=\"myh3\">USERNAME:</h3>");
                out.println("<h3 class=\"myh233\">"+user.getUsername()+"</h3>");

                out.println("<h3 class=\"myh3\">email:</h3>");
                out.println("<h3 class=\"myh233\">"+user.getEmail()+"</h3>");

                out.println("<h3 class=\"myh3\">gender:</h3>");
                out.println("<h3 class=\"myh233\">"+user.getGender()+"</h3>");

                out.println("<h3 class=\"myh3\">You have been using meal planner since " + user.getStart().split("-")[2] + "/" + user.getStart().split("-")[1] + "/" + user.getStart().split("-")[0] + " </h3>");

            %>

            <!--button id="send" name="/edit_profile.jsp?username=<!% =user.getUsername()%>" class="btn btn-block">Edit</button-->

            <a href="/edit_profile.jsp?username=<%=user.getUsername()%>" class="btn btn-info btn-block" style="margin-top: 40px;">Edit Profile</a>
        </form>
    </section>
</div>

<%--display user's favourite recipes--%>
<center><div id="display_liked_recipe"  style="width:1200px;margin-top: 950px;"></div></center>
<script type="text/javascript">
    var xmlhttp = new XMLHttpRequest();
    var url = "recipe_test.json";
    var likes = new Array();

    xmlhttp.onreadystatechange = function() {
        var count = 0;
        if(xmlhttp.readyState == 4 && xmlhttp.status == "200") {
            var arr = JSON.parse(xmlhttp.responseText);
            out = "<div class=\"panel panel-default\">\n" +
                "    <div class=\"panel-heading\" style=\"background-color:#CD8C95;\">\n" +
                "        <h3 class=\"panel-title\" style=\"color:white;\">My Favourites</h3>\n" +
                "    </div>\n";
            out += " <div class=\"panel-body\">\n";
           // var size = <%--=user.getFavouriteList().g--%>
            <%
                for(int i=0;i<user.getFavouriteList().size();i++){
                    out.println("likes.push('"+ user.getFavouriteList().get(i).getId()+"')");
                }
            %>
            var count = 0;
            for(i=0;i<arr.length;i++) {
                if(count < likes.length) {
                    for (j = 0; j < likes.length; j++) {
                        if(arr[i]._id['$oid']==likes[j]){
                            out += "<div class=\"col-xs-12 col-md-6\">\n" +
                                "    <div class=\"prod-info-main prod-wrap clearfix\">\n" +
                                "\n" +
                                "      <div class=\"row\">\n" +
                                "\n" +
                                "        <div class=\"col-md-5 col-sm-12 col-xs-12\">\n" +
                                "\n" +
                                "          <div class=\"product-image\">" +
                                "               <img src='" + arr[i].image + "' onerror='this.src=\"images/no_photo_found.png\";' class='img-responsive'>" +
                                "           </div>\n" +
                                "\n" +
                                "           </div>\n" +
                                "\n" +
                                "           <div class=\"col-md-7 col-sm-12 col-xs-12\">\n" +
                                "\n" +
                                "               <div class=\"product-deatil\">\n" +
                                "                   <h5 class='name'><a href='./home?action=show_recipe&&display_type=profile&&search_keyword=myFavourite&&recipe_id="+arr[i]._id['$oid']+"&&recipe_name="+arr[i].name+"'>" + arr[i].name + "</a></h5> " +
                                "                   <br>" +
                                "               </div>\n" +
                                "               <div class=\"description\">" +
                                "                   </n><p style='color: grey'>Description</p>";

                            if (arr[i].description == null) {
                                out += "<p>No description</p>\n";
                            } else {
                                out += "<p>" + arr[i].description.substring(0, 100) + "...</p>\n";
                            }

                            out += "            </div>\n" +
                                "               <div class=\"product-info smart-form\">\n" +
                                "\n" +
                                "                   <div class=\"row\">\n" +
                                "\n" +
                                "                       <div class=\"col-md-12\">\n" +
                                "\n" +
                                "                           <button type=\"button\" class='load-more-btn' data-toggle=\"modal\" data-target='#addMeal'>\n" +
                                "                               Add to Plan\n" +
                                "                           </button>\n"+
                                "\n" +
                                "                           <a href='./home?action=show_recipe&&display_type=profile&&search_keyword=myFavourite&&recipe_id="+arr[i]._id['$oid']+"&&recipe_name="+arr[i].name+"' class='load-more-btn'>More Info</a> " +
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
                            //out += arr[i]._id['$oid'].
                            count += 1;
                        }
                    }
                }else{
                    break;
                }
            }
            //out += "hhahaha";
            out += " </div>\n";
            out += "</div>\n";
        }
        document.getElementById("display_liked_recipe").innerHTML = out;
    };

    xmlhttp.open("GET", url, true);
    xmlhttp.send();
</script>

<div id="particles-js"></div>

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
                    <input type="hidden" name="parent_page" value="profile">
                    <input type="submit" class="load-more-btn" value="Add">
                </center></div>
            </form>
        </div>
    </div>
</div>


<script src="/js/particles.js"></script>
<script src="/js/app.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</body>
</html>