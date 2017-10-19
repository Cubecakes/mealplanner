package unsw.comp4920.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class CalendarDisplay {
    public static String formatCalendar(Calendar c){
        SimpleDateFormat f = new SimpleDateFormat("dd-MM-yyyy");
        return f.format(c.getTime());
    }
    public static String formatDate(Date d){
        SimpleDateFormat f = new SimpleDateFormat("dd-MM-yyyy");
        return f.format(d.getTime());
    }
    private static String generateAddFoodButton(Calendar c, String heading){
        String ret = "";
        ret += "<form action=\"./home\" method=\"get\">\n";

        ret += "<input type=\"hidden\" name=\"meal_type\" value=\"" + heading + "\">";

        ret += "<input type=\"hidden\" name=\"action\" value=\"search\">";
        ret += "<input type=\"hidden\" name=\"plan_date\" value=\"" + formatCalendar(c) + "\">";

        ret += "<button style=\"width: 100%;\"  class=\"btn btn-outline-info\">\n";
        ret += "Add meal!";
        ret += "</button>\n";
        ret += "</form>\n";
        return ret;
    }

    private static String generateDisplayFood(List<Plan> plans){//(List<Food> foods){
        String ret = "";
        for (Plan p : plans) {
            //ret += "Food: " + f.getName() + "<br> Calories : " + f.getCalorie() + "<br>";
            ret += "<form action=\"./home\" method=\"get\">\n";

            ret += "<input type=\"hidden\" name=\"meal_type\" value=\"" +p.getType()+ "\">";
            ret += "<input type=\"hidden\" name=\"plan_date\" value=\"" +formatDate(p.getDate())+ "\">";
            ret += "<input type=\"hidden\" name=\"recipe_id\" value=\"" +p.getRecipe().getId()+ "\">";
            ret += "<input type=\"hidden\" name=\"username\" value=\""  +p.getUser().getUsername()+ "\">";
            ret += "<input type=\"hidden\" name=\"display_type\" value=\"calendar\">";
            ret += "<input type=\"hidden\" name=\"action\" value=\"show_recipe\">";


            ret += "<button class=\"btn btn-link btn-lg\" style=\"padding:0 !important; white-space: normal\">" + p.getRecipe().getName() + "</button>\n";
            ret += "</form>";
            ret += "<form action=\"./home\" method=\"get\">\n";

            ret += "<input type=\"hidden\" name=\"meal_type\" value=\"" +p.getType()+ "\">";
            ret += "<input type=\"hidden\" name=\"plan_date\" value=\"" +formatDate(p.getDate())+ "\">";
            ret += "<input type=\"hidden\" name=\"recipe_id\" value=\"" +p.getRecipe().getId()+ "\">";
            ret += "<input type=\"hidden\" name=\"username\" value=\""  +p.getUser().getUsername()+ "\">";
            ret += "<input type=\"hidden\" name=\"action\" value=\"remove_plan\">";


            ret += "<button style=\"width: 100%;\"  class=\"btn btn-outline-danger\"> Remove meal </button>\n";
            ret += "</form>";

        }
        return ret;
    }

    private static String printRow(MealTypes mealType, Calendar startDate, User user){
        DatabaseOperation dbo = new DatabaseOperation();
        Calendar c = (Calendar) startDate.clone();
        String heading = mealType.toString();

        String ret = "";
        ret += "<tr style=\"height: 33%\">\n";
        ret += "<td class=\"table-info\">" + heading + "</td>\n";
        for (int i = 0; i < 7; i++) {
            //List<Food> foundFoods = dbo.getFoods(username,c.getTime(),heading);
            List<Plan> foundPlans = dbo.getPlans(user,c.getTime(),heading);
            System.out.println("plan list length: "+foundPlans.size());
            if(foundPlans.size() > 0) {
               ret += "<td class=\"table-warning\">";
            }else{
               ret += "<td>";
            }

            ret += generateDisplayFood(foundPlans);
            ret += generateAddFoodButton(c,heading);

            ret += "</td>\n";

            c.add(Calendar.DATE, 1);
        }

        ret += "</tr>\n";
        return ret;
    }


    public static String printCalendar(Calendar c, User user){
        String retString = "" +
            "<table class=`table` style=`height: 800px`>".replace('`','"') +
            "<thead> <tr>" +
            "<th class=\"table-success\">Meal</th>";

        Calendar currentCal = (Calendar) (c).clone();
        for (int i = 0; i < 7; i++) {
            SimpleDateFormat f = new SimpleDateFormat("EEEE, dd-MM-yyyy");
            retString += "<th class=\"table-success\">" + f.format(currentCal.getTime()) + "</th>";
            currentCal.add(Calendar.DATE,1);
        }

        retString += "" +
            "</tr> </thead>" +
            "<tbody>" +
            CalendarDisplay.printRow(MealTypes.Breakfast   ,c,user)+
            CalendarDisplay.printRow(MealTypes.Lunch       ,c,user)+
            CalendarDisplay.printRow(MealTypes.Dinner      ,c,user)+
            "</tbody> </table>";
        return retString;
    }
}
