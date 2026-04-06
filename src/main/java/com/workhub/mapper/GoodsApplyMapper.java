package com.workhub.mapper;

import com.workhub.entity.GoodsApply;

import java.util.List;

public interface GoodsApplyMapper {
    List<GoodsApply> findAll();

    List<GoodsApply> findByUserId(Long userId);

    int insert(GoodsApply goodsApply);

    int updateStatus(GoodsApply goodsApply);

    int deleteById(Long id);
}
