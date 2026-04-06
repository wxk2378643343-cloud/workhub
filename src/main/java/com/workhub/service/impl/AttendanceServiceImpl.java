package com.workhub.service.impl;

import com.workhub.entity.Attendance;
import com.workhub.mapper.AttendanceMapper;
import com.workhub.service.AttendanceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class AttendanceServiceImpl implements AttendanceService {
    @Resource
    private AttendanceMapper attendanceMapper;

    @Override
    public List<Attendance> list() {
        return attendanceMapper.findAll();
    }

    @Override
    public List<Attendance> listByUserId(Long userId) {
        return attendanceMapper.findByUserId(userId);
    }

    @Override
    public Attendance getTodayRecord(Long userId) {
        return attendanceMapper.findTodayByUserId(userId);
    }

    @Override
    public void save(Attendance attendance) {
        if (attendance.getId() == null) {
            attendanceMapper.insert(attendance);
        } else {
            attendanceMapper.update(attendance);
        }
    }

    @Override
    public void checkIn(Long userId) {
        Attendance today = attendanceMapper.findTodayByUserId(userId);
        if (today != null && today.getCheckInTime() != null) {
            throw new IllegalStateException("今天已经完成上班打卡");
        }
        Date now = new Date();
        String inStatus = now.before(buildTime(now, 9, 0)) ? "正常" : "迟到";
        if (today == null) {
            Attendance attendance = new Attendance();
            attendance.setUserId(userId);
            attendance.setAttendanceDate(now);
            attendance.setCheckInTime(now);
            attendance.setCheckInStatus(inStatus);
            attendance.setDayStatus("正常".equals(inStatus) ? "正常" : "迟到");
            attendanceMapper.insert(attendance);
            return;
        }
        today.setCheckInTime(now);
        today.setCheckInStatus(inStatus);
        today.setDayStatus("正常".equals(inStatus) ? defaultDayStatus(today) : "迟到");
        attendanceMapper.update(today);
    }

    @Override
    public void checkOut(Long userId) {
        Attendance today = attendanceMapper.findTodayByUserId(userId);
        if (today == null || today.getCheckInTime() == null) {
            throw new IllegalStateException("请先完成上班打卡");
        }
        if (today.getCheckOutTime() != null) {
            throw new IllegalStateException("今天已经完成下班打卡");
        }
        Date now = new Date();
        String outStatus = now.before(buildTime(now, 18, 0)) ? "早退" : "正常";
        today.setCheckOutTime(now);
        today.setCheckOutStatus(outStatus);
        today.setDayStatus(resolveDayStatus(today.getCheckInStatus(), outStatus));
        attendanceMapper.updateCheckOut(today);
    }

    @Override
    public void delete(Long id) {
        attendanceMapper.deleteById(id);
    }

    private Date buildTime(Date base, int hour, int minute) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(base);
        calendar.set(Calendar.HOUR_OF_DAY, hour);
        calendar.set(Calendar.MINUTE, minute);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    private String resolveDayStatus(String inStatus, String outStatus) {
        if ("迟到".equals(inStatus) && "早退".equals(outStatus)) {
            return "迟到/早退";
        }
        if ("迟到".equals(inStatus)) {
            return "迟到";
        }
        if ("早退".equals(outStatus)) {
            return "早退";
        }
        return "正常";
    }

    private String defaultDayStatus(Attendance attendance) {
        return attendance.getDayStatus() == null ? "正常" : attendance.getDayStatus();
    }
}
