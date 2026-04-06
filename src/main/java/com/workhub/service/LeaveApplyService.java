package com.workhub.service;

import com.workhub.entity.LeaveApply;

import java.util.List;

public interface LeaveApplyService {
    List<LeaveApply> list();

    List<LeaveApply> listByUserId(Long userId);

    void save(LeaveApply leaveApply);

    void approve(LeaveApply leaveApply);

    void delete(Long id);
}
