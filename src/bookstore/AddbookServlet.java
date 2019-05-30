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
@WebServlet(name = "AddbookServlet",urlPatterns = "/AddbookServlet")
public class AddbookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String sprice = req.getParameter("price");
        String snumber = req.getParameter("number");
        HttpSession session = req.getSession();
        if (name.trim().equals("") || sprice.trim().equals("") || snumber.trim().equals("")){
            session.setAttribute("erroradd","输入的信息存在错误，请检查");
            RequestDispatcher rd = req.getRequestDispatcher("/jsp/managersuccess.jsp");
            rd.forward(req,resp);
            return;
        }
        BookBean book = new BookBean();
        double price = Double.parseDouble(sprice);
        int number = Integer.parseInt(snumber);
        book.setName(name);
        book.setPrice(price);
        book.setNumber(number);
        Database db = new Database();
        try{
            db.insertBooks(book);
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        session.setAttribute("erroradd","添加成功");
        RequestDispatcher rd = req.getRequestDispatcher("/jsp/managersuccess.jsp");
        rd.forward(req,resp);
        return;

    }
}
