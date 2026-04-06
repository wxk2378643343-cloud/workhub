package com.workhub.service.impl;

import com.workhub.entity.MeetingRoom;
import com.workhub.mapper.MeetingRoomMapper;
import com.workhub.service.MeetingRoomService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
    @Resource
    private MeetingRoomMapper meetingRoomMapper;

    @Override
    public List<MeetingRoom> list() {
        return meetingRoomMapper.findAll();
    }

    @Override
    public void save(MeetingRoom meetingRoom) {
        if (meetingRoom.getId() == null) {
            meetingRoomMapper.insert(meetingRoom);
        } else {
            meetingRoomMapper.update(meetingRoom);
        }
    }

    @Override
    public void delete(Long id) {
        meetingRoomMapper.deleteById(id);
    }
}
