package com.atguigu.curd.test;

import com.atguigu.curd.bean.Department;
import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.bean.EmployeeExample;
import com.atguigu.curd.dao.DepartmentMapper;
import com.atguigu.curd.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

import static org.junit.Assert.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTestTest {

    /**
     * 测试DepartmentMapper
     * 使用传统方式
     */
//    @Test
//    public void testCRUD(){
//        //1,创建SpringIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        //2,从容器中获取mpper
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
//    }

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    /**
     * 使用Spring的单元测试,可以自动注入到我们需要的组件
     * 1,首先需要导入SpringTest模块
     * 2,@ContextConfiguration指定Spring配置文件的位置
     * 3,直接autowried注入
     *
     */
    @Test
    public void testCRUD2(){
        System.out.println(departmentMapper);
//        插入部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//        插入员工
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1,null));
//        批量插入     可以执行批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i<1000;i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1,null));
        }
        System.out.println("批量执行完成");
    }
}