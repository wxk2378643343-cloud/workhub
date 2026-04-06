package com.workhub.service;

import com.workhub.entity.GoodsItem;

import java.util.List;

public interface GoodsItemService {
    List<GoodsItem> list();

    void save(GoodsItem goodsItem);

    void delete(Long id);
}
