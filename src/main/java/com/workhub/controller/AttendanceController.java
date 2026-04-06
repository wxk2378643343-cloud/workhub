package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.Attendance;
import com.workhub.entity.User;
import com.workhub.service.AttendanceService;
import com.workhub.service.AuthzService;
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

    @Resource
    private AuthzService authzService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        model.addAttribute("records", attendanceService.listByUserId(loginUser.getId()));
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("todayRecord", attendanceService.getTodayRecord(loginUser.getId()));
        return "attendance/list";
    }

    @GetMapping("/view")
    public String view(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        if (!authzService.isAdmin(loginUser) && !authzService.isLeader(loginUser)) {
            return "redirect:/home/index";
        }
        model.addAttribute("records", attendanceService.list());
        model.addAttribute("loginUser", loginUser);
        return "attendance/view";
    }

    @PostMapping("/save")
    @ResponseBody
    public ApiResponse<String> save(Attendance attendance) {
        return ApiResponse.fail("请使用上下班打卡，不支持手工指定员工ID");
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
            return ApiResponse.success("上班打卡成功，已记录最后一次时间");
        } catch (IllegalStateException e) {
            return ApiResponse.fail(e.getMessage());
        }
    }

    @PostMapping("/checkOut")
    @ResponseBody
    public ApiResponse<String> checkOut(HttpSession session) {
        try {
            attendanceService.checkOut(SessionUtil.getLoginUser(session).getId());
            return ApiResponse.success("下班打卡成功，已记录最后一次时间");
        } catch (IllegalStateException e) {
            return ApiResponse.fail(e.getMessage());
        }
    }
}
