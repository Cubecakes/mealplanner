<%--suppress ALL --%>
<%--
  Created by IntelliJ IDEA.
  User: luyibest001
  Date: 14/10/2017
  Time: 2:30 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Search Results</title>
    <link type="text/css" rel="stylesheet" href="recipe_list.css">
    <link type="text/css" rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" ref="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<%@ include file="header.html" %>
<div id="demo" class="container"></div>

<script type="text/javascript">
    var xmlhttp = new XMLHttpRequest();
    var url = "recipe_test.json";

    xmlhttp.onreadystatechange = function() {

        if(xmlhttp.readyState == 4 && xmlhttp.status == "200"){
            var arr = JSON.parse(xmlhttp.responseText);
            out = "";
            var count = 0;
            var keyword = '<%=(String)request.getAttribute("search_keyword")%>';
            keyword = keyword.toLowerCase();
            for(i=0;i<arr.length;i++){
                var temp_ingredients = arr[i].ingredients;
                temp_ingredients = temp_ingredients.toLowerCase();
                var temp_name = arr[i].name;
                temp_name = temp_name.toLowerCase();

                if(temp_ingredients.includes(keyword)==true || temp_name.includes(keyword)) {

                    out += "<div class=\"col-xs-12 col-md-6\">\n" +
                        "    <div class=\"prod-info-main prod-wrap clearfix\">\n" +
                        "\n" +
                        "      <div class=\"row\">\n" +
                        "\n" +
                        "        <div class=\"col-md-5 col-sm-12 col-xs-12\">\n" +
                        "\n" +
                        "          <div class=\"product-image\">"+
                        "               <img src='"+arr[i].image+"' onerror='this.src=\"images/logonew.png\";' class='img-responsive'>" +
                        "           </div>\n" +
                        "\n" +
                        "           </div>\n" +
                        "\n" +
                        "           <div class=\"col-md-7 col-sm-12 col-xs-12\">\n" +
                        "\n" +
                        "               <div class=\"product-deatil\">\n" +
                        "\n" +
                        "                   <h5 class='name'><a href='./home?action=add_recipe_to_plan&&selected_recipe=" +
                        arr[i]._id['$oid']+ "'>" + arr[i].name + "</a></h5> </div>\n" +
                        "               <div class=\"description\">" +
                        "                   </n><p style='color: grey'>Description</p>";

                        if(arr[i].description==null){
                            out += "<p>No description</p>\n";
                        }else{
                            out += "<p>"+arr[i].description.substring(0,100)+"...</p>\n";
                        }

                        out += "    </div>\n" +
                        "               <div class=\"product-info smart-form\">\n" +
                        "\n" +
                        "                   <div class=\"row\">\n" +
                        "\n" +
                        "                       <div class=\"col-md-12\">\n" +
                        "\n" +
                        "                           <a href='./home?action=add_recipe_to_plan&&selected_recipe="+ arr[i]._id['$oid']+
                        "'                            class='load-more-btn'>Add to Plan</a>\n" +
                        "\n" +
                        "                           <a href='./home?action=show_recipe&&selected_recipe="+ arr[i]._id['$oid']+
                        "'                          class='load-more-btn'>More info</a>\n" +
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
                }
            }

        }
        document.getElementById("demo").innerHTML = out;
    };

    //btn btn-info
    xmlhttp.open("GET", url, true);
    xmlhttp.send();

</script>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</body>
</html>
