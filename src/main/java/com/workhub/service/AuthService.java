package com.workhub.service;

import com.workhub.entity.User;

public interface AuthService {
    User login(String username, String password);
}
