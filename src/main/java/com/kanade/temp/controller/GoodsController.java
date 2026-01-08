package com.kanade.temp.controller;

import com.kanade.temp.entity.Goods;
import com.kanade.temp.entity.GoodsType;
import com.kanade.temp.entity.OperLog;
import com.kanade.temp.service.GoodsService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {

    private GoodsService goodsService = new GoodsService();

    // 考点2：模糊查询 + 考点3：分页查询实现
    @RequestMapping("/list")
    public String list(
            @RequestParam(required = false) String goodsName,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            Model model) {
        List<Goods> goodsList = goodsService.getGoodsList(goodsName, pageNum, pageSize);
        int totalCount = goodsService.countGoods(goodsName);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("goodsName", goodsName);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        return "goods/list";
    }

    // 考点4：路径映射 + 考点9：多表查询（动态下拉框）
    @RequestMapping("/toAdd")
    public String toAdd(Model model) {
        List<GoodsType> typeList = goodsService.getAllTypes();
        model.addAttribute("typeList", typeList);
        return "goods/add";
    }

    // 考点1：日期处理 + 考点8：INSERT返回主键
    @RequestMapping("/add")
    public String addGoods(Goods goods, HttpServletRequest request) {
        // 处理可能的日期格式：支持MM-dd-yy格式
        String createTimeStr = request.getParameter("createTime");
        if (createTimeStr != null && !createTimeStr.trim().isEmpty()) {
            try {
                // 尝试解析MM-dd-yy格式
                if (createTimeStr.matches("^\\d{2}-\\d{2}-\\d{2}$")) {
                    SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yy");
                    Date parsedDate = sdf.parse(createTimeStr);
                    goods.setCreateTime(parsedDate);
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        goodsService.addGoods(goods);
        return "redirect:/goods/list";
    }

    // 考点5：路径传参 + 考点6：图片预览
    @RequestMapping("/detail/{goodsId}")
    public String detail(@PathVariable Integer goodsId, Model model) {
        Goods goods = goodsService.getGoodsById(goodsId);
        model.addAttribute("goods", goods);
        return "goods/detail";
    }

    // 考点7：删除确认 + 考点10：日志记录
    @RequestMapping("/delete/{goodsId}")
    public String delete(@PathVariable Integer goodsId) {
        Goods goods = goodsService.getGoodsById(goodsId);
        goodsService.deleteGoods(goodsId);
        
        OperLog log = new OperLog();
        log.setOperTime(new Date());
        log.setOperType("删除");
        log.setOperContent("删除商品：ID=" + goodsId + "，名称=" + goods.getGoodsName());
        goodsService.addLog(log);
        
        return "redirect:/goods/list";
    }
    
    // 直接跳转至具体JSP页面的路径处理
    @RequestMapping("/directToJsp")
    public String directToJsp() {
        // 直接返回JSP页面路径，Spring会根据配置自动解析
        return "goods/list"; // 根据视图解析器配置，会跳转到 /WEB-INF/views/goods/list.jsp
    }
}