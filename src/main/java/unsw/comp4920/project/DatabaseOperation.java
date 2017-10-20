package unsw.comp4920.project;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class DatabaseOperation {

    /**
     *  @method getConnection() connect to database
     *  @return Connection
     */
    public Connection getConnection(){
        String driver = "org.postgresql.Driver";
        String url = "jdbc:postgresql://localhost:5432/mealplanner";
        String username = "postgres";
        String password = "951119";
        Connection c = null;
        try {
            Class.forName(driver);
            c = (Connection) DriverManager.getConnection(url, username, password);

        }catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        return c;
    }

    /*private Food parseFood(ResultSet rs){
        try {
            String ID = rs.getString(1);
            String name = rs.getString(2);
            Integer calorie = rs.getInt(3);
            String category = rs.getString(6);
            return new Food(name,calorie,category,ID);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }*/

    /*public Food getFood(String ID){
        Connection connection = getConnection();
        String sql = "SELECT * FROM food WHERE id = ?";
        PreparedStatement statement = null;
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, ID);
            ResultSet rs = statement.executeQuery();
            if (rs.next()){
                return parseFood(rs);
            }
            statement.close();
            connection.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return null;

    }*/

   /* public List<Food> getFoods(String username, java.util.Date date, String type){
        Connection connection = getConnection();
        String sql = "SELECT foodID FROM PLANS WHERE username = ? AND plan_date= ? AND type= ?";
        PreparedStatement statement = null;
        List<Food> foods = new ArrayList<Food>();
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, username);
            statement.setDate   (2, new java.sql.Date(date.getTime()));
            statement.setString (3, type);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                foods.add(getFood(rs.getString("foodID")));
            }

            statement.close();
            connection.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return foods;
    }*/

    public void removePlan(String username, String date, String type, String recipe_id){
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
            connection.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }

    }
    public List<Plan> getPlans(User user, java.util.Date date, String type){
        Connection connection = getConnection();
        String sql = "SELECT username, plan_date, type, recipe_id, recipe_name FROM PLANS WHERE username = ? AND plan_date= ? AND type= ?";
        PreparedStatement statement = null;
        List<Plan> plans = new ArrayList<Plan>();
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
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
                            , new Recipe(rs.getString("recipe_name"), rs.getString("recipe_id")));
                    plans.add(plan);
                }catch(ParseException e){
                    e.printStackTrace();
                }
            }

            statement.close();
            connection.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return plans;
    }

    public int insertFood(Food f){
        Connection connection = getConnection();

        int r=0;
        String sql = "INSERT INTO food (id,name,calorie,category) VALUES(?,?,?,?)";
        PreparedStatement statement = null;
        //int length = plan.getFoodList().size();
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString (1, f.getID());
            statement.setString (2, f.getName());
            statement.setInt    (3, f.getCalorie());
            statement.setString (4, f.getCategory());
            r = statement.executeUpdate();
            statement.close();
            connection.close();
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
    public int insertPlan(Plan plan) {
        Connection connection = getConnection();
        String sql = "INSERT INTO PLANS (username,plan_date,type,recipe_id,recipe_name) VALUES(?,?,?,?,?)";
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
            statement.setString(5,plan.getRecipe().getName());
            System.out.println(statement.toString());
            r = statement.executeUpdate();
                //if(r!=0) {
                  //  count++;
                //}
            //}
            statement.close();
            connection.close();
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
    public boolean userExists(String username){
        boolean flag = false;

        Connection conn = getConnection();
        String sql = "select * from users";
        PreparedStatement pstmt;
        try {
            pstmt = (PreparedStatement)conn.prepareStatement(sql);
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

        return flag;
    }

    /**
     * @method look into database check if the password matches the username
     * @param username,password
     * @return boolean
     */
    public boolean checkPassword(String username, String password) throws SQLException {
        boolean flag = false;
        Connection conn = getConnection();
        String sql = "select password from users where username='"+username+"'";
        PreparedStatement pstmt;
        pstmt = (PreparedStatement)conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            //System.out.println(rs.getString(1));
            if(password.equals(rs.getString(1))){
                flag = true;
                break;
            }
        }

        return flag;
    }


    /**
     * @method search database to check if user account is active
     * @param username
     * @return boolean
     */
    public boolean isActive(String username) throws SQLException {
        boolean flag = false;

        Connection conn = getConnection();
        String sql = "select is_Active from users where username='"+username+"';";
        PreparedStatement pstmt;
        pstmt = (PreparedStatement)conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            if(rs.getString(1).equals("true") || rs.getString(1).equals("t")){
                flag = true;
                break;
            }
        }

        return flag;
    }

    public String getActivationCode(String username){
        try{
            Connection conn = getConnection();
            int i = 0;

            String sql = "select activateCode from ActivationCodes where username = '" + username + "'";
            Statement queryStatement = conn.createStatement();
            ResultSet rs = queryStatement.executeQuery(sql);
            if(rs.next()) {
                return rs.getString(1);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }
        return "";
    }

    /**
     * @method addUser(String,String,String,String) insert a user into users table
     * @return void
     */
    public int addUser(String username, String password, String email, String gender, String photo,String active,String start, String activationCode) throws SQLException {
        Connection conn = getConnection();
        int i=0;
        System.out.println("adding user\n**************");
        {
            String sql = "insert into users (username,password,email,gender,photourl,is_active,start) " +
                    "values ('" + username + "','" + password + "','" + email + "','" + gender + "','" + photo + "','" + active + "','" + start + "');";
            PreparedStatement pstmt;
            pstmt = (PreparedStatement) conn.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
        }
        {
            String sql = "insert into activationcodes (username,activateCode) " +
                    "values ('" + username + "','" + activationCode +"');";
            System.out.println(sql);
            PreparedStatement pstmt;
            pstmt = (PreparedStatement) conn.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
        }
        conn.close();

        return i;
    }


    /**
     * @method activateUser(String) set an account active
     * @param username
     * @reutnr int
     */
    public int activateUser(String username){
        int i=0;
        Connection conn = getConnection();
        String sql = "update users set is_active='true' where username='"+username+"';";
        PreparedStatement preparedStatement;
        try{
            System.out.println("activating user " + username);
            System.out.println(sql);
            preparedStatement = (PreparedStatement)conn.prepareStatement(sql);
            i = preparedStatement.executeUpdate();
            preparedStatement.close();
            conn.close();
        }catch (SQLException e){
            e.printStackTrace();
        }
        return i;
    }

    /**
     * @method get all information of a user from database
     * @param username
     * @return User object
     */
    public User getUserProfile(String username) throws SQLException {
        User user = new User();
        user.setUsername(username);
        Connection conn = getConnection();
        int i=0;
        String sql = "select password from users where username='"+username+"';";
        Statement querystatement = conn.createStatement();
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
                Recipe recipe = new Recipe(rs.getString("recipe_name"),rs.getString("recipe_id"));
                user.addToFavouriteList(recipe);
            }
        }
        return user;
    }


    /**
     * @method activateUser(String) set an account active
     * @param username
     * @reutnr int
     */
    public int updateUserInfo(String username, String attribute, String value){
        int i=0;
        Connection conn = getConnection();
        String sql = "update users set "+ attribute + "='"+ value +"' where username='"+username+"';";
        PreparedStatement preparedStatement;
        try{
            preparedStatement = (PreparedStatement)conn.prepareStatement(sql);
            i = preparedStatement.executeUpdate();
            preparedStatement.close();
            conn.close();
        }catch (SQLException e){
            e.printStackTrace();
        }
        return i;
    }

    /**
     * @method addFavourite(String,String) insert a user into users table
     * @return void
     */
    public int addFavourite(String username,Recipe recipe) throws SQLException {
        Connection conn = getConnection();
        int i=0;
        System.out.println("adding user\n**************");
        {
            String sql = "select count(*) from likeRecipe where username="+username+" and recipe_id="+recipe.getId()+";";
            PreparedStatement pstmt;
            pstmt = (PreparedStatement)conn.prepareStatement(sql);

            sql = "insert into likeRecipe (username,recipe_id,recipe_name)" +
                    "values ('" + username + "','" + recipe.getId() + "','"+recipe.getName()+"');";

            pstmt = (PreparedStatement) conn.prepareStatement(sql);
            i = pstmt.executeUpdate();
            pstmt.close();
        }

        conn.close();

        return i;
    }
}