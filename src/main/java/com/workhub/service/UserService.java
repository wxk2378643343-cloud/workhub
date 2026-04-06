package com.workhub.service;

import com.workhub.entity.User;

import java.util.List;

public interface UserService {
    List<User> list();

    List<User> listEmployees();

    User getById(Long id);

    void save(User user);

    void update(User user);

    void updatePassword(Long id, String password);

    void delete(Long id);
}
