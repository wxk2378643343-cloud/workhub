package com.workhub.mapper;

import com.workhub.entity.Notice;

import java.util.List;

public interface NoticeMapper {
    List<Notice> findAll();

    int insert(Notice notice);

    int update(Notice notice);

    int deleteById(Long id);
}
