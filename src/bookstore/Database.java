package bookstore;

import com.mysql.cj.jdbc.exceptions.MySQLQueryInterruptedException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Database {
    private Connection conn;

    public Database() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=UTC";
            String name = "root";
            String passwd = "lj970926";
            this.conn = DriverManager.getConnection(url, name, passwd);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void inserttoDatabase(UserBean user) throws SQLException {
        String sql = null;
        PreparedStatement ps = null;
        try {
            if (user.getType() == 0) {
                sql = "insert into customers(name,money,email,passwd) values(?,?,?,?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, user.getName());
                ps.setDouble(2, user.getMoney());
                ps.setString(3, user.getEmail());
                ps.setString(4, user.getPasswd());
            }
            else if (user.getType() == 1) {
                sql = "insert into managers(name,email,passwd) values (?,?,?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPasswd());
            }
            int row = ps.executeUpdate();
            if (row > 0)
                System.out.println("success");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return;

    }

    public List<BookBean> readBookMessage() throws SQLException {
        String sql = "select * from books";
        List<BookBean> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()){
                BookBean b = new BookBean();
                b.setBid(rs.getInt("bid"));
                b.setName(rs.getString("name"));
                b.setPrice(rs.getDouble("price"));
                b.setNumber(rs.getInt("number"));
                list.add(b);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }
    public BookBean getBookByid(int id){
        String sql = "select * from books where bid = " + id ;
        ResultSet rs = null;
        BookBean b = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()){
                b = new BookBean();
                b.setBid(rs.getInt("bid"));
                b.setName(rs.getString("name"));
                b.setPrice(rs.getDouble("price"));
                b.setNumber(rs.getInt("number"));
            }

        }
        catch (Exception e){
            e.printStackTrace();
        }
        return b;

    }
    public void updataBookMsg(List<BookBean> list){
        String sql = "";
        try {
            for (BookBean b :list){
                BookBean temp = getBookByid(b.getBid());
                if (temp.getNumber() == 1){
                    sql = "delete from books where bid = " + temp.getBid();
                    Statement st = conn.createStatement();
                    st.executeUpdate(sql);
                }
                else {
                    sql = "update books set number = " + (temp.getNumber()-b.getNumber()) + " where bid = "  + temp.getBid();
                    Statement st = conn.createStatement();
                    st.executeUpdate(sql);
                }
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

    }
    public UserBean  getUserByEmail(String email,int type) throws SQLException{
        UserBean result = new UserBean();
        String sql = "select * from " + (type==0?"customers":"managers") + " where email = \"" + email + "\"";
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        if (rs == null)
            return null;
        rs.next();
        result.setType(type);
        result.setEmail(rs.getString("email"));
        result.setPasswd(rs.getString("passwd"));
        result.setName(rs.getString("name"));
        if (type == 0)
            result.setMoney(rs.getDouble("money"));
        return result;
    }
    public void insertBooks(BookBean b) throws SQLException {
        PreparedStatement ps = null;
        String sql = "insert into books(name,number,price) values(?,?,?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1,b.getName());
        ps.setInt(2,b.getNumber());
        ps.setDouble(3,b.getPrice());
        ps.executeUpdate();

    }
    public void updateUserMsg(UserBean user) {
        String sql = "update customers set money = " + user.getMoney()+
                " where email = \"" + user.getEmail() + "\"";
        try {
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
        }
        catch (SQLException e){
            e.printStackTrace();
        }


    }
    public static void main(String args[]){
        String sql = "select * from " + ("customers")+ " where email = \"" + "fasfsaf@qq.com" + "\"";
        System.out.println(sql);

    }

}
