package com.workhub.controller;

import com.workhub.service.AttendanceService;
import com.workhub.service.DepartmentService;
import com.workhub.service.LeaveApplyService;
import com.workhub.service.MeetingApplyService;
import com.workhub.service.NoticeService;
import com.workhub.service.UserService;
import com.workhub.util.SessionUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/home")
public class HomeController {
    @Resource
    private UserService userService;
    @Resource
    private DepartmentService departmentService;
    @Resource
    private NoticeService noticeService;
    @Resource
    private AttendanceService attendanceService;
    @Resource
    private LeaveApplyService leaveApplyService;
    @Resource
    private MeetingApplyService meetingApplyService;

    @RequestMapping("/index")
    public String index(Model model, HttpSession session) {
        model.addAttribute("userCount", userService.list().size());
        model.addAttribute("departmentCount", departmentService.list().size());
        model.addAttribute("noticeCount", noticeService.list().size());
        model.addAttribute("attendanceCount", attendanceService.list().size());
        model.addAttribute("leaveCount", leaveApplyService.list().size());
        model.addAttribute("meetingCount", meetingApplyService.list().size());
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        return "home/index";
    }
}
