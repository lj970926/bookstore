<%--
  Created by IntelliJ IDEA.
  User: lijin
  Date: 2019/5/27
  Time: 13:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bookstore.Database" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="bookstore.BookBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bookstore.UserBean" %>

<html>
<head>
    <%
        if (session.getAttribute("loginuser") == null) {
    %>
    <jsp:forward page="login.jsp"></jsp:forward>
    <%
        }
        UserBean user = (UserBean) session.getAttribute("loginuser");
    %>
    <%
        if (user.getType() == 1) {
            session.removeAttribute("lojinuser");
    %>
    <jsp:forward page="login.jsp"></jsp:forward>
    <%
        }
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + '/';
    %>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <title>欢迎使用网上书店系统</title>
</head>
<body>
<%
    Database db = new Database();
    List<BookBean> list = db.readBookMessage();
%>
<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"> 网上书店系统</a>
        </div>
        <div>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">用户名<%=user.getName()%>
                </a></li>
                <li><a href="#">余额 <%=user.getMoney()%>
                </a>
            </ul>
        </div>
    </div>

</nav>
<h2 class="text-center"><strong>当前图书</strong></h2>
<table class="table table-striped">
    <thead>
    <tr>
        <th>图书编号</th>
        <th>图书名称</th>
        <th>单价</th>
        <th>剩余数量</th>
    </tr>

    </thead>
    <tbody>
    <%
        for (BookBean b : list) {
    %>
    <tr>
        <td><%=b.getBid()%>
        </td>
        <td><%=b.getName()%>
        </td>
        <td><%=b.getPrice()%>
        </td>
        <td><%=b.getNumber()%>
        </td>
    </tr>

    <%
        }
    %>
    </tbody>
</table>
<form action="${pageContext.request.contextPath}/jsp/usersuccess.jsp" method="post" class="form-inline text-center">
    <div class="form-group">
        <label for="bid">请输入要购买的图书编号</label>
        <input id="bid" class="form-control" placeholder="编号" name="bid">
        <label for="count">请输入购买数量</label>
        <input id="count" class="form-control" placeholder="购买数量" name="count">
        <button class="btn btn-lg btn-primary" type="submit">加入购物车</button>
    </div>
</form>
<h2 class="text-center"><strong>购物车信息</strong></h2>
<div class="container">
    <div class="row">
        <div class="col-sm-4 col-sm-offset-4">
            <table class="table table-condensed">
                <thead>
                <tr>
                    <th>书名</th>
                    <th>购买数量</th>
                </tr>
                </thead>
                <tbody>
                <%
                    String sid = request.getParameter("bid");
                    String scount = request.getParameter("count");
                    List<BookBean> cart = (List<BookBean>) session.getAttribute("cart");
                    if (cart == null)
                        cart = new ArrayList<BookBean>();
                    if ((sid != null && scount != null) && (!sid.trim().equals("") && !scount.trim().equals(""))) {
                        int id = Integer.parseInt(sid);
                        int count = Integer.parseInt(scount);
                        BookBean book = db.getBookByid(id);
                        book.setNumber(count);
                        cart.add(book);
                        session.removeAttribute("cart");
                        session.setAttribute("cart", cart);
                    }
                    for (BookBean b : cart) {
                %>
                <tr>
                    <td><%=b.getName()%>
                    </td>
                    <td><%=b.getNumber()%>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<form method="post" action="${pageContext.request.contextPath}/jsp/order.jsp" class="text-center">
    <button type="submit" class="btn btn-primary btn-lg">提交订单</button>
</form>
<%
    String errors = "";
    if (session.getAttribute("error_pay") != null)
        errors = (String) session.getAttribute("error_pay");
%>
<div class="text-center">
    <label class="text-center"><font color="red"><%=errors%>
    </font></label>
</div>

</body>
</html>
