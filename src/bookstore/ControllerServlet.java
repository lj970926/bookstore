package bookstore;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ControllerServlet",urlPatterns = "/ControllerServlet")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       RequestDispatcher rd = null;
        // get parameters
        String name = req.getParameter("userName");
        String email = req.getParameter("email");
        String passwd = req.getParameter("pwd");
        String passwdRp = req.getParameter("pwdRp");
        String type = req.getParameter("typeSelect");
        //write parameters to javabean
        RegisterFormBean rform = new RegisterFormBean();
        rform.setName(name);
        rform.setPasswd(passwd);
        rform.setEmail(email);
        rform.setPasswdRp(passwdRp);
        rform.setType(type);
        req.setAttribute("registerForm",rform);
        // back to register
        if (!rform.validate()){
            req.setAttribute("errors",rform.getErrorMsg());
            rd = req.getRequestDispatcher("/jsp/register.jsp");
            rd.forward(req,resp);
            return;
        }
        UserBean user = new UserBean();
        user.setName(rform.getName());
        user.setEmail(rform.getEmail());
        user.setPasswd(rform.getPasswd());
        if (rform.getType().equals("user")){
            user.setType(0);
            user.setMoney(1000.00);
        }
        else {
            user.setType(1);
        }
        Database db = new Database();
        try{
            db.inserttoDatabase(user);
        }
        catch (SQLException e){
            rform.setErrorMsg("other",e.getMessage());
            req.setAttribute("errors",rform.getErrorMsg());
            rd = req.getRequestDispatcher("/jsp/register.jsp");
            rd.forward(req,resp);
        }
        HttpSession session = req.getSession();
        session.setAttribute("loginuser",user);
        rd = req.getRequestDispatcher("/index.jsp");
        rd.forward(req,resp);
    }

}
