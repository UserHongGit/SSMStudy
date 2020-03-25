package com.atguigu.curd.test;

import com.atguigu.curd.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能,测试CURD请求的正确性
 */
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcher-servlet.xml"})
public class MvcTest {

//    传入SPringMvc的IOC
    @Autowired
    WebApplicationContext context;
    //虚拟的mvc请求,获取到处理结果
    MockMvc mockMvc;

    @Before     //每次执行前都需要init
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public  void testPage() throws  Exception{
        //模拟request请求,并且获取返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps")
                .param("pn", "5"))
                .andReturn();
        //正确请求成功后,请求域中会有pageInfo,我们可以取出pageInfo验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo =(PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码"+pageInfo.getPageNum()
                +",总页码:"+pageInfo.getPages()
                +",总记录数:"+pageInfo.getTotal()
                +",页面需要连续显示的页码:"
        );
        int[] nums = pageInfo.getNavigatepageNums();
        for(int i : nums) {
            System.out.println(""+i);
        }
        //获取员工信息
        List<Employee> list = pageInfo.getList();
        for(Employee e : list) {
            System.out.println("ID:"+e.getEmpId()+",Name:"+e.getEmpName());
        }

    }



}
