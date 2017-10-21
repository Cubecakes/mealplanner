package unsw.comp4920.project;

public class RecipeNew {
    public RecipeNew(String id, String name, String description, String ingredients, String url, String imageUrl, Long unixTime, String cookTime, String prepTime) {
        this.id = id;
        this.name = name;
        this.ingredients = ingredients;
        this.url = url;
        this.imageUrl = imageUrl;
        this.unixTime = unixTime;
        this.cookTime = cookTime;
        this.prepTime = prepTime;
        this.description = description;
    }

    public String getId() {

        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Long getUnixTime() {
        return unixTime;
    }

    public void setUnixTime(Long unixTime) {
        this.unixTime = unixTime;
    }

    public String getCookTime() {
        return cookTime;
    }

    public void setCookTime(String cookTime) {
        this.cookTime = cookTime;
    }

    public String getPrepTime() {
        return prepTime;
    }

    public void setPrepTime(String prepTime) {
        this.prepTime = prepTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    private String id;
    private String name;
    private String ingredients;
    private String url;
    private String imageUrl;
    private Long unixTime;
    private String cookTime;
    private String prepTime;
    private String description;
}
