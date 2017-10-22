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

    private static String getString(JsonObject o, String s){

        String ret = (o.get(s) == null || o.get(s).toString().equals("null")) ? null : o.get(s).getAsString();
        return ret;
    }

    public static void main(String [ ] args) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader("recipe_test.json"));
        for (String line = br.readLine(); line != null; line = br.readLine()) {
            System.out.println(line);
            //Map<String,Object> flattened = JsonFlattener.flattenAsMap(line);
            //System.out.println(flattened);
            JsonElement root = new JsonParser().parse(line);

            for (JsonElement e : root.getAsJsonArray()){
                System.out.println("\n\n****************");
                JsonObject o = e.getAsJsonObject();
                System.out.println(e.getAsJsonObject());
                System.out.println(e.getAsJsonObject().keySet());
                System.out.println(e.getAsJsonObject().get("description"));
                System.out.println(e.getAsJsonObject().get("description"));



                String id          = o.get("_id").getAsJsonObject().get("$oid").getAsString();
                String name        = o.get("name").getAsString();
                String description = getString(o, "description");
                String ingredients = getString(o, "ingredients");
                String url         = getString(o, "url");
                String imageUrl    = getString(o, "image");
                Long unixTime      = o.get("ts").getAsJsonObject().get("$date").getAsLong();
                String cookTime    = getString(o, "cookTime");
                String prepTime    = getString(o, "prepTime");

                RecipeNew recipe = new RecipeNew(id,name,description,ingredients,url,imageUrl,unixTime,cookTime,prepTime);
                DatabaseOperation.addRecipe(recipe);
                if(recipe.getUnixTime() !=null){
                    SimpleDateFormat sdf = new SimpleDateFormat("MMMM d, yyyy 'at' h:mm a");
                    String date = sdf.format(recipe.getUnixTime());
                    System.out.println("Published date: "+ date + " " + recipe.getUnixTime());
                }
            }
        }

    }
}
