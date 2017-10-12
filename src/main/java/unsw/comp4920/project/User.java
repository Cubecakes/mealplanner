package unsw.comp4920.project;

import java.util.Date;
import java.util.List;

public class User {
    private String username;
    private String password;
    private String email;
    private String gender;
    private String photourl;
    private Boolean isActive;
    private String start;

    public User(){}

    public User(String username, String password){
        this.username = username;
        this.password = password;
    }

    public User(String username, String password, String email, String gender){
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.photourl = photourl;
    }

    public User(String username, String password, String email, String gender,String photourl){
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.photourl = photourl;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhotourl() {
        return photourl;
    }

    public void setPhotourl(String photourl) {
        this.photourl = photourl;
    }

    public Boolean isActive() {
        return isActive;
    }

    public void setActive(Boolean active) {
        isActive = active;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }
}
