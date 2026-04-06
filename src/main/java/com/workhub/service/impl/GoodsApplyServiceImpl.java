package com.workhub.service.impl;

import com.workhub.entity.GoodsApply;
import com.workhub.mapper.GoodsApplyMapper;
import com.workhub.service.GoodsApplyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class GoodsApplyServiceImpl implements GoodsApplyService {
    @Resource
    private GoodsApplyMapper goodsApplyMapper;

    @Override
    public List<GoodsApply> list() {
        return goodsApplyMapper.findAll();
    }

    @Override
    public List<GoodsApply> listByUserId(Long userId) {
        return goodsApplyMapper.findByUserId(userId);
    }

    @Override
    public void save(GoodsApply goodsApply) {
        goodsApplyMapper.insert(goodsApply);
    }

    @Override
    public void approve(GoodsApply goodsApply) {
        goodsApplyMapper.updateStatus(goodsApply);
    }

    @Override
    public void delete(Long id) {
        goodsApplyMapper.deleteById(id);
    }
}
