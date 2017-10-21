package unsw.comp4920.project;

import com.github.wnameless.json.flattener.JsonFlattener;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.Map;

public class ParseJson {


    public static void main(String [ ] args) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader("recipe_test.json"));
        for (String line = br.readLine(); line != null; line = br.readLine()) {
            System.out.println(line);
            //Map<String,Object> flattened = JsonFlattener.flattenAsMap(line);
            //System.out.println(flattened);
            JsonElement root = new JsonParser().parse(line);
            DatabaseOperation dbo = new DatabaseOperation();
            for (JsonElement e : root.getAsJsonArray()){
                System.out.println(e);
                JsonObject o = e.getAsJsonObject();
                System.out.println(e.getAsJsonObject().get("_id").getAsJsonObject().get("$oid"));
                System.out.println(e.getAsJsonObject().get("ts"));
                System.out.println(e.getAsJsonObject().keySet());

                String id          = o.get("_id").getAsJsonObject().get("$oid").toString();
                String name        = o.get("name").toString();
                String description = o.get("description") == null ? null : o.get("description").toString();
                String ingredients = o.get("ingredients") == null ? null : o.get("ingredients").toString();
                String url         = o.get("url") == null ? null : o.get("url").toString();
                String imageUrl    = o.get("image") == null ? null : o.get("image").toString();
                Long unixTime      = o.get("ts").getAsJsonObject().get("$date").getAsLong();
                String cookTime    = o.get("cookTime") == null ? null : o.get("cookTime").toString();
                String prepTime    = o.get("prepTime") == null ? null : o.get("prepTime").toString();

                RecipeNew recipe = new RecipeNew(id,name,description,ingredients,url,imageUrl,unixTime,cookTime,prepTime);
                dbo.addRecipe(recipe);
                if(recipe.getUnixTime() !=null){
                    SimpleDateFormat sdf = new SimpleDateFormat("MMMM d, yyyy 'at' h:mm a");
                    String date = sdf.format(recipe.getUnixTime());
                    System.out.println("Published date: "+ date + " " + recipe.getUnixTime());
                }
            }
        }

    }
}
