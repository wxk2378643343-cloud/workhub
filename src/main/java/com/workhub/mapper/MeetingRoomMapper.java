package com.workhub.mapper;

import com.workhub.entity.MeetingRoom;

import java.util.List;

public interface MeetingRoomMapper {
    List<MeetingRoom> findAll();

    int insert(MeetingRoom meetingRoom);

    int update(MeetingRoom meetingRoom);

    int deleteById(Long id);
}
