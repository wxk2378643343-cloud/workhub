package com.workhub.interceptor;

import com.workhub.util.SessionUtil;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (SessionUtil.isLogin(request.getSession())) {
            return true;
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return false;
    }
}
