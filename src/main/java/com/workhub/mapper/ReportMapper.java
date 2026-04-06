package com.workhub.mapper;

import com.workhub.entity.Report;

import java.util.List;

public interface ReportMapper {
    List<Report> findAll();

    List<Report> findByUserId(Long userId);

    int insert(Report report);

    int updateStatus(Report report);

    int deleteById(Long id);
}
