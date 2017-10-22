package unsw.comp4920.project;

public class SearchCommons {
    public static String printRecipeTags (RecipeNew r, String plan_date, String meal_type, String keyword){
        return "&plan_date=" + plan_date + "&&meal_type=" +meal_type+"&&recipe_id=" + r.getId() +"&&recipe_name=" + r.getName() + "&&search_keyword=" + keyword;
    }
}
