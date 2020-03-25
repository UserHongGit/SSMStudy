package com.atguigu.curd.bean;

import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.Pattern;

public class Employee {
    /**
         *  字段注释 : 
         *   表字段 : emp_id
     */
    private Integer empId;

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", dId=" + dId +
                ", department=" + department +
                '}';
    }

    /**
         *  字段注释 : 
         *   表字段 : emp_name
     */
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",message = "后台_用户名为2-5个中文或者6-16个英文和数字的组合!")
    private String empName;


    /**
         *  字段注释 : 
         *   表字段 : gender
     */
    private String gender;

    /**
         *  字段注释 : 
         *   表字段 : email
     */
    @Email(message = "后台_邮箱格式不正确")
    private String email;

    /**
         *  字段注释 : 
         *   表字段 : d_id
     */
    private Integer dId;

    public Employee(Integer empId, String empName, String gender, String email, Integer dId, Department department) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
        this.department = department;
    }

    public Employee() {
    }
    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    private Department department;



    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}