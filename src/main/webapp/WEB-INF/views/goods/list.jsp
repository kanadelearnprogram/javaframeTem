<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品列表</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            background-color: #f5f5f5; 
        }
        .container {
            max-width: 1200px;
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
        .search-box { 
            margin-bottom: 20px; 
            text-align: center;
        }
        .search-box input[type="text"] { 
            padding: 8px; 
            margin-right: 10px; 
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 200px;
        }
        .search-box input[type="submit"] { 
            padding: 8px 15px; 
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-box input[type="submit"]:hover {
            background-color: #218838;
        }
        table { 
            border-collapse: collapse; 
            width: 100%; 
            margin-top: 10px;
        }
        th, td { 
            border: 1px solid #ddd; 
            padding: 12px; 
            text-align: left; 
        }
        th { 
            background-color: #f2f2f2; 
            font-weight: bold;
        }
        .btn { 
            padding: 6px 12px; 
            text-decoration: none; 
            background-color: #007BFF; 
            color: white; 
            border: 1px solid #007BFF; 
            border-radius: 4px; 
            font-size: 12px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-danger { 
            background-color: #dc3545; 
            border-color: #dc3545; 
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-success { 
            background-color: #28a745; 
            border-color: #28a745; 
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .nav-links {
            margin-bottom: 20px;
            text-align: center;
        }
        .nav-links a {
            margin: 0 10px;
        }
        img {
            max-width: 60px;
            max-height: 60px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>商品列表</h2>
        </div>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="btn">首页</a>
            <a href="${pageContext.request.contextPath}/goods/toAdd" class="btn btn-success">添加商品</a>
        </div>
        
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/goods/list" method="get">
                <input type="text" name="goodsName" placeholder="商品名称" value="${goodsName}">
                <input type="hidden" name="pageNum" value="1">
                <input type="hidden" name="pageSize" value="${pageSize}">
                <input type="submit" value="搜索">
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>商品ID</th>
                    <th>商品名称</th>
                    <th>价格</th>
                    <th>创建时间</th>
                    <th>图片</th>
                    <th>分类</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${goodsList}" var="goods">
                    <tr>
                        <td>${goods.goodsId}</td>
                        <td>${goods.goodsName}</td>
                        <td>${goods.price}</td>
                        <td>${goods.createTime}</td>
                        <td>
                            <c:if test="${not empty goods.imgPath}">
                                <img src="${goods.imgPath}" alt="商品图片">
                            </c:if>
                        </td>
                        <td>${goods.typeName}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/goods/detail/${goods.goodsId}" class="btn">查看</a>
                            <a href="javascript:deleteConfirm(${goods.goodsId})" class="btn btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${empty goodsList}">
            <p style="text-align: center; color: #666;">暂无商品数据</p>
        </c:if>
        
        <!-- 分页导航 -->
        <div class="pagination" style="text-align: center; margin-top: 20px;">
            <c:if test="${not empty goodsList}">
                <c:set var="contextPath" value="${pageContext.request.contextPath}" />
                <c:set var="hasPrev" value="${pageNum > 1}" />
                <c:set var="hasNext" value="${pageNum < totalPages}" />
                
                <c:if test="${hasPrev}">
                    <a href="${contextPath}/goods/list?goodsName=${empty goodsName ? '' : goodsName}&pageNum=${pageNum - 1}&pageSize=${pageSize}" class="btn">上一页</a>
                </c:if>
                
                <span style="margin: 0 10px;">
                    第 ${pageNum} 页，共 ${totalPages} 页，共 ${totalCount} 条记录
                </span>
                
                <c:if test="${hasNext}">
                    <a href="${contextPath}/goods/list?goodsName=${empty goodsName ? '' : goodsName}&pageNum=${pageNum + 1}&pageSize=${pageSize}" class="btn">下一页</a>
                </c:if>
            </c:if>
        </div>
    </div>
    
    <script>
        function deleteConfirm(goodsId) {
            if (confirm("确定要删除这个商品吗？")) {
                window.location.href = "${pageContext.request.contextPath}/goods/delete/" + goodsId;
            }
        }
    </script>
</body>
</html>