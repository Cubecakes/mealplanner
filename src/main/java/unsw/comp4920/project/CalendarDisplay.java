package unsw.comp4920.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class CalendarDisplay {
    private static String generateAddFoodButton(Calendar date, String heading){
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

    private static String generateDisplayFood(List<Recipe> recipes){//(List<Food> foods){
        String ret = "";
        for (Recipe r : recipes) {
            //ret += "Food: " + f.getName() + "<br> Calories : " + f.getCalorie() + "<br>";
            System.out.println(r);
            //ret += "Recipe: " + r.getName()+ "<br>";
        }
        return ret;
    }

    private static String printRow(MealTypes mealType, Calendar startDate, String username){
        DatabaseOperation dbo = new DatabaseOperation();
        Calendar c = (Calendar) startDate.clone();
        String heading = mealType.toString();

        String ret = "";
        ret += "<tr style=\"height: 33%\">\n";
        ret += "<td>" + heading + "</td>\n";
        for (int i = 0; i < 7; i++) {
            //List<Food> foundFoods = dbo.getFoods(username,c.getTime(),heading);
            List<Recipe> foundRecipes = dbo.getRecipes(username,c.getTime(),heading);
            System.out.println("recipe list length: "+foundRecipes.size());
            ret += "<td>";

            ret += generateDisplayFood(foundRecipes);
            ret += generateAddFoodButton(c,heading);

            ret += "</td>\n";

            c.add(Calendar.DATE, 1);
        }

        ret += "</tr>\n";
        return ret;
    }

    public static String printCalendar(Date d, String username){
        String retString = "" +
            "<table class=`table table-bordered` style=`height: 800px`>".replace('`','"') +
            "<thead> <tr>" +
            "<th>Meal</th>";

            //retString +=

        return retString;
    }

    public static String printCalendar(Calendar c, String username){
        String retString = "" +
            "<table class=`table table-bordered` style=`height: 800px`>".replace('`','"') +
            "<thead> <tr>" +
            "<th>Meal</th>";

        Calendar currentCal = (Calendar) (c).clone();
        for (int i = 0; i < 7; i++) {
            SimpleDateFormat f = new SimpleDateFormat("EEEE, dd-MM-yyyy");
            retString += "<th>" + f.format(currentCal.getTime()) + "</th>";
            currentCal.add(Calendar.DATE,1);
        }

        retString += "" +
            "</tr> </thead>" +
            "<tbody>" +
            CalendarDisplay.printRow(MealTypes.Breakfast   ,c,username)+
            CalendarDisplay.printRow(MealTypes.Lunch       ,c,username)+
            CalendarDisplay.printRow(MealTypes.Dinner      ,c,username)+
            "</tbody> </table>";
        return retString;
    }
}
