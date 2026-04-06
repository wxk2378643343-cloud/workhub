package com.workhub.mapper;

import com.workhub.entity.Attendance;

import java.util.List;

public interface AttendanceMapper {
    List<Attendance> findAll();

    List<Attendance> findByUserId(Long userId);

    Attendance findTodayByUserId(Long userId);

    int insert(Attendance attendance);

    int update(Attendance attendance);

    int updateCheckOut(Attendance attendance);

    int deleteById(Long id);
}
