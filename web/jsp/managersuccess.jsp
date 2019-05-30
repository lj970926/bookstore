<%--
  Created by IntelliJ IDEA.
  User: lijin
  Date: 2019/5/27
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bookstore.BookBean" %>
<%@ page import="bookstore.Database" %>
<%@ page import="java.util.List" %>
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
        if (user.getType() == 0) {

    %>
    <jsp:forward page="usersuccess.jsp"></jsp:forward>
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
<h2 class="text-center"><strong>添加图书信息</strong></h2>
<div class="container">
    <div class="row">
        <div class="col-sm-4 col-sm-offset-4">
            <form action="${pageContext.request.contextPath}/AddbookServlet" class="text-center" method="post">
                <div class="form-group">
                    <label for="name">书名</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="书名">
                </div>
                <div class="form-group">
                    <label for="price">单价</label>
                    <input type="text" id="price" name="price" class="form-control" placeholder="单价">
                </div>
                <div class="form-group">
                    <label for="number">数量</label>
                    <input type="text" class="form-control" name="number" id="number" placeholder="数量">
                </div>
                <button type="submit" class="btn btn-lg btn-primary">添加图书信息</button>
            </form>
            <%
                String error = "";
                if (session.getAttribute("erroradd") != null) {
            %>
            <%
                    error = (String) session.getAttribute("erroradd");
                }
            %>
            <label class="text-center"><font color="red"><%=error%>
            </font> </label>
        </div>

    </div>
</div>

</body>
</html>
