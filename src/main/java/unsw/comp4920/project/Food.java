package unsw.comp4920.project;

public class Food {
    private String name;
    private int calorie;
    private int sugar;
    private int protein;
    private String category;

    public Food(String name, int calorie, String category) {
        this.name = name;
        this.calorie = calorie;
    }

    public Food(){}

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setCalorie(int calorie) {
        this.calorie = calorie;
    }

    public int getCalorie() {
        return calorie;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public int getProtein() {
        return protein;
    }

    public void setProtein(int protein) {
        this.protein = protein;
    }

    public int getSugar() {
        return sugar;
    }

    public void setSugar(int sugar) {
        this.sugar = sugar;
    }
}
