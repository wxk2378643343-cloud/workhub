package com.workhub.service;

import com.workhub.entity.GoodsApply;

import java.util.List;

public interface GoodsApplyService {
    List<GoodsApply> list();

    List<GoodsApply> listByUserId(Long userId);

    void save(GoodsApply goodsApply);

    void approve(GoodsApply goodsApply);

    void delete(Long id);
}
