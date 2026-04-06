package com.workhub.service.impl;

import com.workhub.entity.Department;
import com.workhub.entity.User;
import com.workhub.service.AuthzService;
import com.workhub.service.DepartmentService;
import com.workhub.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AuthzServiceImpl implements AuthzService {
    @Resource
    private DepartmentService departmentService;
    @Resource
    private UserService userService;

    @Override
    public boolean isAdmin(User user) {
        return user != null && "ADMIN".equals(user.getRoleCode());
    }

    @Override
    public boolean isLeader(User user) {
        return user != null && departmentService.isLeader(user.getId());
    }

    @Override
    public boolean canApproveUser(User operator, Long applicantUserId) {
        if (operator == null || applicantUserId == null) {
            return false;
        }
        if (isAdmin(operator)) {
            return true;
        }
        if (!isLeader(operator)) {
            return false;
        }
        User applicant = userService.getById(applicantUserId);
        if (applicant == null || applicant.getDeptId() == null) {
            return false;
        }
        Department department = departmentService.getById(applicant.getDeptId());
        return department != null && operator.getId().equals(department.getLeaderId());
    }
}
