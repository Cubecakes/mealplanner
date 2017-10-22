package unsw.comp4920.project;

import org.apache.commons.lang3.EnumUtils;
import org.apache.commons.lang3.ObjectUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class Controller extends javax.servlet.http.HttpServlet {
    private User currentUser;
    private String activate_code;

    boolean checkParametersExist(HttpServletRequest request, String[] parameters){
        for (String s : parameters){
            if (request.getParameter(s) == null){
                return false;
            }
        }
        return true;
    }

    String handleCheckLogin(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        String[] usedParameters = {
                "username",
                "password"
        };
        if (!checkParametersExist(request,usedParameters)){
            return "welcome.jsp";
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");
                /*
                  Search database for user
                */

        if(DatabaseOperation.userExists(username)){
            try {
                System.out.println(DatabaseOperation.isActive(username));
                System.out.println(DatabaseOperation.checkPassword(username,password));

                if(DatabaseOperation.checkPassword(username,password) && DatabaseOperation.isActive(username)){
                    currentUser = new User(username,password);
                    Calendar cal = Calendar.getInstance();
                    cal.add( Calendar.DAY_OF_WEEK, -(cal.get(Calendar.DAY_OF_WEEK)-1));
                    request.getSession().setAttribute("currentDate", cal);
                    request.getSession().setAttribute("currentUser", currentUser);
                    System.out.println("Login successful");
                    return "home";
                }else{
                    if(DatabaseOperation.checkPassword(username,password)==false) {
                        System.out.println("Password incorrect ");
                        request.setAttribute("error_info", "Incorrect password");
                        return "login.jsp";
                    }
                    if(DatabaseOperation.isActive(username) == false) {
                        System.out.println("Log in isn't active");
                        return handleSendReconfirmationEmail(request,response);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else{
            System.out.println("Username doesn't  exist");
            request.setAttribute("error_info","Username doesn't exist");
            return "login.jsp";
        }
        return "login.jsp";
    }

    String handleCheckRegister(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        String username = request.getParameter("register_username");
        String password = request.getParameter("register_password");
        String email = request.getParameter("register_email");
        String gender = request.getParameter("register_gender");
        String photourl = request.getParameter("register_photo");


        if(username==null || password==null||email==null||gender==null){
            request.setAttribute("register_error_info","Please fill out all fields");
            return "register.jsp";
        }else {
            if (DatabaseOperation.userExists(username)) {
                request.setAttribute("register_error_info", "username " + username + " exists, please choose another username");
                return "register.jsp";
            } else if (!email.contains("@")) {
                request.setAttribute("register_error_info", "Please enter a valid email address");
                return "register.jsp";
            } else {
                if(photourl==null){
                    currentUser = new User(username, password,email,gender,"profolio.PNG");
                }else{
                    currentUser = new User(username, password,email,gender,photourl);
                }

                Date dNow = new Date();
                SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                String start = ft.format(dNow).toString();
                currentUser.setActive(false);
                currentUser.setEmail(email);
                currentUser.setGender(gender);
                currentUser.setPhotourl(photourl);
                currentUser.setStart(start);

                SendEmail se = new SendEmail(email);
                String code = username+"***";

                //generate activate code
                int ram = (int) (Math.random() * 97);
                for (int i = 0; i < 30; i++) {
                    ram = (int) (Math.random() * 26 + 65);
                    code += Integer.toString(ram);
                }
                activate_code = code;

                try {
                    int i = DatabaseOperation.addUser(username,password,email,gender,photourl,"false",start,activate_code);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                se.sendActivateEmail(code,currentUser.getUsername());
                request.setAttribute("error_info", "Please check your email to activate your account");
                return "login.jsp";
            }
        }
    }

    String handleActivateAccount(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        String[] usedParameters = {
                "code",
                "user"
        };
        if (!checkParametersExist(request,usedParameters)){
            return "welcome.jsp";
        }
        String code = request.getParameter("code");
        String user = request.getParameter("user");



        String account_code = DatabaseOperation.getActivationCode(request.getParameter("user"));
        System.out.println("Code: "+code);
        System.out.println("Activate_code: "+account_code);
        if(code.equals(account_code)){
            System.out.println();
            DatabaseOperation.activateUser(user);
            request.setAttribute("error_info", "Account successfully activated");
            return "login.jsp";
        }else{
            request.setAttribute("error_info", "Account activation failed");
            return "login.jsp";
        }

    }

    String handleLogout(HttpServletRequest request, HttpServletResponse response) {
        currentUser = null;
        return "welcome.jsp";
    }

    String handleSendReconfirmationEmail(HttpServletRequest request, HttpServletResponse response) {
        String user = request.getParameter("username");

        try {
            SendEmail se = new SendEmail(DatabaseOperation.getUserProfile(user).getEmail());
            se.sendActivateEmail(DatabaseOperation.getActivationCode(user), currentUser.getUsername());
        }catch (SQLException e){
            e.printStackTrace();
        }
        request.setAttribute("error_info", "Account not activated... Resending activation email");
        return "login.jsp";
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionString = request.getParameter("action");
        String nextPage = "home.jsp";
        if(actionString != null && EnumUtils.isValidEnum(ControllerActions.class,actionString)){

            ControllerActions action = ControllerActions.valueOf(actionString);
            //if user want to log in with username and password
            if (action == ControllerActions.GOTO_LOGIN) {
                nextPage = "login.jsp";
            }else if (action == ControllerActions.GOTO_REGISTER) {
                nextPage = "register.jsp";
            }else if (action == ControllerActions.CHECK_LOGIN) {
                try {
                    nextPage = handleCheckLogin(request,response);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }else if(action == ControllerActions.CHECK_REGISTER){
                try {
                    nextPage = handleCheckRegister(request,response);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }else if(action == ControllerActions.ACTIVATE_ACCOUNT){
                try {
                    nextPage = handleActivateAccount(request,response);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }else if(action == ControllerActions.SEND_RECONFIRMATION_EMAIL){
                nextPage = handleSendReconfirmationEmail(request,response);
            }else if(action == ControllerActions.LOGOUT){
                nextPage = handleLogout(request,response);
            }else{
                System.out.println("Received invalid controller action with valid enum " + actionString);
            }
        }

        System.out.println(actionString);
        System.out.println(EnumUtils.isValidEnum(ControllerActions.class,actionString));
        System.out.println(nextPage);

        RequestDispatcher rd = request.getRequestDispatcher("/"+nextPage);
        rd.forward(request, response);
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        doPost(request,response);
    }
}
