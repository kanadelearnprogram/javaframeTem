package com.kanade.temp.interceptor;

import com.kanade.temp.entity.OperLog;
import com.kanade.temp.mapper.OperLogMapper;
import com.kanade.temp.util.MyBatisUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Date;

public class LogInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("请求路径: " + request.getRequestURI());
        
        // 记录详细日志
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            String methodName = handlerMethod.getMethod().getName();
            String className = handlerMethod.getBeanType().getSimpleName();
            
            // 创建操作日志记录
            OperLog log = new OperLog();
            log.setOperTime(new Date());
            log.setOperType("访问");
            log.setOperContent("访问方法: " + className + "." + methodName + ", 路径: " + request.getRequestURI());
            //log.setOperIp(request.getRemoteAddr());
            //log.setOperUrl(request.getRequestURL().toString());
            
            // 保存日志到数据库
            SqlSession sqlSession = MyBatisUtil.getSession();
            try {
                OperLogMapper mapper = sqlSession.getMapper(OperLogMapper.class);
                mapper.insert(log);
                sqlSession.commit();
            } catch (Exception e) {
                System.err.println("记录日志失败: " + e.getMessage());
                sqlSession.rollback();
            } finally {
                sqlSession.close();
            }
        }
        
        return true;
    }
}