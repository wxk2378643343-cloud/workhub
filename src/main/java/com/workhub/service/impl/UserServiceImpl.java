package com.workhub.service.impl;

import com.workhub.entity.User;
import com.workhub.mapper.UserMapper;
import com.workhub.service.UserService;
import org.springframework.transaction.annotation.Transactional;
import com.workhub.util.Md5Util;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;

    @Override
    public List<User> list() {
        return userMapper.findAll();
    }

    @Override
    public List<User> listEmployees() {
        return userMapper.findByRoleCode("EMPLOYEE");
    }

    @Override
    public User getById(Long id) {
        return userMapper.findById(id);
    }

    @Override
    @Transactional
    public void save(User user) {
        if (user.getStatus() == null) {
            user.setStatus(1);
        }
        if (user.getRoleCode() == null || user.getRoleCode().trim().isEmpty()) {
            user.setRoleCode("EMPLOYEE");
        }
        user.setPassword(Md5Util.md5(user.getPassword()));
        userMapper.insert(user);
        userMapper.insertUserRole(user.getId(), user.getRoleCode());
    }

    @Override
    @Transactional
    public void update(User user) {
        userMapper.update(user);
        if (user.getRoleCode() != null && !user.getRoleCode().trim().isEmpty()) {
            userMapper.deleteUserRole(user.getId());
            userMapper.insertUserRole(user.getId(), user.getRoleCode());
        }
    }

    @Override
    public void updatePassword(Long id, String password) {
        userMapper.updatePassword(id, Md5Util.md5(password));
    }

    @Override
    @Transactional
    public void delete(Long id) {
        userMapper.deleteUserRole(id);
        userMapper.deleteById(id);
    }
}
