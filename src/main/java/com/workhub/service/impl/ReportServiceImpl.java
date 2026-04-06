package com.workhub.service.impl;

import com.workhub.entity.Report;
import com.workhub.mapper.ReportMapper;
import com.workhub.service.ReportService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ReportServiceImpl implements ReportService {
    @Resource
    private ReportMapper reportMapper;

    @Override
    public List<Report> list() {
        return reportMapper.findAll();
    }

    @Override
    public List<Report> listByUserId(Long userId) {
        return reportMapper.findByUserId(userId);
    }

    @Override
    public void save(Report report) {
        reportMapper.insert(report);
    }

    @Override
    public void approve(Report report) {
        reportMapper.updateStatus(report);
    }

    @Override
    public void delete(Long id) {
        reportMapper.deleteById(id);
    }
}
