package com.workhub.service.impl;

import com.workhub.entity.GoodsItem;
import com.workhub.mapper.GoodsItemMapper;
import com.workhub.service.GoodsItemService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class GoodsItemServiceImpl implements GoodsItemService {
    @Resource
    private GoodsItemMapper goodsItemMapper;

    @Override
    public List<GoodsItem> list() {
        return goodsItemMapper.findAll();
    }

    @Override
    public void save(GoodsItem goodsItem) {
        if (goodsItem.getId() == null) {
            goodsItemMapper.insert(goodsItem);
        } else {
            goodsItemMapper.update(goodsItem);
        }
    }

    @Override
    public void delete(Long id) {
        goodsItemMapper.deleteById(id);
    }
}
