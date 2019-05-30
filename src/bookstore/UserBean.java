package bookstore;

import java.io.Serializable;

public class UserBean implements Serializable {
    private String name;
    private String passwd;
    private String email;
    private double money = 0;
    private int type;
    public void setName(String name){
        this.name = name;
    }
    public void setPasswd(String pass){
        this.passwd = pass;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public void setMoney(double m){
        this.money = m;
    }
    public void setType(int type){
        this.type = type;
    }
    public String getName(){
        return this.name;
    }
    public String getPasswd(){
        return this.passwd;
    }
    public String getEmail(){
        return this.email;
    }
    public double getMoney(){
        return this.money;
    }
    public int getType(){
        return this.type;
    }
}
