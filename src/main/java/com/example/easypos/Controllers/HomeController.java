package com.example.easypos.Controllers;

import com.example.easypos.Services.HomeService;
import com.example.easypos.Vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@Controller
public class HomeController {
    private HomeService homeService;
    private Rq rq;
    private LocalTime now;
    private Date dateNow;
    private DateTimeFormatter formatter;
    private SimpleDateFormat dateFormatter;

    @Autowired
    public HomeController(HomeService homeService, Rq rq) {
        this.homeService = homeService;
        this.rq = rq;
        this.now = LocalTime.now();
        this.dateNow = new Date();
        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    @RequestMapping("/")
    public String Tables(Model model, @RequestParam(defaultValue = "1") int floor) {

        if (floor <= 0 || floor > 3) {
            return rq.jsReturnOnView("잘못 된 번호 입력");
        }

        rq.floor(floor);
        List<CartItems> cartItems = homeService.getCartItems(floor);
        List<Table> tables = homeService.getTableLIst(floor);
        List<CartItems> priceSumList = homeService.getPriceSumList(floor);
        List<TableGroup> tableGroups = homeService.getTableGroups();
        int orderTablesCnt = 0;
        for (int i = 1; i <= 3; i++) {
            List<CartItems> orderTablesList = homeService.getOrderTablesList(i);
            orderTablesCnt += orderTablesList.size();
        }


        model.addAttribute("orderTablesCnt", orderTablesCnt);
        model.addAttribute("tableGroups", tableGroups);
        model.addAttribute("priceSumList", priceSumList);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("tables", tables);
        model.addAttribute("floor", floor);

        return "/usr/home/home";
    }

    // ==============================================================//

    @RequestMapping("/usr/tables/update")
    @ResponseBody
    public String Update(int elPosX, int elPosY, int number, int floor) {
        homeService.updateTablePos(elPosX, elPosY, number, floor);
        return "";
    }

// ==============================================================//

    @RequestMapping("/usr/main/salesSummary")
    public String salesSummary(@RequestParam(defaultValue = "전체") String floor, Model model) {
        String todayDate = dateFormatter.format(dateNow);
        List<Integer> payedTotalAmount = homeService.getPayedTotalAmount(floor);
        List<Integer> payedTotalCnt = homeService.getPayedTotalCnt(floor);
        List<Integer> payedTotalDiscountAmount = homeService.getPayedTotalDiscountAmount(floor);
        int outstandingAmount = homeService.getOutstandingAmount();

        int VAT_Amount = (payedTotalAmount.get(1) / 100) * 11;
        model.addAttribute("floor", floor);
        model.addAttribute("todayDate", todayDate);
        model.addAttribute("payedTotalDiscountAmount", String.valueOf(payedTotalDiscountAmount.get(0) + payedTotalDiscountAmount.get(1)));
        model.addAttribute("payedTotalAmount", String.valueOf(payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCashSumAmount", String.valueOf(payedTotalAmount.get(0)));
        model.addAttribute("payedCartSumAmount", String.valueOf(payedTotalAmount.get(1)));
        model.addAttribute("VAT_Amount", String.valueOf(VAT_Amount));
        model.addAttribute("outstandingAmount", String.valueOf(outstandingAmount));
        model.addAttribute("expectedSales", String.valueOf(outstandingAmount + payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCashCnt", payedTotalCnt.get(0));
        model.addAttribute("payedCartCnt", payedTotalCnt.get(1));
        return "/usr/home/salesSummary";
    }

    // ==============================================================//

    @RequestMapping("/usr/tables/movement")
    @ResponseBody
    public ResultDate movement(int currTableNum, int afterTableNum, int floor, String msg) {
        List<CartItems> currCartItems = homeService.getCurrCartItem(currTableNum, floor);
        List<CartItems> afterCartItems = homeService.getCurrCartItem(afterTableNum, floor);

        if (afterCartItems.size() != 0) {
            homeService.removeCart(floor, afterTableNum);
        }

        Cart cart = homeService.getCart(floor, currTableNum);
        if (currCartItems.size() != 0) {
            for (CartItems currentCartItem : currCartItems) {
                CartItems item = homeService.getCartItem(currentCartItem.getProduct_id(), afterTableNum, floor);
                if (item != null && currTableNum != afterTableNum) {
                    if (currentCartItem.getProductSailPrice() != 0) {
                        homeService.toMoveCartItems(currentCartItem.getProduct_id(), currentCartItem.getProductName(), afterTableNum,
                                currentCartItem.getQuantity(), currentCartItem.getProductPrice(), currentCartItem.getProductSumPrice(),
                                currentCartItem.getProductSailPrice(), floor, cart.getId());
                    } else if (currentCartItem.getProductSailPrice() == 0) {
                        homeService.toMoveUpdateCartItems(afterTableNum, floor, currentCartItem.getProduct_id(), currentCartItem.getQuantity(),
                                currentCartItem.getProductSailPrice(), currentCartItem.getProductSumPrice(), currentCartItem.getCart_id());
                    }
                    homeService.updateCart(floor, afterTableNum, currTableNum);

                } else if (item == null) {
                    homeService.toMoveCartItems(currentCartItem.getProduct_id(), currentCartItem.getProductName(), afterTableNum,
                            currentCartItem.getQuantity(), currentCartItem.getProductPrice(), currentCartItem.getProductSumPrice(),
                            currentCartItem.getProductSailPrice(), floor, cart.getId());
                    homeService.updateCart(floor, afterTableNum, currTableNum);
                }
            }

            if (msg.equals("true")) {
                System.out.println(String.format("%d번 테이블이 %d번 테이블로 이동했습니다.", currTableNum, afterTableNum));
            }

            if (currTableNum != afterTableNum) {
                homeService.delBeforeCartItem(currTableNum, floor);
            }

            return ResultDate.from("S-1", "데이터 전송 성공");
        }

        return ResultDate.from("S-1", "데이터 전송 실패");
    }

// ==============================================================//

    @RequestMapping("/usr/tableGroup/addTableGroup")
    @ResponseBody
    public ResultDate addTableGroup(String color) {
        homeService.addTableGroup(color);
        List<TableGroup> tableGroups = homeService.getTableGroups();
        return ResultDate.from("s-1", "data 보내기 성공", "tableGroups", tableGroups);
    }

    // ==============================================================//

    @RequestMapping("/usr/tableGroup/removeTableGroup")
    @ResponseBody
    public ResultDate removeTableGroup(int groupId) {
        homeService.removeTableGroup(groupId);
        List<TableGroup> tableGroups = homeService.getTableGroups();
        if (tableGroups.size() == 0) {
            homeService.truncateForTableGroups();
        }
        return ResultDate.from("s-1", "data 보내기 성공", "tableGroups", tableGroups);
    }

    // ==============================================================//

    @RequestMapping("/usr/tableGroup/update")
    @ResponseBody
    public ResultDate update(int groupId) {
        homeService.updateTableGroup(groupId);

        TableGroup tableGroup = homeService.getTableGroupById(groupId);
        return ResultDate.from("s-1", "data 보내기 성공", "tableGroup", tableGroup);
    }

    // ==============================================================//

    @RequestMapping("/usr/tables/getProductSummary")
    @ResponseBody
    public ResultDate getProductSummary(int floor, int tabId) {
        List<CartItems> cartItems = homeService.getCartItemsList(tabId, floor);
        if (cartItems.size() != 0) {
            return ResultDate.from("S-1", "성공", "cartItems", cartItems);
        } else {
            return ResultDate.from("F-1", "실패");
        }
    }
}
