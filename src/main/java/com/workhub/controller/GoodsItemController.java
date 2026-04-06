package com.workhub.controller;

import com.workhub.common.ApiResponse;
import com.workhub.entity.GoodsItem;
import com.workhub.entity.User;
import com.workhub.service.AuthzService;
import com.workhub.service.GoodsItemService;
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
@RequestMapping("/goods/item")
public class GoodsItemController {
    @Resource
    private GoodsItemService goodsItemService;
    @Resource
    private AuthzService authzService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        if (!authzService.isAdmin(loginUser)) {
            return "redirect:/home/index";
        }
        model.addAttribute("records", goodsItemService.list());
        model.addAttribute("loginUser", loginUser);
        return "goods/item-list";
    }

    @PostMapping("/save")
    @ResponseBody
    public ApiResponse<String> save(GoodsItem goodsItem, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        if (!authzService.isAdmin(loginUser)) {
            return ApiResponse.fail("Only admin can operate");
        }
        goodsItemService.save(goodsItem);
        return ApiResponse.success("Save success");
    }

    @PostMapping("/delete")
    @ResponseBody
    public ApiResponse<String> delete(Long id, HttpSession session) {
        User loginUser = SessionUtil.getLoginUser(session);
        if (!authzService.isAdmin(loginUser)) {
            return ApiResponse.fail("Only admin can operate");
        }
        goodsItemService.delete(id);
        return ApiResponse.success("Delete success");
    }
}
