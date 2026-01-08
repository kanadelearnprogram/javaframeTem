<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品详情</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            background-color: #f5f5f5; 
        }
        .container {
            max-width: 800px;
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
        .detail-item { 
            margin-bottom: 15px; 
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .detail-item label { 
            display: inline-block; 
            width: 100px; 
            font-weight: bold; 
            color: #333;
        }
        .btn { 
            padding: 10px 15px; 
            background-color: #007BFF; 
            color: white; 
            text-decoration: none; 
            border-radius: 4px; 
            margin-right: 10px;
        }
        .btn:hover { 
            background-color: #0056b3; 
        }
        .btn-danger { 
            background-color: #dc3545; 
        }
        .btn-danger:hover { 
            background-color: #c82333; 
        }
        .image-container {
            text-align: center;
            margin: 20px 0;
        }
        .image-container img {
            max-width: 300px;
            max-height: 300px;
            object-fit: contain;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .actions {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>商品详情</h2>
        </div>
        
        <div class="detail-item">
            <label>商品ID：</label>
            ${goods.goodsId}
        </div>
        
        <div class="detail-item">
            <label>商品名称：</label>
            ${goods.goodsName}
        </div>
        
        <div class="detail-item">
            <label>价格：</label>
            ${goods.price}
        </div>
        
        <div class="detail-item">
            <label>创建时间：</label>
            ${goods.createTime}
        </div>
        
        <div class="image-container">
            <label>图片：</label>
            <br>
            <c:if test="${not empty goods.imgPath}">
                <img src="${goods.imgPath}" alt="商品图片">
            </c:if>
            <c:if test="${empty goods.imgPath}">
                <p>无图片</p>
            </c:if>
        </div>
        
        <div class="detail-item">
            <label>分类：</label>
            ${goods.typeName}
        </div>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/goods/list" class="btn">返回列表</a>
            <a href="${pageContext.request.contextPath}/goods/toAdd" class="btn">添加新商品</a>
        </div>
    </div>
</body>
</html>