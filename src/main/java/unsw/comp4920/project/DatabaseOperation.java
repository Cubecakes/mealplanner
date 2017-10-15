package unsw.comp4920.project;

import java.sql.*;

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

    /**
     * @method insert a new user into table "users", used for user registration,should be called
     *          each time when food is added by users
     * @param  plan object intended to add into database
     * @return integer, the number of record inserted successfully
     */
    public int insertPlan(PlanUnit plan) {
        Connection connection = getConnection();
        String sql = "INSERT INTO PLANS (username,plan_date,type,food) VALUES(?,?,?,?)";
        PreparedStatement statement = null;
        int r=0;
        int count=0;
        //int length = plan.getFoodList().size();
        try {
            //for(int i=0;i<length;i++) {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            statement.setString(1, plan.getUser().getUsername());
            statement.setString(2, plan.getDate());
            statement.setString(3, plan.getType());
            statement.setString(4, plan.getFoodList().get(0).getName());
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

    /**
     * @method addUser(String,String,String,String) insert a user into users table
     * @return void
     */
    public int addUser(String username, String password, String email, String gender, String photo,String active,String start) throws SQLException {
        Connection conn = getConnection();
        int i=0;
        String sql = "insert into users (username,password,email,gender,photourl,is_active,start) " +
                "values ('"+username+"','"+password+"','"+email+"','"+gender+"','"+photo+"','"+active+"','"+start+"');";
        PreparedStatement pstmt;
        pstmt = (PreparedStatement)conn.prepareStatement(sql);
        i = pstmt.executeUpdate();
        pstmt.close();
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

           /* sql = "select start from users where username='"+username+"';";
            rs =querystatement.executeQuery(sql);
            if(rs.next()) {
                user.setActive(Boolean.parseBoolean(rs.getString(1)));
            }*/
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
     * @method Integer getAll() 查询并打印表中数据
     * @return Integer 查询并打印表中数据
     */
    public Integer getAllUsers() {
        Connection conn = getConnection();
        String sql = "select * from users";
        PreparedStatement pstmt;
        try {
            pstmt = (PreparedStatement)conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            int col = rs.getMetaData().getColumnCount();
            System.out.println("============================");
            while (rs.next()) {
                for (int i = 1; i <= col; i++) {
                    System.out.print(rs.getString(i) + "\t");
                    if ((i == 2) && (rs.getString(i).length() < 8)) {
                        System.out.print("\t");
                    }
                }
                System.out.println("");
            }
            System.out.println("============================");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * @method Integer getAll Plan
     * @return Integer
     */
    public Integer getAllPlans() {
        Connection conn = getConnection();
        String sql = "select * from plans";
        PreparedStatement pstmt;
        try {
            pstmt = (PreparedStatement)conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            int col = rs.getMetaData().getColumnCount();
            System.out.println("============================");
            while (rs.next()) {
                for (int i = 1; i <= col; i++) {
                    System.out.print(rs.getString(i) + "\t");
                    if ((i == 2) && (rs.getString(i).length() < 8)) {
                        System.out.print("\t");
                    }
                }
                System.out.println("");
            }
            System.out.println("============================");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * @method Integer getAllFood() get all food info in database
     * @return Integer
     */
    public Integer getAllFood() {
        Connection conn = getConnection();
        String sql = "select * from food";
        PreparedStatement pstmt;
        try {
            pstmt = (PreparedStatement)conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            int col = rs.getMetaData().getColumnCount();
            System.out.println("============================");
            while (rs.next()) {
                for (int i = 1; i <= col; i++) {
                    System.out.print(rs.getString(i) + "\t");
                    if ((i == 2) && (rs.getString(i).length() < 8)) {
                        System.out.print("\t");
                    }
                }
                System.out.println("");
            }
            System.out.println("============================");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}