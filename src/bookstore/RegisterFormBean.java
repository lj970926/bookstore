package bookstore;

import java.util.Hashtable;

public class RegisterFormBean {
    private String name = "";
    private String passwd = "";
    private String passwdRp = "";
    private String email = "";
    private String type = "";
    private Hashtable errors = new Hashtable();

    public String getName() {
        return this.name;
    }

    public String getPasswd() {
        return this.passwd;
    }

    public String getPasswdRp() {
        return this.passwdRp;
    }

    public String getEmail() {
        return this.email;
    }
    public String getType(){
        return this.type;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public void setPasswdRp(String passwd) {
        this.passwdRp = passwd;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    public void setType(String t){
        this.type = t;
    }
    public boolean validate() {
        if (name.trim().equals("")) {
            errors.put("name", "请输入用户名");
            return false;
        }
        if (passwd.trim().equals("")){
            errors.put("passwd","请输入密码");
            return false;
        }
        if (!passwd.equals(passwdRp)) {
            errors.put("passwd", "两次输入的密码不匹配");
            return false;
        }
        if (!email.matches("[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+")) {
            errors.put("email", "please input a valid email");
            return false;
        }
        if (type == null){
            errors.put("type","please select a type to register");
            return false;
        }
        return true;

    }
    public void setErrorMsg(String key, String value){
        errors.put(key,value);
    }
    public Hashtable getErrorMsg(){
        return  this.errors;
    }


}
