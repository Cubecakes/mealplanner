package unsw.comp4920.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class JspUtils {
    public static String printRow(String heading, Calendar startDate){
        Calendar c = (Calendar) startDate.clone();
        String ret = "";
        ret += "<tr style=\"height: 33%\">\n";
        ret += "<td>" + heading + "</td>\n";
        for (int i = 0; i < 7; i++) {
            ret += "<td>";
            ret += "<form action=\"./add_meal.jsp\" method=\"get\">\n";
            ret += "<input type=\"hidden\" name=\"meal_type\" value=\""+heading+"\">";
            SimpleDateFormat f = new SimpleDateFormat("dd-MM-yyyy");
            ret += "<input type=\"hidden\" name=\"plan_date\" value=\""+f.format(c.getTime())+"\">";
            ret += "<button style=\"width: 100%;\"  class=\"btn btn-primary\">\n";
            ret += "Add meal!";
            ret += "</button>\n";
            ret += "</form>\n";
            ret += "</td>\n";

            c.add(Calendar.DATE, 1);
        }

        ret += "</tr>\n";
        return ret;
    }
}
