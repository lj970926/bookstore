<%--
  Created by IntelliJ IDEA.
  User: lijin
  Date: 2019/5/26
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bookstore.Database" %>
<%@ page import="bookstore.UserBean" %>
<%@ page import="java.sql.SQLException" %>
<%
    String email = request.getParameter("email");
    String pwd = request.getParameter("pwd");
    int type;
    if (request.getParameter("user") != null)
        type = 0;
    else
        type = 1;
    Database db = new Database();
    if (email.trim().equals("")) {
        request.setAttribute("error_login", "请输入邮箱");
%>
<jsp:forward page="login.jsp"></jsp:forward>
<%
} else if (pwd.trim().equals("")) {
    request.setAttribute("error_login", "请输入密码");
%>
<jsp:forward page="login.jsp"></jsp:forward>
<%
} else {
    UserBean user;
    try {
        user = db.getUserByEmail(email, type);
    } catch (SQLException e) {
        request.setAttribute("error_login", "用户不存在");
%>
<jsp:forward page="login.jsp"></jsp:forward>
<%
    }
    if (user == null) {
        request.setAttribute("error_login", "用户不存在");
%>
<jsp:forward page="login.jsp"></jsp:forward>
<%
    }
    if (!user.getPasswd().equals(pwd)) {
        request.setAttribute("error_login", "密码错误");
%>

<jsp:forward page="login.jsp"></jsp:forward>
<%
        }
        session.setAttribute("loginuser", user);
    }
%>
<jsp:forward page="../index.jsp"></jsp:forward>
