package com.kanade.temp.mapper;

import com.kanade.temp.entity.OperLog;
import org.apache.ibatis.annotations.Insert;

public interface OperLogMapper {
    // 考点10：日志记录（注解插入）
    @Insert("INSERT INTO oper_log (oper_time, oper_type, oper_content) " +
            "VALUES (#{operTime}, #{operType}, #{operContent})")
    int insert(OperLog log);
}