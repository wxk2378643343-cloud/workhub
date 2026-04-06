package com.workhub.service;

import com.workhub.entity.MeetingApply;

import java.util.List;

public interface MeetingApplyService {
    List<MeetingApply> list();

    List<MeetingApply> listByUserId(Long userId);

    void save(MeetingApply meetingApply);

    void approve(MeetingApply meetingApply);

    void delete(Long id);
}
