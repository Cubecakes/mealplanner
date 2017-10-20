package unsw.comp4920.project;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@WebServlet(name = "HomeServlet", urlPatterns = "/home")
public class HomeServlet extends HttpServlet {
    private User currentUser;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String nextPage = "myhome.jsp";
        currentUser = (User)request.getSession().getAttribute("currentUser");
        if(action != null){
            System.out.println("Action|||"+action+"|||");

            Calendar c = (Calendar) request.getSession().getAttribute("currentDate");
            if(action.equals("next_week")) {
                c.add(Calendar.DAY_OF_WEEK,7);
                request.getSession().setAttribute("currentUser",currentUser);
            }else if(action.equals("prev_week")) {
                c.add(Calendar.DAY_OF_WEEK,-7);
                request.getSession().setAttribute("currentUser",currentUser);
            }else if(action.equals("curr_week")) {
                c = Calendar.getInstance();
                c.add( Calendar.DAY_OF_WEEK, -(c.get(Calendar.DAY_OF_WEEK)-1));
                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);

            }else if(action.equals("add_to_plan")){
                String recipe_id = request.getParameter("recipe_id");
                String name = request.getParameter("recipe_name");
                Recipe recipe = new Recipe(name,recipe_id);

                System.out.println(request.getParameter("meal_type"));
                System.out.println(MealTypes.Breakfast.toString().compareTo(request.getParameter("meal_type")));
                System.out.println(MealTypes.valueOf(MealTypes.Breakfast.toString()));
                MealTypes type = MealTypes.valueOf(request.getParameter("meal_type"));

                SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                Date date=null;
                try {
                    date = df.parse(request.getParameter("plan_date"));
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                Plan plan = new Plan();
                plan.setUser(currentUser);
                plan.setDate(date);
                plan.setType(type);
                plan.setRecipe(recipe);

                //write to database
                DatabaseOperation dbo = new DatabaseOperation();
                dbo.insertPlan(plan);
                //request.setAttribute("recipe_id",recipe);

                nextPage = "myhome.jsp";
                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);

            }else if(action.equals("add_to_plan_without_plan_date")){

                String recipe_id = request.getParameter("recipe_id");
                String name = request.getParameter("recipe_name");
                Recipe recipe = new Recipe(name,recipe_id);

                System.out.println(request.getParameter("meal_type"));
                System.out.println(MealTypes.Breakfast.toString().compareTo(request.getParameter("meal_type")));
                System.out.println(MealTypes.valueOf(MealTypes.Breakfast.toString()));
                MealTypes type = MealTypes.valueOf(request.getParameter("meal_type"));

                String year = request.getParameter("add_to_plan_year");
                String month = request.getParameter("add_to_plan_month");
                String day = request.getParameter("add_to_plan_day");
                String dateStr = day +"-"+month+"-"+year;

                SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                Date date=null;
                try {
                    date = df.parse(dateStr);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                System.out.println("Date======"+date);
                System.out.println("Type======"+type);
                System.out.println("Recipe_name======"+name);

                Plan plan = new Plan();
                plan.setUser(currentUser);
                plan.setDate(date);
                plan.setType(type);
                plan.setRecipe(recipe);

                //write to database
                DatabaseOperation dbo = new DatabaseOperation();
                dbo.insertPlan(plan);

                if (request.getParameter("parent_page").equals("profile")) {
                    request.setAttribute("username",currentUser.getUsername());
                    nextPage = "profile.jsp";
                }else if(request.getParameter("parent_page").equals("selected_recipe")){
                    request.setAttribute("recipe_id",recipe_id);
                    request.setAttribute("display_type","profile");
                    nextPage = "selected_recipe.jsp";
                }

                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);

            }else if(action.equals("save_plan")){
                nextPage = "";

            }else if(action.equals("favourite")){
                System.out.println("HAHHAHAH");
                String recipe_id = request.getParameter("recipe_id");
                String recipe_name = request.getParameter("recipe_name");

                Recipe recipe = new Recipe(recipe_name,recipe_id);
                currentUser.addToFavouriteList(recipe);

                //write to database
                DatabaseOperation dbo = new DatabaseOperation();
                try {
                    dbo.addFavourite(currentUser.getUsername(),recipe);
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                nextPage = "search_recipe.jsp";
                request.setAttribute("search_keyword",request.getParameter("search_keyword"));
                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);

            }else if(action.equals("show_recipe")){

                String id = (String)request.getParameter("recipe_id");
                request.setAttribute("recipe_id",id);
                String keyword = request.getParameter("search_keyword");
                request.setAttribute("search_keyword",keyword);
                String name = request.getParameter("recipe_name");
                request.setAttribute("recipe_name",name);
                nextPage = "selected_recipe.jsp";

                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);
            }else if(action.equals("search_all")){

                //request.setAttribute("search_keyword",null);
                nextPage = "search_recipe.jsp";
                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);
            }else if(action.equals("search")){

                nextPage = "search.jsp";


            }else if(action.equals("search_submit")){
                nextPage = "search_recipe.jsp";
                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);
            }else if(action.equals("profile")){

                DatabaseOperation dbo = new DatabaseOperation();
                try {
                    currentUser = dbo.getUserProfile(currentUser.getUsername());
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                nextPage = "profile.jsp";
                request.getSession().setAttribute("currentDate",c);
                request.getSession().setAttribute("currentUser",currentUser);
                request.setAttribute("username",currentUser.getUsername());

            }else if(action.equals("edit_profile")){
                String username = currentUser.getUsername();
                String password = request.getParameter("edit_password");
                String email = request.getParameter("edit_email");
                String photourl = request.getParameter("edit_profile_photo");


                System.out.println(photourl);
                //write into database
                SearchDatabase sd = new SearchDatabase();
                if(email!=null && !"".equals(email)) {
                    DatabaseOperation dbo = new DatabaseOperation();
                    int i = dbo.updateUserInfo(username,"email",email);
                    //System.out.print
                    currentUser.setEmail(email);
                }else {
                    currentUser.setEmail(currentUser.getEmail());
                }

                if(password!=null&&!"".equals(password)){
                    DatabaseOperation dbo = new DatabaseOperation();
                    dbo.updateUserInfo(username,"password", password);
                    currentUser.setPassword(password);
                }else {
                    //currentUser.setPassword(currentUser.getPassword());
                }

                   /* if(photourl != null&&!"".equals(photourl)) {
                        //upload profile photo

                        FileInputStream pic = null;

                        System.out.println(photourl);
                        photourl = new String(photourl.getBytes());
                        if (photourl.contains(".png")) {
                            db.pngTojpg(photourl);
                        }
                        photourl = db.zippicture(photourl, 100, 100, 0.9f);
                        pic = new FileInputStream(photourl);


                        String sql = "update users set photourl =? where username = ? ";
                        System.out.println(sql);
                        PreparedStatement pStatement = connection.prepareStatement(sql);
                        pStatement.setBinaryStream(1, pic, pic.available());
                        pStatement.setString(2, username);
                        pStatement.executeUpdate();
                        currentUser.setPhotoUrl(photourl);
                    }else {
                        currentUser.setPhotoUrl(currentUser.getPhotoUrl());
                    }
                    */

                nextPage = "profile.jsp";

                request.setAttribute("currentUser",currentUser);
                request.setAttribute("username", currentUser.getUsername());
                request.getSession().setAttribute("currentDate",c);
            } else if(action.equals("logout")){
                currentUser = null;
                getServletContext().setAttribute("currentUser",null);

                nextPage = "/control";
            }else if (action.equals("remove_plan")){
                DatabaseOperation dbo = new DatabaseOperation();
                String username = currentUser.getUsername();
                String plan_date = (String) request.getParameter("plan_date");
                String meal_type = (String) request.getParameter("meal_type");
                String recipe_id = (String) request.getParameter("recipe_id");
                dbo.removePlan(username,plan_date,meal_type,recipe_id);
                nextPage = "/myhome.jsp";
            }

        }

        request.getSession().setAttribute("currentUser",currentUser);
        RequestDispatcher rd = request.getRequestDispatcher("/"+nextPage);
        rd.forward(request, response);
    }
}
