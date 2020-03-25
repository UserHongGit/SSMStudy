<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<jsp:forward page="/emps"></jsp:forward>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<%--
web路径:
不以/开始的相对路径,找资源,以当前资源的路径为基准,经常容易出问题
以/开始的相对路径,找资源,以服务器的路径为标准(http://location:3306)需要加上项目名
        http://location:3306/test
--%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE" />


    <script src="${APP_PATH}/static/js/jquery-1.7.1.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>





</body>
</html>
