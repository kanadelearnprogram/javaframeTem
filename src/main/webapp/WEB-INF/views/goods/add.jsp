<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加商品</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            background-color: #f5f5f5; 
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group { 
            margin-bottom: 15px; 
        }
        .form-group label { 
            display: inline-block; 
            width: 100px; 
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input, 
        .form-group select, 
        .form-group textarea { 
            padding: 8px; 
            width: 100%; 
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn { 
            padding: 10px 15px; 
            background-color: #007BFF; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover { 
            background-color: #0056b3; 
        }
        .btn-cancel { 
            background-color: #6c757d; 
        }
        .btn-cancel:hover { 
            background-color: #545b62; 
        }
        .btn-primary { 
            background-color: #28a745; 
        }
        .btn-primary:hover { 
            background-color: #218838; 
        }
        .form-actions {
            text-align: center;
            margin-top: 20px;
        }
        .nav-links {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>添加商品</h2>
        </div>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/goods/list" class="btn">返回列表</a>
            <!-- 示例：上级目录路径跳转 -->
            <a href="../goods/list" class="btn">上级目录跳转</a>
            <!-- 示例：根目录路径跳转 -->
            <a href="/temp_war_exploded/goods/list" class="btn">根目录跳转</a>
        </div>
        
        <form action="${pageContext.request.contextPath}/goods/add" method="post">
            <div class="form-group">
                <label for="goodsName">商品名称：</label>
                <input type="text" id="goodsName" name="goodsName" required>
            </div>
            
            <div class="form-group">
                <label for="price">价格：</label>
                <input type="number" id="price" name="price" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="createTime">创建时间：</label>
                <input type="text" id="createTime" name="createTime" placeholder="yyyy-MM-dd 或 MM-dd-yy 格式" required>
                <small>支持格式：yyyy-MM-dd 或 MM-dd-yy</small>
            </div>
            
            <div class="form-group">
                <label for="imgPath">图片路径：</label>
                <input type="text" id="imgPath" name="imgPath" placeholder="/images/xxx.jpg">
            </div>
            
            <div class="form-group">
                <label for="typeId">分类：</label>
                <select id="typeId" name="typeId" required>
                    <option value="">请选择分类</option>
                    <c:forEach items="${typeList}" var="type">
                        <option value="${type.typeId}">${type.typeName}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-actions">
                <input type="submit" value="提交" class="btn btn-primary">
                <a href="${pageContext.request.contextPath}/goods/list" class="btn btn-cancel">取消</a>
            </div>
        </form>
    </div>
</body>
</html>