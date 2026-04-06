package com.workhub.mapper;

import com.workhub.entity.MeetingApply;

import java.util.List;

public interface MeetingApplyMapper {
    List<MeetingApply> findAll();

    List<MeetingApply> findByUserId(Long userId);

    int insert(MeetingApply meetingApply);

    int updateStatus(MeetingApply meetingApply);

    int deleteById(Long id);

    int countConflict(MeetingApply meetingApply);
}
