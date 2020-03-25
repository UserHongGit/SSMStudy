package com.atguigu.curd.controller;

import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.bean.Msg;
import com.atguigu.curd.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的CRUD请求
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    /**
     * 查询员工数据   返回页面方式
     * @return
     */
    @RequestMapping("/emps")
    public  String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper分页插件
        //在查询之前只需要调用startPage(页码,每页大小)
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需要将PageInfo返回页面就可以获取所有信息
        //封装了详细的分页信息,包括查询出来的数据
        //PageInfo(数据,连续显示的页数)
        PageInfo page = new PageInfo(list,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }

    /**
     * 查询员工数据 返回Json数据方式
     * 想要ResponseBody起作用需要导入Jackson的jar包
     */
    @ResponseBody
    @RequestMapping("/empsJson")
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        System.out.println(pn);
        //引入PageHelper分页插件
        //在查询之前只需要调用startPage(页码,每页大小)
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需要将PageInfo返回页面就可以获取所有信息
        //封装了详细的分页信息,包括查询出来的数据
        //PageInfo(数据,连续显示的页数)
        PageInfo page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 跳转到list2.jsp
     */
    @RequestMapping("/toList2")
    public  String toList2(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        return "list2";
    }

    /**
     * REST风格请求
     *
     * @Valid 修饰的属性会进行JSR303校验,打开实体类对象,使用@Pattern进行验证格式
     * BindingResult result  可以获取到如果验证失败之后的信息
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
//        判断是否校验有错误
        if(result.hasErrors()) {
//            获取全部的校验失败错误
            List<FieldError> errors = result.getFieldErrors();
            Map<String,Object> map = new HashMap<>();
            for (FieldError e : errors) {
                System.out.println("错误的字段名字:"+e.getField());
                System.out.println("错误信息"+e.getDefaultMessage());
                map.put(e.getField(), e.getDefaultMessage());
            }
            return  Msg.fail().add("error", map);
        }else {
            employeeService.saveEmp(employee);
        }
        return Msg.success();
    }

    /**
     * 检验用户名是否可用
     */
    @ResponseBody
    @RequestMapping(value = "/checkUser")
    public Msg checkUser(String empName){
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        boolean matches = empName.matches(regName);
        if(!matches) {
            return  Msg.fail().add("msg","用户名不合法!");
        }
        boolean b = employeeService.checkUser(empName);
        if(b) {
            return Msg.success();
        }else {
            return  Msg.fail().add("msg", "用户名不可用!");
        }
    }

    /**
     * 根据id查询员工
     * REST风格
     * @PathVariable("id")  指明参数id是从路径中获取的id的值
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
//        按照员工id查询员工信息
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 根据id更新员工
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee, HttpServletRequest request){
        System.out.println("获取__"+request.getParameter("gender"));
//        按照员工id查询员工信息
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     * 根据id删除单个员工
     * @return
     */
//    @ResponseBody
//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    public Msg deleteEmp(@PathVariable("id")Integer id){
//        employeeService.deleteEmp(id);
//        return Msg.success();
//    }


    /**
     * 删除单个员工和批量删除一起
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")) {
//            批量删除
            String[] idStrs = ids.split("-");
            List<Integer> idLi = new ArrayList<>();
            for(String id: idStrs) {
                idLi.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(idLi);
        }else {
//            单个删除
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }



}
