package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.GoodsApply;
import com.workhub.entity.User;
import com.workhub.service.AuthzService;
import com.workhub.service.GoodsApplyService;
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
@RequestMapping("/goods")
public class GoodsApplyController {
    @Resource
    private GoodsApplyService goodsApplyService;
    @Resource
    private AuthzService authzService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        boolean canApprove = authzService.isAdmin(loginUser) || authzService.isLeader(loginUser);
        model.addAttribute("records", canApprove ? goodsApplyService.list() : goodsApplyService.listByUserId(loginUser.getId()));
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("canApprove", canApprove);
        return "goods/list";
    }

    @PostMapping("/save")
    @ResponseBody
    public ApiResponse<String> save(GoodsApply goodsApply, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        if (!authzService.isAdmin(loginUser)) {
            goodsApply.setUserId(loginUser.getId());
        }
        goodsApplyService.save(goodsApply);
        return ApiResponse.success("提交成功");
    }

    @PostMapping("/approve")
    @ResponseBody
    public ApiResponse<String> approve(GoodsApply goodsApply, Long applicantUserId, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        if (!authzService.canApproveUser(loginUser, applicantUserId)) {
            return ApiResponse.fail("只有管理员或该员工部门负责人可以审批");
        }
        goodsApplyService.approve(goodsApply);
        return ApiResponse.success("审批成功");
    }

    @PostMapping("/delete")
    @ResponseBody
    public ApiResponse<String> delete(Long id, Long applicantUserId, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        if (!authzService.canApproveUser(loginUser, applicantUserId)) {
            return ApiResponse.fail("只有管理员或负责人可以删除");
        }
        goodsApplyService.delete(id);
        return ApiResponse.success("删除成功");
    }
}
