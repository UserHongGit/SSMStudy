package com.atguigu.curd.service;

import com.atguigu.curd.bean.Department;
import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.dao.DepartmentMapper;
import com.atguigu.curd.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;


    public List<Department> getDepts() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
