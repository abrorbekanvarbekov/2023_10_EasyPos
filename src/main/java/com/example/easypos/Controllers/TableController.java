package com.example.easypos.Controllers;

import com.example.easypos.Services.TableService;
import com.example.easypos.Util.Util;
import com.example.easypos.Vo.ProductType;
import com.example.easypos.Vo.ResultDate;
import com.example.easypos.Vo.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class TableController {
    private TableService tableService;

    @Autowired
    public TableController(TableService tableService) {
        this.tableService = tableService;
    }


    @RequestMapping("/")
    public String Tables(Model model,@RequestParam(defaultValue = "1") int floor){

        if (floor <= 0 && floor > 3) {
            return Util.jsHistoryBack("잘못 된 번호 입력");
        }
        List<Table> tables = tableService.getTableLIst(floor);
        model.addAttribute("tables", tables);
        return "/usr/home/home";
    }

//    @RequestMapping("/usr/home/floor")
//    public String TablesFloor(int floor, Model model){
//        if (floor <= 0 && floor > 3) {
//            return Util.jsHistoryBack("잘못 된 번호 입력");
//        }
//        List<Table> tables = tableService.getTableLIst(floor);
//        model.addAttribute("tables", tables);
//        return "/usr/home/home";
//    }

    @RequestMapping("/usr/tables/update")
    @ResponseBody
    public String Update(int elPosX, int elPosY, int id){
        tableService.updateTablePos(elPosX, elPosY, id);
        return "";
    }

    @RequestMapping("/usr/tables/detail")
    public String Detail(int tabId, Model model){
        List<ProductType> productTypes = tableService.getProductTypes();
        model.addAttribute("productTypes",productTypes);
        return "/usr/table/detail";
    }

    @RequestMapping("/usr/tables/getProduct")
    @ResponseBody
    public ResultDate getProduct(int id){
        ProductType product = tableService.getProductTypeById(id);
        return ResultDate.from("s-1", "data 보내기 성공", "product", product);
    }
}
