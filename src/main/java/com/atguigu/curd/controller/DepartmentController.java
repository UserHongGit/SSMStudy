package com.atguigu.curd.controller;

import com.atguigu.curd.bean.Department;
import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.bean.Msg;
import com.atguigu.curd.service.DepartmentService;
import com.atguigu.curd.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理部门有关的请求
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /**
     * 新增员工下拉框数据
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> li = departmentService.getDepts();
        return Msg.success().add("depts",li);
    }



}
