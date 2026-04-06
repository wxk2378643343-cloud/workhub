package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.Department;
import com.workhub.entity.User;
import com.workhub.service.DepartmentService;
import com.workhub.service.UserService;
import com.workhub.util.SessionUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;
    @Resource
    private DepartmentService departmentService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        model.addAttribute("users", userService.list());
        model.addAttribute("departments", departmentService.list());
        model.addAttribute("employees", userService.listEmployees());
        model.addAttribute("loginUser", loginUser);
        return "user/list";
    }

    @GetMapping("/profile")
    public String profile(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        List<Department> departments = departmentService.list();
        model.addAttribute("user", userService.getById(loginUser.getId()));
        model.addAttribute("departments", departments);
        model.addAttribute("loginUser", loginUser);
        return "user/profile";
    }

    @PostMapping("/save")
    @ResponseBody
    public ApiResponse<String> save(User user) {
        if (user.getId() == null) {
            userService.save(user);
        } else {
            userService.update(user);
        }
        return ApiResponse.success("保存成功");
    }

    @PostMapping("/password")
    @ResponseBody
    public ApiResponse<String> updatePassword(Long id, String password) {
        userService.updatePassword(id, password);
        return ApiResponse.success("密码修改成功");
    }

    @PostMapping("/delete")
    @ResponseBody
    public ApiResponse<String> delete(Long id) {
        userService.delete(id);
        return ApiResponse.success("删除成功");
    }
}
