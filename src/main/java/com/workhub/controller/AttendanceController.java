package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.Attendance;
import com.workhub.entity.User;
import com.workhub.service.AttendanceService;
import com.workhub.util.SessionUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
    @Resource
    private AttendanceService attendanceService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        boolean admin = "ADMIN".equals(loginUser.getRoleCode());
        model.addAttribute("records", admin ? attendanceService.list() : attendanceService.listByUserId(loginUser.getId()));
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("todayRecord", admin ? null : attendanceService.getTodayRecord(loginUser.getId()));
        return "attendance/list";
    }

    @PostMapping("/save")
    @ResponseBody
    public ApiResponse<String> save(Attendance attendance) {
        attendanceService.save(attendance);
        return ApiResponse.success("保存成功");
    }

    @PostMapping("/delete")
    @ResponseBody
    public ApiResponse<String> delete(Long id) {
        attendanceService.delete(id);
        return ApiResponse.success("删除成功");
    }

    @PostMapping("/checkIn")
    @ResponseBody
    public ApiResponse<String> checkIn(HttpSession session) {
        try {
            attendanceService.checkIn(SessionUtil.getLoginUser(session).getId());
            return ApiResponse.success("上班打卡成功");
        } catch (IllegalStateException e) {
            return ApiResponse.fail(e.getMessage());
        }
    }

    @PostMapping("/checkOut")
    @ResponseBody
    public ApiResponse<String> checkOut(HttpSession session) {
        try {
            attendanceService.checkOut(SessionUtil.getLoginUser(session).getId());
            return ApiResponse.success("下班打卡成功");
        } catch (IllegalStateException e) {
            return ApiResponse.fail(e.getMessage());
        }
    }
}
