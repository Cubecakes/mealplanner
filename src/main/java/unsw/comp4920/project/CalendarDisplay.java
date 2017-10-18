package unsw.comp4920.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class CalendarDisplay {
    public static String calendarToDate(Calendar c){
        SimpleDateFormat f = new SimpleDateFormat("dd-MM-yyyy");
        return f.format(c.getTime());
    }
    private static String generateAddFoodButton(String date, MealTypes mealType){
        String heading = mealType.toString();
        String ret = "";
        ret += "<form action=\"./add_meal.jsp\" method=\"get\">\n";
        ret += "<input type=\"hidden\" name=\"meal_type\" value=\"" + heading + "\">";


        ret += "<input type=\"hidden\" name=\"plan_date\" value=\"" + date + "\">";

        ret += "<button style=\"width: 100%;\"  class=\"btn btn-primary\">\n";
        ret += "Add meal!";
        ret += "</button>\n";
        ret += "</form>\n";
        return ret;
    }

    private static String generateDisplayFood(List<Food> foods){
        String ret = "";
        for (Food f : foods) {
            ret += "Food: " + f.getName() + "<br> Calories : " + f.getCalorie() + "<br>";
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
            List<Food> foundFoods = dbo.getFoods(username,calendarToDate(c),heading);
            ret += "<td>";

            ret += generateDisplayFood(foundFoods);
            ret += generateAddFoodButton(calendarToDate(c),mealType);

            ret += "</td>\n";

            c.add(Calendar.DATE, 1);
        }

        ret += "</tr>\n";
        return ret;
    }

    public static String printCalendarColumn(String d, String username){
        DatabaseOperation dbo = new DatabaseOperation();
        String retString = "" +
            "<table class=`table table-bordered` style=`height: 800px`>".replace('`','"') +
            "<thead> <tr>" +
            "<th>Meal</th> </th>";
        List<Food> foundFoods = dbo.getFoods(username,d,MealTypes.Breakfast.toString());
        retString +=
            "<tr>"+
            generateDisplayFood(foundFoods)+
            generateAddFoodButton(d,MealTypes.Breakfast)+
            "</tr>";

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
