package unsw.comp4920.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class JspUtils {
    public static String generateAddFoodButton(Calendar date, String heading){
        String ret = "";
        ret += "<form action=\"./add_meal.jsp\" method=\"get\">\n";
        ret += "<input type=\"hidden\" name=\"meal_type\" value=\"" + heading + "\">";
        SimpleDateFormat f = new SimpleDateFormat("dd-MM-yyyy");

        ret += "<input type=\"hidden\" name=\"plan_date\" value=\"" + f.format(date.getTime()) + "\">";

        ret += "<button style=\"width: 100%;\"  class=\"btn btn-primary\">\n";
        ret += "Add meal!";
        ret += "</button>\n";
        ret += "</form>\n";
        return ret;
    }

    public static String generateDisplayFood(List<Food> foods){
        String ret = "";
        for (Food f : foods) {
            ret += "Food: " + f.getName() + "<br> Calories : " + f.getCalorie() + "<br>";
        }
        return ret;
    }

    public static String printRow(String heading, Calendar startDate, String username){
        DatabaseOperation dbo = new DatabaseOperation();
        Calendar c = (Calendar) startDate.clone();

        String ret = "";
        ret += "<tr style=\"height: 33%\">\n";
        ret += "<td>" + heading + "</td>\n";
        for (int i = 0; i < 7; i++) {
            List<Food> foundFoods = dbo.getFoods(username,c.getTime(),heading);
            ret += "<td>";

            ret += generateDisplayFood(foundFoods);
            ret += generateAddFoodButton(c,heading);

            ret += "</td>\n";

            c.add(Calendar.DATE, 1);
        }

        ret += "</tr>\n";
        return ret;
    }
}
