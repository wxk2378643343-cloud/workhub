package com.workhub.mapper;

import com.workhub.entity.GoodsItem;

import java.util.List;

public interface GoodsItemMapper {
    List<GoodsItem> findAll();

    int insert(GoodsItem goodsItem);

    int update(GoodsItem goodsItem);

    int deleteById(Long id);
}
