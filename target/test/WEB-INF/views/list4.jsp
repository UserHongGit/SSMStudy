<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<%--
bootstrap完成员工新增工功能,以及前后台验证功能完成
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
    var totalRecord;
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
            var editBtn = '<button class="btn btn-primary btn-sm"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑 </button>';
            // 第二种方式
            var editBtn2 = $('<button></button>')
                .addClass('btn btn-primary btn-sm')
                .append($('<span></span>')
                    .addClass('glyphicon glyphicon-trash')
                    .append('编辑')
                );
            var delBtn = '<button class="btn btn-danger btn-sm"> <span  class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除 </button>';

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
        getDepts();
        $('#empAddModal').modal({
            backdrop : "static"
        });

    });

    /*渲染贼新增页面部门下拉框*/
    function getDepts() {
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
                    optionEl.appendTo('#deptSelect');
                });
            },
            error: function(data) {

            }
        });
    }

    // 保存员工
    $('#empSaveBtn').click(function () {
        if(!validateAddForm()){
            return;
        }
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



</script>

</body>
</html>
