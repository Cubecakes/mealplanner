package unsw.comp4920.project;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PlanUnit {
    User user;
    Date date;
    MealTypes type; //breakfast/lunch/dinner
    //List<Food> foodList;
    List<Recipe> recipeList;

    public PlanUnit(User user, Date date, MealTypes type) {
        this.user = user;
        this.date = date;
        this.type = type;
        //foodList = new ArrayList<Food>();
        recipeList = new ArrayList<Recipe>();
    }

    public PlanUnit(){

        //foodList = new ArrayList<Food>();
        recipeList = new ArrayList<Recipe>();
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

    public void setRecipeList(List<Recipe> recipeList){//List<Food> foodList) {

        //this.foodList = foodList;
        this.recipeList = recipeList;
    }

    public void addToRecipeList(Recipe recipe){ //(Food food){

        //foodList.add(food);
        recipeList.add(recipe);
    }

    public List<Recipe> getRecipeList(){
        return recipeList;
    }


}
