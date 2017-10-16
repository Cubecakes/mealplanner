package unsw.comp4920.project;

public class Food {
    private String name;
    private int calorie;
    private int sugar;
    private int protein;
    private String id;
    private String category;

    public Food(String name, int calorie, String category, String id) {
        this.name = name;
        this.calorie = calorie;
        this.category = category;
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public String getID() {
        return this.id;
    }

    public void setCalorie(int calorie) {
        this.calorie = calorie;
    }

    public Integer getCalorie() {
        return calorie;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public Integer getProtein() {
        return protein;
    }

    public void setProtein(int protein) {
        this.protein = protein;
    }

    public Integer getSugar() {
        return sugar;
    }

    public void setSugar(int sugar) {
        this.sugar = sugar;
    }
}
