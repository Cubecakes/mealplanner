<%@ page import="unsw.comp4920.project.User" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="unsw.comp4920.project.JspUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 25/09/2017
  Time: 9:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%!
    public String printRow(String heading){
        String ret = "";
        ret += "<tr style=\"height: 33%\">\n";
        ret += "<td>" + heading + "</td>\n";
            for (int i = 0; i < 7; i++) {
                ret += "<td>";
                    ret += "<form action=\"./add_meal.jsp\" method=\"get\">\n";
                        ret += "<input type=\"hidden\" name=\"meal\" value=\""+heading+"\">";
                        ret += "<input type=\"hidden\" name=\"day\" value=\""+i+"\">";
                        ret += "<button style=\"width: 100%;\"  class=\"btn btn-primary\">\n";
                            ret += "Add meal!";
                        ret += "</button>\n";
                    ret += "</form>\n";
                ret += "</td>\n";
            }

        ret += "</tr>\n";
        return ret;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%@ include file="header.html" %>

<%
    HttpSession s = request.getSession();
    Calendar cal = (Calendar) ((Calendar)s.getAttribute("currentDate")).clone();
    User user = (User)s.getAttribute("currentUser");
    out.println("<h1> Hello "+user.getUsername()+"</h1>");

%>

<ul class="nav justify-content-center">
    <li class="nav-item " style="font-size: 24px">
        <a class="nav-link" href="./home?action=prev_week" title="prev_week" target="_self">Prev week</a>
    </li>

    <li class="nav-item " style="font-size: 24px">
        <a class="nav-link" href="./home?action=curr_week" title="curr_week" target="_self">Current week</a>
    </li>

    <li class="nav-item " style="font-size: 24px">
        <a class="nav-link" href="./home?action=next_week" title="next_week" target="_self">Next week</a>
    </li>
</ul>

<table class="table table-bordered" style="height: 800px">
    <thead>
    <tr>
        <th>Meal</th>
        <%
            Calendar currentCal = (Calendar) ((Calendar)s.getAttribute("currentDate")).clone();
            for (int i = 0; i < 7; i++) {
                SimpleDateFormat f = new SimpleDateFormat("EEEE, dd-MM-yyyy");
                out.println("<th>" + f.format(currentCal.getTime()) + "</th>");
                currentCal.add(Calendar.DATE,1);
            }
        %>
    </tr>
    </thead>
    <tbody>
    <%= JspUtils.printRow("Breakfast"   ,cal) %>
    <%= JspUtils.printRow("Lunch"       ,cal) %>
    <%= JspUtils.printRow("Dinner"      ,cal) %>
    </tbody>


</table>




</body>
</html>
