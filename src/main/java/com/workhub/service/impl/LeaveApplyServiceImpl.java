package com.workhub.service.impl;

import com.workhub.entity.LeaveApply;
import com.workhub.mapper.LeaveApplyMapper;
import com.workhub.service.LeaveApplyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class LeaveApplyServiceImpl implements LeaveApplyService {
    @Resource
    private LeaveApplyMapper leaveApplyMapper;

    @Override
    public List<LeaveApply> list() {
        return leaveApplyMapper.findAll();
    }

    @Override
    public List<LeaveApply> listByUserId(Long userId) {
        return leaveApplyMapper.findByUserId(userId);
    }

    @Override
    public void save(LeaveApply leaveApply) {
        leaveApplyMapper.insert(leaveApply);
    }

    @Override
    public void approve(LeaveApply leaveApply) {
        leaveApplyMapper.updateStatus(leaveApply);
    }

    @Override
    public void delete(Long id) {
        leaveApplyMapper.deleteById(id);
    }
}
