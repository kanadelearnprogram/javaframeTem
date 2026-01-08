-- 1. 商品分类表（goods_type）—— 多表查询的主表（考点9）
CREATE TABLE `goods_type` (
                              `type_id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID（主键）',
                              `type_name` VARCHAR(50) NOT NULL COMMENT '分类名称'
) COMMENT '商品分类表';

-- 测试数据
INSERT INTO `goods_type` (`type_name`) VALUES ('电子产品'), ('生活用品'), ('食品');

-- 2. 商品表（goods）—— 核心业务表（覆盖考点1/2/6/8/9）
CREATE TABLE `goods` (
                         `goods_id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID（主键）',
                         `goods_name` VARCHAR(100) NOT NULL COMMENT '商品名称（模糊查询字段）',
                         `price` DECIMAL(10,2) NOT NULL COMMENT '商品价格',
                         `create_time` DATE NOT NULL COMMENT '创建时间（日期类型，考点1）',
                         `img_path` VARCHAR(255) COMMENT '商品图片路径（考点6）',
                         `type_id` INT NOT NULL COMMENT '分类ID（外键，关联goods_type，考点9）',
                         FOREIGN KEY (`type_id`) REFERENCES `goods_type`(`type_id`)
) COMMENT '商品表';

-- 测试数据（包含日期、图片路径，贴合考点1/6）
INSERT INTO `goods` (`goods_name`, `price`, `create_time`, `img_path`, `type_id`)
VALUES ('小米手机', 1999.00, '2025-12-01', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 1),
       ('纯棉毛巾', 19.90, '2025-12-02', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 2),
       ('面包', 5.90, '2025-12-03', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 3),
       ('苹果手机', 5999.00, '2026-01-05', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 1),
       ('笔记本电脑', 4999.00, '2026-01-06', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 1),
       ('牙刷', 12.50, '2026-01-07', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 2),
       ('牙膏', 8.90, '2026-01-08', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 2),
       ('牛奶', 15.80, '2026-01-09', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 3),
       ('苹果', 6.50, '2026-01-10', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 3),
       ('香蕉', 4.80, '2026-01-11', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 3),
       ('游戏机', 2999.00, '2026-01-12', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 1),
       ('台灯', 89.00, '2026-01-13', 'https://ts1.tc.mm.bing.net/th/id/OIP-C.T8ndKjUcJPEYHBGNCG8S1gHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', 2);

-- 3. 操作日志表（oper_log）—— 日志记录（考点10）
CREATE TABLE `oper_log` (
                            `log_id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '日志ID（主键）',
                            `oper_time` DATETIME NOT NULL COMMENT '操作时间',
                            `oper_type` VARCHAR(20) NOT NULL COMMENT '操作类型（新增/删除/修改）',
                            `oper_content` VARCHAR(500) NOT NULL COMMENT '操作内容（记录参数/数据）'
) COMMENT '操作日志表';