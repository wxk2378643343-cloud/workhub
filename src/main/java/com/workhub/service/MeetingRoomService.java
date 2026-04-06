package com.workhub.service;

import com.workhub.entity.MeetingRoom;

import java.util.List;

public interface MeetingRoomService {
    List<MeetingRoom> list();

    void save(MeetingRoom meetingRoom);

    void delete(Long id);
}
