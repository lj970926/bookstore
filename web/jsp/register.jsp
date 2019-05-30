<%@ page import="java.util.Hashtable" %><%--
  Created by IntelliJ IDEA.
  User: lijin
  Date: 2019/5/26
  Time: 18:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String  basePath = request.getScheme()+"://" + request.getServerName() + ":" + request.getServerPort()+path + '/';
        String errorName = "",errorEmail = "",errorPwd = "",errType = "",errOther = "";
        String name = "",email = "";
        if (request.getParameter("userName")!=null) name = request.getParameter("userName");
        if (request.getParameter("email")!= null) email = request.getParameter("email");
        if (request.getAttribute("errors")!=null){
            Hashtable errors = (Hashtable) request.getAttribute("errors");
            if (errors.get("name") != null)
                errorName = (String) errors.get("name");
            if (errors.get("email")!=null)
                errorEmail = (String) errors.get("email");
            if (errors.get("passwd")!=null)
                errorPwd = (String)errors.get("passwd");
            if (errors.get("other")!=null)
                errOther = (String)errors.get("other");
            if (errors.get("type")!=null)
                errType = (String)errors.get("type");
        }
    %>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <title>用户注册</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <form action="${pageContext.request.contextPath}/ControllerServlet" method="post">
                    <div class="form-group text-center">
                        <h2><strong>用户注册</strong></h2>
                    </div>
                    <div class="form-group">
                        <label for="emailAddress">电子邮箱</label>
                        <input type="email" id = "emailAddress" placeholder="请输入电子邮箱"
                               class="form-control" name="email" value=<%=email%>>
                        <label><font color = "red"><%=errorEmail%></font></label>
                    </div>
                    <div class="form-group">
                        <label for="username">用户名</label>
                        <input type="text" id = "username" placeholder="请输入用户名"
                               class="form-control" name="userName" value=<%=name%>>
                        <label><font color="red"><%=errorName%></font> </label>
                    </div>
                    <div class="form-group">
                        <label for="passwd">密码</label>
                        <input type="password" id = "passwd" placeholder="请输入密码" class="form-control" name="pwd">
                        <label><font color="red"><%=errorPwd%></font></label>
                    </div>
                    <div class="form-group">
                        <label for="passwd">重复密码</label>
                        <input type="password" id = "passwdRp" placeholder="请再输一次" class="form-control" name="pwdRp">
                    </div>
                    <label class="text-left">请选择注册类型</label>
                    <div class="radio text-center">

                        <label>
                            <input type="radio" name="typeSelect" id = "op1" value="user">
                            用户注册
                        </label>
                        <label>
                            <input type="radio" name="typeSelect" id = "op2" value="manager">
                            管理员注册
                        </label>
                        <label><font color="red"><%=errType%></font> </label>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-info btn-block">提交</button>
                    </div>
                </form>
                <label><font color="red"><%=errOther%></font></label>
            </div>
        </div>

    </div>
</body>
</html>
