package unsw.comp4920.project;

import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;

public class Controller extends javax.servlet.http.HttpServlet {
    private User currentUser;
    private String activate_code;

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String action = request.getParameter("action");
        String nextPage = "home.html";
        if(action != null){
            //if user want to log in with username and password
            if (action.equals("check_login")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                /*
                  Search database for user
                */
                DatabaseOperation dbo = new DatabaseOperation();
                if(dbo.userIsExisted(username)){
                    try {
                        System.out.println(dbo.isActive(username));
                        System.out.println(dbo.checkPassword(username,password));

                        if(dbo.checkPassword(username,password) && dbo.isActive(username)){
                            currentUser = new User(username,password);
                            Calendar cal = Calendar.getInstance();
                            cal.add( Calendar.DAY_OF_WEEK, -(cal.get(Calendar.DAY_OF_WEEK)-1));
                            request.getSession().setAttribute("currentDate", cal);
                            request.getSession().setAttribute("currentUser", currentUser);
                            nextPage = "home";
                            System.out.println("Login successful");
                        }else{
                            if(dbo.checkPassword(username,password)==false) {
                                System.out.println("Password incorrect ");
                                request.setAttribute("error_info", "Incorrect password");
                                nextPage = "login.jsp";
                            }
                            if(dbo.isActive(username) == false) {
                                System.out.println("Log in isn't active");
                                //request.setAttribute("error_info", "Incorrect password");
                                nextPage = "inactive_resend_email.jsp";
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }else{
                    System.out.println("Username doesn't  exist");
                    request.setAttribute("error_info","Username doesn't exist");
                    nextPage = "login.jsp";
                }
            }else if(action.equals("register")){
                String username = request.getParameter("register_username");
                String password = request.getParameter("register_password");
                String email = request.getParameter("register_email");
                String gender = request.getParameter("register_gender");
                String photourl = request.getParameter("register_photo");



                DatabaseOperation dbo = new DatabaseOperation();
                if(username==null || password==null||email==null||gender==null){
                    request.setAttribute("register_error_info","Please fill out all fields");
                    nextPage = "register.jsp";
                }else {
                    if (dbo.userIsExisted(username)) {
                        if (!email.contains("@")) {
                            request.setAttribute("register_error_info", "username exists, please choose another username" +
                                    "username.\nPlease enter a valid email address");
                        } else {
                            request.setAttribute("register_error_info", "username exists, please choose another username" +
                                    "username.");
                        }
                        nextPage = "register.jsp";
                    } else {
                        if (!email.contains("@")) {
                            request.setAttribute("register_error_info", "Please enter a valid email address");
                            nextPage = "register.jsp";
                        }else {
                            if(photourl==null){
                                currentUser = new User(username, password,email,gender);
                            }else{
                                currentUser = new User(username, password,email,gender,photourl);
                            }

                            request.setAttribute("currentUser", currentUser);
                            try {
                                int i = dbo.addUser(username,password,email,gender,photourl,"false");
                                /*if(dbo.userIsExisted(username)){
                                    nextPage = "register_test.jsp";
                                }else{
                                    nextPage = "register.jsp";
                                }*/
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                            currentUser.setActive(false);
                            currentUser.setEmail(email);
                            currentUser.setGender(gender);
                            currentUser.setPhotourl(photourl);

                            SendEmail se = new SendEmail(email);
                            String code = username+"***";

                            //generate activate code
                            int ram = (int) (Math.random() * 97);
                            for (int i = 0; i < 30; i++) {
                                ram = (int) (Math.random() * 26 + 65);
                                code += Integer.toString(ram);
                            }
                            activate_code = code;
                            getServletContext().setAttribute("activate_code", activate_code);
                            se.sendActivateEmail(code);
                            getServletContext().setAttribute("currentUser",currentUser);
                            nextPage = "after_register.jsp";
                        }
                    }
                }
            }else if(action.equals("activateAccount")){
                String code = request.getParameter("code");
                System.out.println("Code: "+code);
                System.out.println("Activate_code: "+getServletContext().getAttribute("activate_code"));
                if(code.equals(getServletContext().getAttribute("activate_code"))){
                    currentUser.setActive(true);
                    System.out.println();
                    DatabaseOperation dbo = new DatabaseOperation();
                    dbo.activateUser(currentUser.getUsername());
                }
                getServletContext().setAttribute("currentUser",currentUser);
                //nextPage = "home";
                nextPage = "activate_success.jsp";
            }else if(action.equals("resend_confirm_email")){
                currentUser = (User)request.getSession().getAttribute("currentUser");
                SendEmail se = new SendEmail(currentUser.getEmail());
                String code = currentUser.getUsername()+"***";

                //generate activate code
                int ram = (int) (Math.random() * 97);
                for (int i = 0; i < 30; i++) {
                    ram = (int) (Math.random() * 26 + 65);
                    code += Integer.toString(ram);
                }
                activate_code = code;
                request.getSession().setAttribute("activate_code", activate_code);
                se.sendActivateEmail(code);
                request.getSession().setAttribute("currentUser",currentUser);
                nextPage = "register_test.jsp";

            }else if(action.equals("logout")){
                currentUser = null;
                nextPage = "welcome.jsp";
            }else if(action.equals("add_meal")){
                nextPage = "welcome.jsp";
            }else{
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
            }
        }
        System.out.println(request.getParameter(action));
        System.out.println(nextPage);

        RequestDispatcher rd = request.getRequestDispatcher("/"+nextPage);
        rd.forward(request, response);
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        doPost(request,response);
    }
}
