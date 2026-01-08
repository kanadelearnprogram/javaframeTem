package com.kanade.temp.service;

import com.kanade.temp.entity.Goods;
import com.kanade.temp.entity.GoodsType;
import com.kanade.temp.entity.OperLog;
import com.kanade.temp.mapper.GoodsMapper;
import com.kanade.temp.mapper.GoodsTypeMapper;
import com.kanade.temp.mapper.OperLogMapper;
import com.kanade.temp.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;


public class GoodsService {

    public List<Goods> getGoodsList(String goodsName) {
        Map<String, Object> params = new HashMap<>();
        params.put("goodsName", goodsName);
        return getGoodsList(params, null, null);
    }
    
    public List<Goods> getGoodsList(String goodsName, Integer pageNum, Integer pageSize) {
        int offset = (pageNum - 1) * pageSize;
        int limit = pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("goodsName", goodsName);
        params.put("offset", offset);
        params.put("limit", limit);
        return getGoodsList(params, offset, limit);
    }
    
    private List<Goods> getGoodsList(Map<String, Object> params, Integer offset, Integer limit) {
        SqlSession sqlSession = MyBatisUtil.getSession();
        try {
            GoodsMapper mapper = sqlSession.getMapper(GoodsMapper.class);
            return mapper.selectByLikeName(params);
        } finally {
            sqlSession.close();
        }
    }

    public List<GoodsType> getAllTypes() {
        SqlSession sqlSession = MyBatisUtil.getSession();
        try {
            GoodsTypeMapper mapper = sqlSession.getMapper(GoodsTypeMapper.class);
            return mapper.selectAll();
        } finally {
            sqlSession.close();
        }
    }

    public int addGoods(Goods goods) {
        SqlSession sqlSession = MyBatisUtil.getSession();
        try {
            GoodsMapper mapper = sqlSession.getMapper(GoodsMapper.class);
            int result = mapper.insert(goods);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            sqlSession.rollback();
            throw new RuntimeException("添加商品失败：" + e.getMessage());
        } finally {
            sqlSession.close();
        }
    }

    public Goods getGoodsById(Integer goodsId) {
        SqlSession sqlSession = MyBatisUtil.getSession();
        try {
            GoodsMapper mapper = sqlSession.getMapper(GoodsMapper.class);
            return mapper.selectById(goodsId);
        } finally {
            sqlSession.close();
        }
    }

    public int deleteGoods(Integer goodsId) {
        SqlSession sqlSession = MyBatisUtil.getSession();
        try {
            GoodsMapper mapper = sqlSession.getMapper(GoodsMapper.class);
            int result = mapper.deleteById(goodsId);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            sqlSession.rollback();
            throw new RuntimeException("删除商品失败：" + e.getMessage());
        } finally {
            sqlSession.close();
        }
    }

    public void addLog(OperLog log) {
        SqlSession sqlSession = MyBatisUtil.getSession();
        try {
            OperLogMapper mapper = sqlSession.getMapper(OperLogMapper.class);
            mapper.insert(log);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            throw new RuntimeException("添加日志失败：" + e.getMessage());
        } finally {
            sqlSession.close();
        }
    }
    
    public int countGoods(String goodsName) {
        SqlSession sqlSession = MyBatisUtil.getSession();
        try {
            GoodsMapper mapper = sqlSession.getMapper(GoodsMapper.class);
            if (goodsName == null || goodsName.isEmpty()) {
                goodsName = "%"; // 查询所有记录
            }
            return mapper.countByLikeName(goodsName);
        } finally {
            sqlSession.close();
        }
    }
}