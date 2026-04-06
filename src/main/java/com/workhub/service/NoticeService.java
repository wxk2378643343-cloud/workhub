package com.workhub.service;

import com.workhub.entity.Notice;

import java.util.List;

public interface NoticeService {
    List<Notice> list();

    void save(Notice notice);

    void delete(Long id);
}
