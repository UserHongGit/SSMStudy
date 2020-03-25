<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<%--直接页面之间的跳转  分页--%>
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


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>

<%--页面请求返回页面,构建展示页面--%>
<%--请求返回页面 模式,非ajax模式--%>
<body>
<%--    搭建显示页面--%>
    <div id="container">
            <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
            <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>

        </div>
            <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span  class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
            <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前:${pageInfo.pageNum}页,总${pageInfo.pages}页,总共${pageInfo.total}条记录!
            </div>
            <%--分页条信息--%>
            <div class="col-md-6">


                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li>
                            <a class="page-link" href="${APP_PATH}/emps">首页</a>
                        </li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li class="page-item">
                                <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                    <span class="sr-only">Previous</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num==pageInfo.pageNum}">
                                <li class="active"><a  href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num!=pageInfo.pageNum}">
                                <li class="page-item"><a class="page-link" href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>

                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li class="page-item">
                                <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </li>
                        </c:if>

                        <li>
                            <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a>
                        </li>
                    </ul>
                </nav>


            </div>
        </div>

    </div>



</body>
</html>
