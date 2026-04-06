package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.Department;
import com.workhub.service.DepartmentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/department")
public class DepartmentController {
    @Resource
    private DepartmentService departmentService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("departments", departmentService.list());
        return "department/list";
    }

    @PostMapping("/save")
    @ResponseBody
    public ApiResponse<String> save(Department department) {
        departmentService.save(department);
        return ApiResponse.success("保存成功");
    }

    @PostMapping("/delete")
    @ResponseBody
    public ApiResponse<String> delete(Long id) {
        departmentService.delete(id);
        return ApiResponse.success("删除成功");
    }
}
