package com.workhub.service;

import com.workhub.entity.User;

public interface AuthzService {
    boolean isAdmin(User user);

    boolean isLeader(User user);

    boolean canApproveUser(User operator, Long applicantUserId);
}
