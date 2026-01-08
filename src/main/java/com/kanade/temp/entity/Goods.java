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
    
    // todo 考点1：日期类型处理 - 支持多种格式MM-dd-yy 自己改
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createTime;
    
    private String imgPath;
    private Integer typeId;
    private String typeName;
}