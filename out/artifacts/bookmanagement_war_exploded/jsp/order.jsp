<%--
  Created by IntelliJ IDEA.
  User: lijin
  Date: 2019/5/27
  Time: 15:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bookstore.BookBean" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + '/';
    %>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <title>订单信息</title>
</head>
<body>
<%
    List<BookBean> list = (List<BookBean>) session.getAttribute("cart");
    double sum = 0.0;
%>
<table class="table table-striped">
    <thead>
    <tr>
        <th>书名</th>
        <th>单价</th>
        <th>数量</th>
        <th>合计</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (list != null){
            for (BookBean b : list) {
                sum += b.getPrice() * b.getNumber();
    %>
    <tr>
        <td><%=b.getName()%>
        </td>
        <td><%=b.getPrice()%>
        </td>
        <td><%=b.getNumber()%>
        </td>
        <td><%=b.getPrice() * b.getNumber()%>
        </td>
    </tr>
    <%
            }
        session.removeAttribute("sum");
        session.setAttribute("sum",sum);
        }
    %>
    </tbody>
</table>
<h2 class="text-center">总金额： <%=sum%>
</h2>
<form class="text-center" method="post" action="${pageContext.request.contextPath}/BookOrderServlet">
    <button type="submit" class="btn btn-primary btn-lg">支付</button>
</form>

</body>
</html>
