package com.kanade.temp.mapper;

import com.kanade.temp.entity.GoodsType;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GoodsTypeMapper {
    // 考点9：查询所有分类（用于动态下拉框）
    @Select("SELECT * FROM goods_type")
    List<GoodsType> selectAll();
}