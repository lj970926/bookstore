package bookstore;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookOrderServlet", urlPatterns = "/BookOrderServlet")
public class BookOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Database db = new Database();
        HttpSession session = req.getSession();
        List<BookBean> list = (List<BookBean>) session.getAttribute("cart");
        RequestDispatcher rd = null;
        String errorMsg = "支付成功";
        UserBean  user = (UserBean) session.getAttribute("loginuser");
        double sum = (double)session.getAttribute("sum");
        boolean result = true;
        if (list == null){
            errorMsg = "您并未选择任何图书";
            result = false;
        }
        else {
            for (BookBean b : list) {
                try {
                    BookBean stbook = db.getBookByid(b.getBid());
                    if (stbook.getNumber() < b.getNumber()) {
                        errorMsg = "图书剩余数量不足，交易失败";
                        result = false;

                    }
                    else if (user.getMoney() < sum){
                        errorMsg = "余额不足请及时充值";
                        result = false;
                    }
                } catch (NullPointerException e) {
                    errorMsg = "图书不存在";
                    result = false;
                }
            }
        }
        if (result){
            db.updataBookMsg(list);
            user.setMoney(user.getMoney()-sum);
            db.updateUserMsg(user);
        }
        session.removeAttribute("cart");
        session.removeAttribute("error_pay");
        session.setAttribute("error_pay", errorMsg);
        rd = req.getRequestDispatcher("/jsp/usersuccess.jsp");
        rd.forward(req,resp);
        return;
    }
}
