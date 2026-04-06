package com.workhub.service.impl;

import com.workhub.entity.MeetingApply;
import com.workhub.mapper.MeetingApplyMapper;
import com.workhub.service.MeetingApplyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MeetingApplyServiceImpl implements MeetingApplyService {
    @Resource
    private MeetingApplyMapper meetingApplyMapper;

    @Override
    public List<MeetingApply> list() {
        return meetingApplyMapper.findAll();
    }

    @Override
    public List<MeetingApply> listByUserId(Long userId) {
        return meetingApplyMapper.findByUserId(userId);
    }

    @Override
    public void save(MeetingApply meetingApply) {
        if (meetingApplyMapper.countConflict(meetingApply) > 0) {
            throw new IllegalArgumentException("当前会议室在该时间段已被预约");
        }
        meetingApplyMapper.insert(meetingApply);
    }

    @Override
    public void approve(MeetingApply meetingApply) {
        meetingApplyMapper.updateStatus(meetingApply);
    }

    @Override
    public void delete(Long id) {
        meetingApplyMapper.deleteById(id);
    }
}
