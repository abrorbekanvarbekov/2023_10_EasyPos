package com.example.easypos.Controllers;

import com.example.easypos.Services.TableService;
import com.example.easypos.Util.Util;
import com.example.easypos.Vo.*;
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
    private Rq rq;

    @Autowired
    public TableController(TableService tableService, Rq rq) {
        this.tableService = tableService;
        this.rq = rq;
    }


    @RequestMapping("/")
    public String Tables(Model model, @RequestParam(defaultValue = "1") int floor) {
        if (floor <= 0 || floor > 3) {
            return rq.jsReturnOnView("잘못 된 번호 입력");
        }

        List<CartItems> cartItems = tableService.getCartItems(floor);
        List<Table> tables = tableService.getTableLIst(floor);
        List<CartItems> priceSumList = tableService.getPriceSumList(floor);

        model.addAttribute("priceSumList", priceSumList);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("tables", tables);
        return "/usr/home/home";
    }


    @RequestMapping("/usr/tables/update")
    @ResponseBody
    public String Update(int elPosX, int elPosY, int id) {
        tableService.updateTablePos(elPosX, elPosY, id);
        return "";
    }

    @RequestMapping("/usr/tables/detail")
    public String Detail(int tabId, @RequestParam(defaultValue = "1") int floor, Model model) {

        if (floor <= 0 || floor > 3) {
            return rq.jsReturnOnView("갯층 값이 잘 못 입력하였습니다.");
        }
        List<ProductType> productTypes = tableService.getProductTypes();
        List<Product> products = tableService.getProductList();
        List<CartItems> cartItemsList = tableService.getCartItemsList(tabId, floor);

        model.addAttribute("tabId", tabId);
        model.addAttribute("floor", floor);
        model.addAttribute("productTypes", productTypes);
        model.addAttribute("cartItemsList", cartItemsList);
        model.addAttribute("products", products);
        return "/usr/table/detail";
    }

    @RequestMapping("/usr/tables/detail/cancelProduct")
    @ResponseBody
    public String cancelProduct(int productId, int tabId, int floor) {
        tableService.cancelProduct(productId, tabId, floor);
        return "";
    }

    //    ============== 비동기 처리 ===============  //
    @RequestMapping("/usr/tables/getProduct")
    @ResponseBody
    public ResultDate getProduct(int id, int tabId, int floor) {

        if (floor <= 0 || floor > 3) {
            return ResultDate.from("F-1", "갯층 값이 잘 못 입력하였습니다.");
        }

        Product product = null;
        CartItems cartItem = tableService.getCartItem(id, tabId, floor);
        if (cartItem == null) {
            tableService.insertCartItems(id, tabId, floor);
        } else {
            int num = tableService.updateCartItems(id, tabId, floor);
            if (num == 1) {
                product = tableService.getProductById(id);
            }
        }
        List<CartItems> cartItemsList = tableService.getCartItemsList(tabId, floor);
        return ResultDate.from("s-1", "data 보내기 성공", "product", cartItemsList, product);
    }

    @RequestMapping("/usr/tables/getProductTotalSumPriceAndTotalQuantity")
    @ResponseBody
    public ResultDate getProductTotalSumPriceAndTotalQuantity(int tabId, int floor) {
        int totalQuantity = tableService.getTotalQuantity(tabId, floor);
        int totalSumPrice = tableService.getTotalSumPrice(tabId, floor);
        return ResultDate.from("s-1", "data 보내기 성공", "getProductTotalSumPriceAndTotalQuantity", totalQuantity, totalSumPrice);
    }
}
