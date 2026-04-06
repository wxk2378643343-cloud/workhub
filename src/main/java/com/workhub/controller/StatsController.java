package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.service.AttendanceService;
import com.workhub.service.DepartmentService;
import com.workhub.service.LeaveApplyService;
import com.workhub.service.MeetingApplyService;
import com.workhub.service.ReportService;
import com.workhub.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.LinkedHashMap;
import java.util.Map;

@Controller
@RequestMapping("/stats")
public class StatsController {
    @Resource
    private UserService userService;
    @Resource
    private DepartmentService departmentService;
    @Resource
    private AttendanceService attendanceService;
    @Resource
    private LeaveApplyService leaveApplyService;
    @Resource
    private ReportService reportService;
    @Resource
    private MeetingApplyService meetingApplyService;

    @GetMapping("/index")
    public String index(Model model) {
        model.addAttribute("chartData", buildSummary());
        return "stats/index";
    }

    @GetMapping("/summary")
    @ResponseBody
    public ApiResponse<Map<String, Integer>> summary() {
        return ApiResponse.success(buildSummary());
    }

    private Map<String, Integer> buildSummary() {
        Map<String, Integer> map = new LinkedHashMap<>();
        map.put("员工", userService.list().size());
        map.put("部门", departmentService.list().size());
        map.put("考勤", attendanceService.list().size());
        map.put("请假", leaveApplyService.list().size());
        map.put("报告", reportService.list().size());
        map.put("会议", meetingApplyService.list().size());
        return map;
    }
}
