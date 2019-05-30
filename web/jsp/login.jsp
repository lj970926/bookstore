<%--
  Created by IntelliJ IDEA.
  User: lijin
  Date: 2019/5/25
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html lang="zh-CN">
<head>
    <%
        String path = request.getContextPath();
        String  basePath = request.getScheme()+"://" + request.getServerName() + ":" + request.getServerPort()+path + '/';
    %>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <title>欢迎使用书店管理系统</title>
</head>
<body>
<div class="container text-center">
    <div class="row">
        <div class="col-sm-offset-4 col-sm-4">
            <form method="post" action="${pageContext.request.contextPath}/jsp/loginValidate.jsp">
                <div class="form-group">
                    <h2><strong>欢迎使用网上书店系统</strong></h2>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="email">邮箱</label>
                    <input id = "email" name="email" class="form-control" type="email"
                           placeholder="请输入用户邮箱" value=<%=request.getParameter("email")==null?"":request.getParameter("email")%>>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="pwd">密码</label>
                    <input id="pwd" name="pwd" class="form-control" type="password"
                           placeholder="请输入密码" value=<%=request.getParameter("pwd")==null?"":request.getParameter("pwd")%>>
                </div>
                <div class="form-group">
                    <a class="col-sm-6" href="../index.jsp">忘记密码</a>
                    <a class="col-sm-6" href="register.jsp">用户注册</a>
                </div>
                <div class="row">
                    <button name="user" value="yes" type="submit" class="btn btn-lg btn-primary col-sm-6" >用户登陆</button>
                    <button name="manager" value="yes" type="submit" class="btn btn-lg btn-primary col-sm-6" >管理员登陆</button>
                </div>

            </form>
            <%
                String message = "";
                if (request.getAttribute("error_login")!=null)
                    message = (String) request.getAttribute("error_login");
            %>
            <label><font color=red><%=message%></font></label>
        </div>
    </div>
</div>

</body>
</html>
