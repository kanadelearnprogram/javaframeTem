package com.kanade.temp.mapper;

import com.kanade.temp.entity.Goods;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface GoodsMapper {
    // 考点8：INSERT返回主键（@Options替代XML的useGeneratedKeys）
    @Insert("INSERT INTO goods (goods_name, price, create_time, img_path, type_id) " +
            "VALUES (#{goodsName}, #{price}, #{createTime}, #{imgPath}, #{typeId})")
    @Options(useGeneratedKeys = true, keyProperty = "goodsId") // 自动返回主键到goodsId属性
    int insert(Goods goods);

    // 基础查询：根据ID查询 + 考点9：多表查询（联表查分类名称）
    @Select("SELECT g.*, t.type_name FROM goods g LEFT JOIN goods_type t ON g.type_id = t.type_id WHERE g.goods_id = #{goodsId}")
    Goods selectById(Integer goodsId);

    // 考点2：模糊查询（XML实现）
    List<Goods> selectByLikeName(Map<String, Object> params);

    // 考点9：多表查询（注解实现联表SQL）
    @Select("SELECT g.*, t.type_name FROM goods g LEFT JOIN goods_type t ON g.type_id = t.type_id WHERE g.goods_id = #{goodsId}")
    Map<String, Object> selectGoodsWithOneType(Integer goodsId);

    // 删除操作
    @Delete("DELETE FROM goods WHERE goods_id = #{goodsId}")
    int deleteById(Integer goodsId);
    
    // 考点3：分页查询 - 获取总数
    @Select("SELECT COUNT(*) FROM goods WHERE goods_name LIKE CONCAT('%', #{goodsName}, '%')")
    int countByLikeName(String goodsName);
}