package com.workhub.service;

import com.workhub.entity.Attendance;

import java.util.List;

public interface AttendanceService {
    List<Attendance> list();

    List<Attendance> listByUserId(Long userId);

    Attendance getTodayRecord(Long userId);

    void save(Attendance attendance);

    void checkIn(Long userId);

    void checkOut(Long userId);

    void delete(Long id);
}
