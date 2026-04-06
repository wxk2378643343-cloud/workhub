package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.User;
import com.workhub.service.AuthService;
import com.workhub.util.SessionUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {
    @Resource
    private AuthService authService;

    @PostMapping("/login")
    @ResponseBody
    public ApiResponse<String> login(String username, String password, HttpSession session) {
        User user = authService.login(username, password);
        if (user == null) {
            return ApiResponse.fail("用户名或密码错误");
        }
        SessionUtil.setLoginUser(session, user);
        return ApiResponse.success("/home/index");
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        SessionUtil.clear(session);
        return "redirect:/login.jsp";
    }
}
