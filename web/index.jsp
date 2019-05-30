<%@ page import="bookstore.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: lijin
  Date: 2019/5/23
  Time: 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <!--mobile device support-->
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>欢迎使用网上书店系统</title>
</head>
<body>
<%
    if (session.getAttribute("loginuser") == null) {
%>
<jsp:forward page="/jsp/login.jsp"></jsp:forward>
<%
    }
    UserBean user = (UserBean) session.getAttribute("loginuser");
    if (user.getType() == 0){
%>
<jsp:forward page="/jsp/usersuccess.jsp"></jsp:forward>
<%
    }
    else
%>
<jsp:forward page="/jsp/managersuccess.jsp"></jsp:forward>
</body>
</html>

