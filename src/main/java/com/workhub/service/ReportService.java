package com.workhub.service;

import com.workhub.entity.Report;

import java.util.List;

public interface ReportService {
    List<Report> list();

    List<Report> listByUserId(Long userId);

    void save(Report report);

    void approve(Report report);

    void delete(Long id);
}
