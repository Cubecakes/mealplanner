package unsw.comp4920.project;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PlanUnit {
    User user;
    Date date;
    MealTypes type; //breakfast/lunch/dinner
    List<Food> foodList;

    public PlanUnit(User user, Date date, MealTypes type) {
        this.user = user;
        this.date = date;
        this.type = type;
        foodList = new ArrayList<Food>();
    }

    public PlanUnit(){
        foodList = new ArrayList<Food>();
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

    public void setFoodlist(List<Food> foodList) {
        this.foodList = foodList;
    }

    public void addToFoodList(Food food){
        foodList.add(food);
    }

    public List<Food> getFoodList(){
        return foodList;
    }
}
