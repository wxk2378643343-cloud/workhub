package com.workhub.mapper;

import com.workhub.entity.LeaveApply;

import java.util.List;

public interface LeaveApplyMapper {
    List<LeaveApply> findAll();

    List<LeaveApply> findByUserId(Long userId);

    int insert(LeaveApply leaveApply);

    int updateStatus(LeaveApply leaveApply);

    int deleteById(Long id);
}
