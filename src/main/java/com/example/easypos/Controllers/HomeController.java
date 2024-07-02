package com.example.easypos.Controllers;

import com.example.easypos.Services.HomeService;
import com.example.easypos.Vo.*;
import org.apache.catalina.util.ToStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class HomeController {
    private HomeService homeService;
    private Rq rq;
    private Date dateNow;
    private SimpleDateFormat dateFormatter;

    @Autowired
    public HomeController(HomeService homeService, Rq rq) {
        this.homeService = homeService;
        this.rq = rq;
        this.dateNow = new Date();
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    @RequestMapping("/")
    public String Tables(Model model, @RequestParam(defaultValue = "1") int floor) {
        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String openingDate = businessFullDate[0];

        if (floor <= 0 || floor > 3) {
            return rq.jsReturnOnView("잘못 된 번호 입력");
        }

        rq.floor(floor);
        List<CartItems> cartItems = homeService.getCartItems(floor, openingDate);
        List<Table> tables = homeService.getTableLIst(floor);
        List<CartItems> priceSumList = homeService.getPriceSumList(floor, openingDate);
        List<TableGroup> tableGroups = homeService.getTableGroups();

        int orderTablesCnt = 0;
        for (int i = 1; i <= 3; i++) {
            List<CartItems> orderTablesList = homeService.getOrderTablesList(i, openingDate);
            orderTablesCnt += orderTablesList.size();
        }

        model.addAttribute("loginedEmployeeName", rq.getLoginedEmployee().getName());
        model.addAttribute("businessDate", rq.getBusinessDate());
        model.addAttribute("orderTablesCnt", orderTablesCnt);
        model.addAttribute("tableGroups", tableGroups);
        model.addAttribute("priceSumList", priceSumList);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("tables", tables);
        model.addAttribute("floor", floor);

        return "/usr/home/home";
    }

//    @RequestMapping("/home")
//    @ResponseBody
//    public ResultDate Home(Model model, @RequestParam(defaultValue = "1") int floor) {
//
//        if (floor <= 0 || floor > 3) {
//            return ResultDate.from("F-1", "잘못 된 번호 입력");
//        }
//
//        rq.floor(floor);
//        List<CartItems> cartItems = homeService.getCartItems(floor);
//        List<Table> tables = homeService.getTableLIst(floor);
//        List<CartItems> priceSumList = homeService.getPriceSumList(floor);
//        List<TableGroup> tableGroups = homeService.getTableGroups();
//        int orderTablesCnt = 0;
//        for (int i = 1; i <= 3; i++) {
//            List<CartItems> orderTablesList = homeService.getOrderTablesList(i);
//            orderTablesCnt += orderTablesList.size();
//        }
//
//
//        model.addAttribute("orderTablesCnt", orderTablesCnt);
//        model.addAttribute("tableGroups", tableGroups);
//        model.addAttribute("priceSumList", priceSumList);
//        model.addAttribute("cartItems", cartItems);
//        model.addAttribute("tables", tables);
//        model.addAttribute("floor", floor);
//
//        return ResultDate.from("S-1", "성공", "tables", tables,
//                "priceSumList", priceSumList, "cartItems", cartItems);
//    }

    // ==============================================================//

    @RequestMapping("/usr/tables/update")
    @ResponseBody
    public String Update(int elPosX, int elPosY, String tableName, int floor) {
        homeService.updateTablePos(elPosX, elPosY, tableName, floor);
        return "";
    }

// ==============================================================//

    @RequestMapping("/usr/main/salesSummary")
    public String salesSummary(@RequestParam(defaultValue = "전체") String floor, Model model) {

        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String openingDate = businessFullDate[0];

        List<Integer> payedTotalAmount = homeService.getPayedTotalAmount(floor, openingDate);
        List<Integer> payedTotalCnt = homeService.getPayedTotalCnt(floor, openingDate);
        List<Integer> payedTotalDiscountAmount = homeService.getPayedTotalDiscountAmount(floor, openingDate);
        List<Integer> numberOfReturns = homeService.getNumberOfReturns(floor, openingDate);
        List<Integer> amountOfReturns = homeService.getAmountOfReturns(floor, openingDate);
        int outstandingAmount = homeService.getOutstandingAmount(floor, openingDate);
        int VAT_Amount = (payedTotalAmount.get(0) / 100) * 11;

        model.addAttribute("floor", floor);
        model.addAttribute("businessDate", openingDate);
        model.addAttribute("payedTotalDiscountAmount", String.valueOf(payedTotalDiscountAmount.get(0)));
        model.addAttribute("payedTotalAmount", String.valueOf(payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCartSumAmount", String.valueOf(payedTotalAmount.get(0)));
        model.addAttribute("payedCashSumAmount", String.valueOf(payedTotalAmount.get(1)));
        model.addAttribute("VAT_Amount", String.valueOf(VAT_Amount));
        model.addAttribute("outstandingAmount", String.valueOf(outstandingAmount));
        model.addAttribute("expectedSales", String.valueOf(outstandingAmount + payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCartCnt", payedTotalCnt.get(0));
        model.addAttribute("payedCashCnt", payedTotalCnt.get(1));
        model.addAttribute("numberOfReturns", String.valueOf(numberOfReturns.get(0) + numberOfReturns.get(1)));
        model.addAttribute("amountOfReturns", String.valueOf(amountOfReturns.get(0) + amountOfReturns.get(1)));
        return "usr/home/salesSummary";
    }

    // ============================================================== //

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

    // ============================================================== //

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
