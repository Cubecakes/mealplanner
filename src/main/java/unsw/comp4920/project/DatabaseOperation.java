package unsw.comp4920.project;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class DatabaseOperation {

    private static Boolean started = false;
    private static Connection connection;
    /**
     *  @method getConnection() connect to database
     *  @return Connection
     */

    private static Connection getConnection(){
        if (!started) {
            String driver = "org.postgresql.Driver";
            String url = "jdbc:postgresql://localhost:5432/mealplanner";
            String username = "postgres";
            String password = "951119";
            connection = null;
            try {
                Class.forName(driver);
                connection = (Connection) DriverManager.getConnection(url, username, password);
                System.out.println("OPEND1");
                DriverManager.getConnection(url, username, password).close();
                System.out.println("CLOSED1");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }
            started = true;
        }
        return connection;
    }

    public static void removePlan(String username, String date, String type, String recipe_id){
        Connection connection = getConnection();
        PreparedStatement statement = null;
        String sql = "DELETE FROM PLANS WHERE username = ? AND plan_date= to_date(?,'DD/MM/YYYY') AND type= ? AND recipe_id=?";

        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, username);
            statement.setString (2, date);
            statement.setString (3, type);
            statement.setString (4, recipe_id);
            System.out.println(statement);
            statement.execute();


            statement.close();

            System.out.println("CLOSED2");
        }catch(SQLException e) {
            e.printStackTrace();
        }

    }
    public static List<Plan> getPlans(User user, java.util.Date date, String type){
        Connection connection = getConnection();
        System.out.println("OPEND3");
        String sql = "SELECT username, plan_date, type, recipe_id FROM PLANS WHERE username = ? AND plan_date= ? AND type= ?";
        PreparedStatement statement = null;
        List<Plan> plans = new ArrayList<Plan>();
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);


            System.out.println("CLOSED3");
            statement.setString (1, user.getUsername());
            statement.setDate   (2, new Date(date.getTime()));
            statement.setString (3, type);
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                try {
                    Plan plan =
                    new Plan(user
                            , df.parse(rs.getString("plan_date"))
                            , MealTypes.valueOf(rs.getString("type"))
                            , getRecipe(rs.getString("recipe_id")));
                    plans.add(plan);
                }catch(ParseException e){
                    e.printStackTrace();
                }
            }

            statement.close();

        }catch(SQLException e) {
            e.printStackTrace();
        }
        return plans;
    }

    public static RecipeNew getRecipe(String id){
        String sql = "SELECT id, name, description, ingredients, url, image_url, cook_time, prep_time, time_stamp FROM recipes WHERE id=?";
        PreparedStatement statement = null;
        //int length = plan.getFoodList().size();
        Connection connection = getConnection();
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()){
                String name        = rs.getString("name");
                String description = rs.getString("description");
                String ingredients = rs.getString("ingredients");
                String url         = rs.getString("url");
                String imageUrl    = rs.getString("image_url");
                Long unixTime      = rs.getLong  ("time_stamp");
                String cookTime    = rs.getString("cook_time");
                String prepTime    = rs.getString("prep_time");
                return new RecipeNew(id,name,description,ingredients,url,imageUrl,unixTime,cookTime,prepTime);
            }
            statement.close();

        }catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<RecipeNew> getMatchingRecipes(String keyword){
        keyword = keyword.toLowerCase();
        String sql = "SELECT id, name, ingredients, description, url, image_url, cook_time, prep_time, time_stamp FROM recipes WHERE name LIKE ?";
        PreparedStatement statement = null;
        //int length = plan.getFoodList().size();
        Connection connection = getConnection();
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, "%"+keyword+"%");
            ResultSet rs = statement.executeQuery();
            List<RecipeNew> list = new ArrayList<RecipeNew>();
            while (rs.next()){
                String id          = rs.getString("id");
                String name        = rs.getString("name");
                String description = rs.getString("description");
                String ingredients = rs.getString("ingredients");
                String url         = rs.getString("url");
                String imageUrl    = rs.getString("image_url");
                Long unixTime      = rs.getLong  ("time_stamp");
                String cookTime    = rs.getString("cook_time");
                String prepTime    = rs.getString("prep_time");
                list.add(new RecipeNew(id,name,description,ingredients,url,imageUrl,unixTime,cookTime,prepTime));
            }
            statement.close();

            return list;
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int addRecipe(RecipeNew r){
        Connection connection = getConnection();
        String sql = "INSERT INTO Recipes (id,name, description,ingredients,url,image_url,cook_time,prep_time,time_stamp) " +
                "                   VALUES(? ,?   ,?           ,?          ,?  ,?        ,?        ,?        ,?)";
        PreparedStatement statement = null;
        //int length = plan.getFoodList().size();
        System.out.println("ADDING " + r.getDescription());
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, r.getId());
            statement.setString (2, r.getName());
            statement.setString (3, r.getDescription());
            statement.setString (4, r.getIngredients());
            statement.setString (5, r.getUrl());
            statement.setString (6, r.getImageUrl());
            statement.setString (7, r.getCookTime());
            statement.setString (8, r.getPrepTime());
            statement.setLong   (9, r.getUnixTime());
            statement.executeUpdate();
            statement.close();

        }catch(SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * @method insert a new user into table "users", used for user registration,should be called
     *          each time when food is added by users
     * @param  plan object intended to add into database
     * @return integer, the number of record inserted successfully
     */
    public static int insertPlan(Plan plan) {
        Connection connection = getConnection();
        System.out.println("OPENED5");
        String sql = "INSERT INTO PLANS (username,plan_date,type,recipe_id) VALUES(?,?,?,?)";
        PreparedStatement statement = null;
        int r=0;
        int count=0;
        //int length = plan.getFoodList().size();
        try {
            //for(int i=0;i<length;i++) {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, plan.getUser().getUsername());
            statement.setDate   (2, new Date(plan.getDate().getTime()));
            statement.setString (3, plan.getType().toString());
            //statement.setString (4, plan.getFoodList().get(0).getID());
            statement.setString (4, plan.getRecipe().getId());
            System.out.println(statement.toString());
            r = statement.executeUpdate();
                //if(r!=0) {
                  //  count++;
                //}
            //}
            statement.close();
            System.out.println("CLOSED5");
        }catch(SQLException e) {
            e.printStackTrace();
        }

        return count;
    }



    /**
     * @method userExists() go through "users" table in database and check if the user exists
     * @param username
     * @return boolean true if exists, false if user doesn't exist
     **/
    public static boolean userExists(String username) throws SQLException {
        boolean flag = false;
        System.out.println("OPENED7");
        Connection connection = getConnection();
        System.out.println("OPEDN6");
        String sql = "select * from users";
        PreparedStatement pstmt;
        try {
            pstmt = (PreparedStatement)connection.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                //System.out.println(rs.getString(1));
                if(username.equals(rs.getString(1))){
                    flag = true;
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("CLOSED6");
        return flag;
    }

    /**
     * @method look into database check if the password matches the username
     * @param username,password
     * @return boolean
     */
    public static boolean checkPassword(String username, String password) throws SQLException {
        boolean flag = false;
        Connection connection = getConnection();
        System.out.println("OPEDN7");
        String sql = "select password from users where username='"+username+"'";
        PreparedStatement pstmt;
        pstmt = (PreparedStatement)connection.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            //System.out.println(rs.getString(1));
            if(password.equals(rs.getString(1))){
                flag = true;
                break;
            }
        }

        System.out.println("CLOSED7");
        return flag;
    }


    /**
     * @method search database to check if user account is active
     * @param username
     * @return boolean
     */
    public static boolean isActive(String username) throws SQLException {
        boolean flag = false;

        Connection connection = getConnection();
        System.out.println("OPEDN8");
        String sql = "select is_Active from users where username='"+username+"';";
        PreparedStatement pstmt;
        pstmt = (PreparedStatement)connection.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            if(rs.getString(1).equals("true") || rs.getString(1).equals("t")){
                flag = true;
                break;
            }
        }

        System.out.println("CLOSED8");
        return flag;
    }

    public static String getActivationCode(String username){
        try{
            Connection connection = getConnection();
            System.out.println("OPENED9");
            int i = 0;

            String sql = "select activateCode from ActivationCodes where username = '" + username + "'";
            Statement queryStatement = connection.createStatement();
            ResultSet rs = queryStatement.executeQuery(sql);
            if(rs.next()) {
                return rs.getString(1);
            }

            System.out.println("CLOSED9");
        }catch (SQLException e){
            e.printStackTrace();
        }
        return "";
    }

    /**
     * @method addUser(String,String,String,String) insert a user into users table
     * @return void
     */
    public static int addUser(String username, String password, String email, String gender, String photo,String active,String start, String activationCode) throws SQLException {
        Connection connection = getConnection();
        System.out.println("OPEND10");
        int i=0;
        System.out.println("adding user\n**************");
        {
            String sql = "insert into users (username,password,email,gender,photourl,is_active,start) " +
                    "values ('" + username + "','" + password + "','" + email + "','" + gender + "','" + photo + "','" + active + "','" + start + "');";
            PreparedStatement pstmt;
            pstmt = (PreparedStatement) connection.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
        }
        {
            String sql = "insert into activationcodes (username,activateCode) " +
                    "values ('" + username + "','" + activationCode +"');";
            System.out.println(sql);
            PreparedStatement pstmt;
            pstmt = (PreparedStatement) connection.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
        }

        System.out.println("CLOSED10");
        return i;
    }


    /**
     * @method activateUser(String) set an account active
     * @param username
     * @reutnr int
     */
    public static int activateUser(String username) throws SQLException {
        int i=0;
        Connection connection = getConnection();
        System.out.println("OPEDN11");
        String sql = "update users set is_active='true' where username='"+username+"';";
        PreparedStatement preparedStatement;
        try{
            System.out.println("activating user " + username);
            System.out.println(sql);
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            i = preparedStatement.executeUpdate();
            preparedStatement.close();

        }catch (SQLException e){
            e.printStackTrace();
        }

        System.out.println("CLOSED11");
        return i;
    }

    /**
     * @method get all information of a user from database
     * @param username
     * @return User object
     */
    public static User getUserProfile(String username) throws SQLException {
        User user = new User();
        user.setUsername(username);
        Connection connection = getConnection();
        System.out.println("OPEDN12");
        int i=0;
        String sql = "select password from users where username='"+username+"';";
        Statement querystatement = connection.createStatement();
        ResultSet rs =querystatement.executeQuery(sql);
        if(rs.next()) {
            user.setPassword(rs.getString(1));
            sql= "select email from users where username='"+username+"';";
            rs =querystatement.executeQuery(sql);
            if(rs.next()) {
                user.setEmail(rs.getString(1));
            }

            sql = "select gender from users where username='"+username+"';";
            rs =querystatement.executeQuery(sql);
            if(rs.next()) {
                if(rs.getString(1).equals("F")){
                    user.setGender("Female");
                }else{
                    user.setGender("Male");
                }
            }

            sql = "select photourl from users where username='"+username+"';";
            rs =querystatement.executeQuery(sql);
            if(rs.next()) {
                user.setPhotourl(rs.getString(1));
            }

            sql = "select is_active from users where username='"+username+"';";
            rs =querystatement.executeQuery(sql);
            if(rs.next()) {
                user.setActive(Boolean.parseBoolean(rs.getString(1)));
            }

            sql = "select start from users where username='"+username+"';";
            rs =querystatement.executeQuery(sql);
            if(rs.next()) {
                java.util.Date dNow = new java.util.Date();
                SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                String start = ft.format(dNow).toString();
                user.setStart(start);
            }

            sql = "select * from likeRecipe where username='"+username+"';";
            rs = querystatement.executeQuery(sql);
            while(rs.next()){
                RecipeNew recipe = getRecipe(rs.getString("recipe_id"));
                user.addToFavouriteList(recipe);
            }
        }

        System.out.println("CLOSEd12");
        return user;
    }


    /**
     * @method activateUser(String) set an account active
     * @param username
     * @reutnr int
     */
    public static int updateUserInfo(String username, String attribute, String value) throws SQLException {
        int i=0;
        Connection connection = getConnection();
        System.out.println("OPEDN13");
        String sql = "update users set "+ attribute + "='"+ value +"' where username='"+username+"';";
        PreparedStatement preparedStatement;
        try{
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            i = preparedStatement.executeUpdate();
            preparedStatement.close();

        }catch (SQLException e){
            e.printStackTrace();
        }

        System.out.println("CLOSED13");
        return i;
    }

    /**
     * @method addFavourite(String,String) insert a user into users table
     * @return void
     */
    public static int addFavourite(String username,RecipeNew recipe) throws SQLException {
        Connection connection = getConnection();
        int i=0;
        System.out.println("adding user\n**************");
        {
            String sql = "select count(*) from likeRecipe where username="+username+" and recipe_id="+recipe.getId()+";";
            PreparedStatement pstmt;
            pstmt = (PreparedStatement)connection.prepareStatement(sql);

            sql = "insert into likeRecipe (username,recipe_id)" +
                    "values ('" + username + "','" + recipe.getId()+"');";

            pstmt = (PreparedStatement) connection.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
        }



        return i;
    }
}