package com.kanade.temp.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class Goods {
    private Integer goodsId;
    private String goodsName;
    private BigDecimal price;
    
    // 考点1：日期类型处理
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createTime;
    
    private String imgPath;
    private Integer typeId;
    private String typeName;
}