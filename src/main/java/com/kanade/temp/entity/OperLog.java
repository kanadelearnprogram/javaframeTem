package com.kanade.temp.entity;

import lombok.Data;

import java.util.Date;

@Data
public class OperLog {
    private Integer logId;
    private Date operTime;
    private String operType;
    private String operContent;
}