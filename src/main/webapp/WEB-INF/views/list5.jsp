<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<%--
bootstrap完成员工新增工功能,以及前后台验证功能
员工数据的编辑完成
--%>


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


    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>

<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="empNameAddInput">empName</label>
                            <input type="text" class="form-control" name="empName" id="empNameAddInput" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="emailAddInput">email</label>
                            <input type="text" class="form-control" name="email" id="emailAddInput" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="genderss">性别</label>
                            <div id="genderss">
                                <label class="radio-inline">
                                    <input type="radio"  name="gender" id="gender1AddInput" value="M">男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio"  name="gender" id="gender2AddInput" value="S">女
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="emailAddInput">deptName</label>
                            <div class="col-sm-10">
                                <select name="dId" id="deptSelect" class="form-control">
                                </select>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="empSaveBtn">保存</button>
            </div>
        </div>
    </div>
</div>


<%--员工修改的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabelUpdate">New message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="empNameUpdateStatic">empName</label>
                            <p class="form-control-static" id="empNameUpdateStatic"></p>
                            <span class="help-block"></span>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="emailUpdateInput">email</label>
                            <input type="text" class="form-control" name="email" id="emailUpdateInput" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="genderss">性别</label>
                            <div id="genderUpdate">
                                <label class="radio-inline">
                                    <input type="radio"  name="gender" id="gender1UpdateInput" value="M">男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio"  name="gender" id="gender2UpdateInput" value="S">女
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="emailUpdateInput">deptName</label>
                            <div class="col-sm-10">
                                <select name="dId" id="deptUpdateSelect" class="form-control">
                                </select>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="empUpdateBtn">更新</button>
            </div>
        </div>
    </div>
</div>

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
                <button class="btn btn-primary" id="empAddModalBtn">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>

        </div>
            <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="empsTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                   <tbody>


                   </tbody>
                </table>
            </div>
        </div>
            <%--显示分页信息--%>
        <div class="row" >
            <%--分页文字信息--%>
            <div class="col-md-6" id="pageInfoArea">
            </div>
            <%--分页条信息--%>
            <div class="col-md-6" id="pageNavArea">



            </div>
        </div>

    </div>


