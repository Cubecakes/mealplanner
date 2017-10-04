package unsw.comp4920.project;

import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.SQLException;

public class Controller extends javax.servlet.http.HttpServlet {
    private User currentUser;
    private String activate_code;

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String action = request.getParameter("action");
        String nextPage = "welcome.jsp";
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
                        if(dbo.checkPassword(username,password) && dbo.isActive(username)==true){
                            currentUser = new User(username,password);
                            getServletContext().setAttribute("currentUser", currentUser);
                            System.out.println("Log in Successfully");
                            nextPage = "home";
                        }else{
                            if(dbo.checkPassword(username,password)==false) {
                                request.setAttribute("error_info", "Incorrect password");
                                System.out.println("Log in incorrect password");
                                nextPage = "login.jsp";
                            }else if(dbo.isActive(username)==false){
                                //request.setAttribute("error_info", "Incorrect password");
                                System.out.println("Log in is didn't active");
                                nextPage = "inactive_resend_email.jsp";
                                currentUser = dbo.getUserProfile(username);
                                getServletContext().setAttribute("currentUser",currentUser);
                            }else {
                                System.out.println("Log in oh NO!!!!");
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }else{
                    request.setAttribute("error_info","Username doesn't exist");
                    System.out.println("Log in oh no...");
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
                            request.setAttribute("register_error_info", "username exists,please change to another " +
                                    "username.\nPlease enter a valid email address");
                        } else {
                            request.setAttribute("register_error_info", "username exists,please change to another " +
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
                            currentUser.setActive("false");
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
                    currentUser.setActive("true");
                    DatabaseOperation dbo = new DatabaseOperation();
                    dbo.activateUser(currentUser.getUsername());
                }
                getServletContext().setAttribute("currentUser",currentUser);
                //nextPage = "home";
                nextPage = "activate_success.jsp";
            }else if(action.equals("resend_confirm_email")){
                currentUser = (User)getServletContext().getAttribute("currentUser");
                SendEmail se = new SendEmail(currentUser.getEmail());
                String code = currentUser.getUsername()+"***";

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
                nextPage = "register_test.jsp";

            }else if(action.equals("logout")){
                currentUser = null;
                nextPage = "welcome.jsp";
            }else{
                System.out.println(request.getParameter("action"));
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
                System.out.println("AHAHHAHAHAHAHAHAHAHHAHAH");
            }
        }

        RequestDispatcher rd = request.getRequestDispatcher("/"+nextPage);
        rd.forward(request, response);
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        doPost(request,response);
    }
}
