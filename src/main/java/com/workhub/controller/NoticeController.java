package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.Notice;
import com.workhub.service.NoticeService;
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
@RequestMapping("/notice")
public class NoticeController {
    @Resource
    private NoticeService noticeService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("notices", noticeService.list());
        return "notice/list";
    }

    @PostMapping("/save")
    @ResponseBody
    public ApiResponse<String> save(Notice notice, HttpSession session) {
        if (notice.getPublisherId() == null && SessionUtil.getLoginUser(session) != null) {
            notice.setPublisherId(SessionUtil.getLoginUser(session).getId());
        }
        noticeService.save(notice);
        return ApiResponse.success("保存成功");
    }

    @PostMapping("/delete")
    @ResponseBody
    public ApiResponse<String> delete(Long id) {
        noticeService.delete(id);
        return ApiResponse.success("删除成功");
    }
}
