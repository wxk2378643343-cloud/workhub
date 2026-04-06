package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.MeetingApply;
import com.workhub.entity.MeetingRoom;
import com.workhub.entity.User;
import com.workhub.service.MeetingApplyService;
import com.workhub.service.MeetingRoomService;
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
@RequestMapping("/meeting")
public class MeetingController {
    @Resource
    private MeetingRoomService meetingRoomService;
    @Resource
    private MeetingApplyService meetingApplyService;

    @GetMapping("/rooms")
    public String rooms(Model model, HttpSession session) {
        model.addAttribute("rooms", meetingRoomService.list());
        model.addAttribute("loginUser", SessionUtil.getLoginUser(session));
        return "meeting/room-list";
    }

    @GetMapping("/apply/list")
    public String applyList(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        boolean admin = "ADMIN".equals(loginUser.getRoleCode());
        model.addAttribute("records", admin ? meetingApplyService.list() : meetingApplyService.listByUserId(loginUser.getId()));
        model.addAttribute("rooms", meetingRoomService.list());
        model.addAttribute("loginUser", loginUser);
        return "meeting/apply-list";
    }

    @PostMapping("/room/save")
    @ResponseBody
    public ApiResponse<String> saveRoom(MeetingRoom meetingRoom) {
        meetingRoomService.save(meetingRoom);
        return ApiResponse.success("保存成功");
    }

    @PostMapping("/apply/save")
    @ResponseBody
    public ApiResponse<String> saveApply(MeetingApply meetingApply) {
        try {
            meetingApplyService.save(meetingApply);
            return ApiResponse.success("提交成功");
        } catch (IllegalArgumentException e) {
            return ApiResponse.fail(e.getMessage());
        }
    }

    @PostMapping("/apply/approve")
    @ResponseBody
    public ApiResponse<String> approveApply(MeetingApply meetingApply) {
        meetingApplyService.approve(meetingApply);
        return ApiResponse.success("审批成功");
    }

    @PostMapping("/room/delete")
    @ResponseBody
    public ApiResponse<String> deleteRoom(Long id) {
        meetingRoomService.delete(id);
        return ApiResponse.success("删除成功");
    }

    @PostMapping("/apply/delete")
    @ResponseBody
    public ApiResponse<String> deleteApply(Long id) {
        meetingApplyService.delete(id);
        return ApiResponse.success("删除成功");
    }
}
