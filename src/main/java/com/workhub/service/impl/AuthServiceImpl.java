package com.workhub.service.impl;

import com.workhub.entity.User;
import com.workhub.mapper.UserMapper;
import com.workhub.service.AuthService;
import com.workhub.util.Md5Util;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AuthServiceImpl implements AuthService {
    @Resource
    private UserMapper userMapper;

    @Override
    public User login(String username, String password) {
        User user = userMapper.findByUsername(username);
        if (user == null) {
            return null;
        }
        return Md5Util.md5(password).equals(user.getPassword()) ? user : null;
    }
}