<script>
    // 总记录数
    var totalRecord;
    // 本页面
    var currentPage;
    $(function(){

        toPage(1);
    });

    function buildEmpsTable(result){
        $('#empsTable tbody').empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (i, item) {
            var empIdTd =  $("<td></td>").append(item.empId);
            var empNameTd =  $("<td></td>").append(item.empName);
            var gender = item.gender == 'M'?'男':'女';
            var genderTd =  $("<td></td>").append(gender);
            var emailTd =  $("<td></td>").append(item.email);
            var deptNameTd =  $("<td></td>").append(item.department.deptName);
            // 为编辑按钮添加一个自定义的属性,表示当前员工的id
            var editBtn = '<button class="btn btn-primary btn-sm edit_btn" emp_id='+item.empId+'> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑 </button>';


            // 第二种方式
            var editBtn2 = $('<button></button>')
                .addClass('btn btn-primary btn-sm')
                .append($('<span></span>')
                    .addClass('glyphicon glyphicon-trash')
                    .append('编辑')
                );
            var delBtn = '<button class="btn btn-danger btn-sm delete_btn"> <span  class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除 </button>';

            $('<tr></tr>').append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append('<td>'+editBtn+"&nbsp;"+delBtn+"</td>")
                // .append(editBtn)
                // .append(delBtn)
                .appendTo('#empsTable tbody');
        });
    }
    // 分页文字信息
    function buildPageInfo(result) {
        $('#pageInfoArea').empty();
        var x = result.extend.pageInfo;
        $('#pageInfoArea').append('当前:'+x.pageNum+'页,总'+x.pages+'页,总共'+x.total+'条记录!')
        totalRecord= x.total;
        currentPage = x.pageNum;
    }
    // 分页条数据
    function buildPageNav(result){
        $('#pageNavArea').empty();
        var x = result.extend.pageInfo.navigatepageNums;

        var ul = $('<ul></ul>')
                .addClass("pagination");
        var firstPageLi = $('<li></li>')
                        .append($('<a></a>')
                            .append("首页")
                            .attr("href","#")
                        );

        var lastPageLi = $('<li></li>')
            .append($('<a></a>')
                .append("末页")
                .attr("href","#")
            );


        var prePageLi = $('<li></li>')
            .append($('<a></a>')
                .append("&laquo;")
                .attr("href","#")
            );
        var nextPageLi = $('<li></li>')
            .append($('<a></a>')
                .append("&raquo;")
                .attr("href","#")
            );
        if(result.extend.pageInfo.hasPreviousPage ==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                toPage(1);
            });
            prePageLi.click(function () {
                toPage(result.extend.pageInfo.pageNum - 1);
            });
        }
        if(result.extend.pageInfo.hasNextPage ==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                toPage(result.extend.pageInfo.pageNum + 1);
            })
            lastPageLi.click(function () {
                toPage(result.extend.pageInfo.pages);
            });

        }


        ul.append(firstPageLi)
            .append(prePageLi);


        $.each(result.extend.pageInfo.navigatepageNums, function (i, item) {
            var numLi = $('<li></li>')
                .append($('<a></a>')
                    .append(item)
                    .attr("href","#")
                );
            if(item == result.extend.pageInfo.pageNum){
                numLi.addClass("active")
            }
            numLi.click(function (){
                toPage(item);
            })
            ul.append(numLi);
        });
        ul.append(nextPageLi)
            .append(lastPageLi);

        var navEle = $('<nav></nav>')
                        .append(ul);
        navEle.appendTo('#pageNavArea');
    }

    function toPage(pn){
        $.ajax({
            type: "get",
            url:"${APP_PATH}/empsJson",
            data:"pn="+pn,
            cache: false,
            processData: false,
            contentType: false,
            success: function (result) {
                // 解析员工表格
                buildEmpsTable(result);
                buildPageInfo(result);
                buildPageNav(result);
            },
            error: function(data) {

            }
        });
    }
    //清空表单样式及内容
    function resetForm(ele){
        //调用js的重置表单内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    $('#empAddModalBtn').click(function () {
        resetForm("#empAddModal form");

        // 获取部门下拉框
        getDepts('#deptSelect');
        $('#empAddModal').modal({
            backdrop : "static"
        });

    });

    /*渲染贼新增页面部门下拉框*/
    function getDepts(ele) {
        // 清空原来下拉框的值
        $(ele).empty();
        $.ajax({
            type: "get",
            url:"${APP_PATH}/depts",
            cache: false,
            processData: false,
            contentType: false,
            success: function (result) {
                $.each(result.extend.depts, function (i, item) {
                    var optionEl = $('<option></option>')
                                    .append(item.deptName)
                                    .attr('value',item.deptId);
                    optionEl.appendTo(ele);
                });
            },
            error: function(data) {

            }
        });
    }

    // 保存员工
    $('#empSaveBtn').click(function () {
        // if(!validateAddForm()){
        //     return;
        // }
        if($('#empNameAddInput').attr('ajax-va')=="error"){
            return false;
        };

        $.ajax({
            url:"${APP_PATH}/emp",
            type: "POST",
            data:$('#empAddModal form').serialize(),
            success: function (result) {
                根据返回值
                if(result.code == 100) {
                    // 关闭模态框
                    $('#empAddModal').modal('hide');
                    // 来到最后一页查看新增的数据
                    toPage(totalRecord);
                }else {
                    // console.log(result);
                    // 显示失败信息
                    // 有哪个字段后台校验失败,就在哪个字段下进行提示
                    if(undefined != result.extend.error.email) {
                        // 显示邮箱错误提示信息
                        showValidateMsg("#emailAddInput","error",result.extend.error.email)
                    }
                    if(undefined != result.extend.error.empName) {
                        // 显示员工名字错误提示信息
                        showValidateMsg("#empNameAddInput","error",result.extend.error.empName)
                    }
                }

            },
            error: function(data) {

            }
        });
    });

    // 校验
    function validateAddForm() {
        // 用户名校验
        var empName = $("#empNameAddInput").val();
        // /^[a-zA-Z0-9_-]{6-16}$/     小写a-z大写A-Z,下划线,短横,6到16位
        ///(^[a-zA-Z0-9_-]{6-16}$)(^[\u2E80-\u9FFF]{2,5})/  并且允许中文字符, 2到5位
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            showValidateMsg("#empNameAddInput","error","用户名为2-5个中文或者6-16个英文和数字的组合!");
            // $("#empNameAddInput")
            //         .parent()
            //         .addClass("has-error");
            // $("#empNameAddInput")
            //         .next("span")
            //         .text("用户名为2-5个中文或者6-16个英文和数字的组合!");
            return false;
        }else{
            showValidateMsg("#empNameAddInput","success","");
            // $("#empNameAddInput")
            //     .parent()
            //     .addClass("has-success");
            // $("#empNameAddInput")
            //     .next("span")
            //     .text("");
        }
        // 邮箱校验
        var email = $('#emailAddInput').val();
        var emailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if(!emailReg.test(email)){
            showValidateMsg("#emailAddInput","error","邮箱格式不正确!");
            // $("#emailAddInput")
            //     .parent()
            //     .addClass("has-error");
            // $("#emailAddInput")
            //     .next("span")
            //     .text("邮箱格式不正确!");
            return false;
        }else{
            showValidateMsg("#emailAddInput","success","");
            // $("#emailAddInput")
            //     .parent()
            //     .addClass("has-success");
            // $("#emailAddInput")
            //     .next("span")
            //     .text("");
        }
        return true;
    }
    // 校验提示信息
    function showValidateMsg(ele,status,msg){
        $(ele).parent()
            .removeClass("has-success has-error");
        $(ele)
            .next("span")
            .text("");
        if("success"==status){
            $(ele)
                .parent()
                .addClass("has-success");
            $(ele)
                .next("span")
                .text("");

        }else if("error" == status){
            $(ele)
                .parent()
                .addClass("has-error");
            $(ele)
                .next("span")
                .text(msg);
        }

    }

    // 校验用户名是否可用
    /*TEMP临时
    $('#empNameAddInput').change(function () {
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+this.value,
            type: "POST",
            success: function (result) {
                if(result.code==100) {
                    showValidateMsg("#empNameAddInput","success","用户名可用!")
                    $('#empNameAddInput').attr('ajax-va',"success");
                }else{
                    showValidateMsg("#empNameAddInput","error","用户名不可用!")
                    $('#empNameAddInput').attr('ajax-va',"error");
                }
            },
            error: function(data) {

            }
        });

    });
    */

    /*重要   控件加载之后绑定事件*/
    /*
    $('.edit_btn').click(function () {
        alert(11122)
    });
    我们的按钮是创建之前就绑定了click,绑定不上
        1,可以在创建按钮的时候添加onclick方法
        2,绑定点击.live()方法   live()方法对即使后来添加的元素也可以用
        3,Jquery新版没有live()方法,使用on进行替代
    */
    $(document).on("click",".edit_btn",function(){
        // 查出员工信息,并显示员工信息
        getEmp($(this).attr("emp_id"));
        // 查出部门信息,并显示部门列表
        getDepts('#deptUpdateSelect');
        // 把员工的id传递给模态框的更新按钮
        $('#empUpdateBtn').attr("emp_id",$(this).attr("emp_id"));
        $('#empUpdateModal').modal({
            backdrop : "static"
        });
    })
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type: "GET",
            success: function (result) {
                var emp = result.extend.emp;
                $('#empNameUpdateStatic').text(emp.empName);
                $('#emailUpdateInput').val(emp.email);
                $('#empUpdateModal input[name=\'gender\']').val([emp.gender]);
                $('#empUpdateModal select').val([emp.dId]);
            }
        });
    }
    $('#empUpdateBtn').click(function () {
        // 验证邮箱
        var email = $('#emailUpdateInput').val();
        var emailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if(!emailReg.test(email)) {
            showValidateMsg("#emailAddInput", "error", "邮箱格式不正确!");
        }else{
            showValidateMsg("#emailAddInput", "success", "");
        }
        // 保存
        // 第一种发送PUT请求的方式
        /*
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("emp_id"),--%>
            type: "POST",
            data:$('#empUpdateModal form').serialize()+"&_method=PUT",
            success: function (result) {
               alert(result.msg);
            }
        });
        */

        /*
        第二种发送PUT的方式
        问题:
            直接发送PUT请求,封账的数据:
                Employee{empId=1, empName='null', gender='null', email='null', dId=null, department=null}
            请求体中有数据,但是Employee对象封装不上去
        原因:
            1,Tomcat将请求体中的数据,封装一个map
            2,request.getParamter("empName")就会从这个map中取值
            3,SpringMVC封装POJO对象的时候
                    会吧POJO中每个属性的值,request.getParamter("empName");
        AJAX发送PUT请求引发的问题:
            PUT请求,请求体中的数据,request.getParamter("empName")拿不到
            Tomcat一看是PUT就不会封装请求体中的数据map,只有POST形式才封装请求体为map的数据
        org.appach.tomcat.
        解决方式:
        web.xml文件中配置
             <!--配置PUT请求的拦截-->
              <filter>
                  <filter-name>HttpPutFormContentFilter</filter-name>
                  <filter-class>org.springframework.web.filter.HttpPutFormContentFilter</filter-class>
              </filter>
              <filter-mapping>
                <filter-name>HttpPutFormContentFilter</filter-name>
                <url-pattern>/*</url-pattern>
              </filter-mapping>

        总结说:
            1,发送请求时携带参数
                +"&_method=PUT"
            2,web.xml配置过滤器
        */
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("emp_id"),
            type: "PUT",
            data:$('#empUpdateModal form').serialize(),
            success: function (result) {
                $('#empUpdateModal').modal('hide');
                toPage(currentPage);
            }
        });
    })

</script>

</body>
</html>
