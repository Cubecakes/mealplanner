package unsw.comp4920.project;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Plan {
    User user;
    Date date;
    MealTypes type; //breakfast/lunch/dinner
    //List<Food> foodList;
    Recipe recipe;

    public Plan(User user, Date date, MealTypes type, Recipe recipe) {
        this.user = user;
        this.date = date;
        this.type = type;
        //foodList = new ArrayList<Food>();
        this.recipe = recipe;
    }

    public Plan(){

        //foodList = new ArrayList<Food>();
        //recipe = new ArrayList<Recipe>();
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getDate() {
        return date;
    }

    public void setType(MealTypes type) {
        this.type = type;
    }

    public MealTypes getType() {
        return type;
    }

    public void setRecipe(Recipe recipe){//List<Food> foodList) {

        //this.foodList = foodList;
        this.recipe = recipe;
    }



    public Recipe getRecipe(){
        return recipe;
    }


}
