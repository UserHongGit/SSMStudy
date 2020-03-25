package com.atguigu.curd.bean;

public class Department {
    /**
         *  字段注释 : 
         *   表字段 : dept_id
     */
    private Integer deptId;

    public Department(Integer deptId, String deptName) {
        this.deptId = deptId;
        this.deptName = deptName;
    }

    public Department() {
    }

    /**
         *  字段注释 : 
         *   表字段 : dept_name
     */
    private String deptName;

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}