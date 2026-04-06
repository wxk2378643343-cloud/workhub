package com.workhub.service.impl;

import com.workhub.entity.Notice;
import com.workhub.mapper.NoticeMapper;
import com.workhub.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Resource
    private NoticeMapper noticeMapper;

    @Override
    public List<Notice> list() {
        return noticeMapper.findAll();
    }

    @Override
    public void save(Notice notice) {
        if (notice.getPublishTime() == null) {
            notice.setPublishTime(new Date());
        }
        if (notice.getId() == null) {
            noticeMapper.insert(notice);
        } else {
            noticeMapper.update(notice);
        }
    }

    @Override
    public void delete(Long id) {
        noticeMapper.deleteById(id);
    }
}
