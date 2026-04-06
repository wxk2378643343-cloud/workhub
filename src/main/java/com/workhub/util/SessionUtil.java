package com.workhub.util;

import com.workhub.entity.User;

import javax.servlet.http.HttpSession;

public final class SessionUtil {
    public static final String LOGIN_USER = "loginUser";

    private SessionUtil() {
    }

    public static void setLoginUser(HttpSession session, User user) {
        session.setAttribute(LOGIN_USER, user);
    }

    public static User getLoginUser(HttpSession session) {
        Object value = session.getAttribute(LOGIN_USER);
        return value instanceof User ? (User) value : null;
    }

    public static boolean isLogin(HttpSession session) {
        return getLoginUser(session) != null;
    }

    public static void clear(HttpSession session) {
        session.removeAttribute(LOGIN_USER);
    }
}
