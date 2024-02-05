package com.example.easypos.Controllers;

import com.example.easypos.Services.HomeMainService;
import com.example.easypos.Vo.*;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
public class HomeMainController {
    private HomeMainService homeMainService;
    private Rq rq;
    private LocalTime now;
    private Date dateNow;
    private DateTimeFormatter formatter;
    private SimpleDateFormat dateFormatter;

    @Autowired
    public HomeMainController(HomeMainService homeMainService, Rq rq) {
        this.homeMainService = homeMainService;
        this.rq = rq;
        this.now = LocalTime.now();
        this.dateNow = new Date();
        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    @RequestMapping("/usr/home/homeMainPage")
    public String homeMainPage() {

        return "/usr/home/homeMainPage";
    }

    //    ============================================================================= //
    @RequestMapping("/usr/home/salesHistory")
    public String salesHistory(Model model) {
        String todayDate = dateFormatter.format(dateNow);
        List<paymentCreditCartAndCash> paymentCartAndCashList = homeMainService.getPaymentCartAndCashList(todayDate + " 00:00:00", todayDate + " 23:59:59", "1");
        model.addAttribute("paymentCartAndCashList", paymentCartAndCashList);
        return "/usr/home/salesHistory";
    }


    @RequestMapping("/usr/home/getPaymentCartList")
    @ResponseBody
    public ResultDate getPaymentCartList(String beginDate, String endDate, String floor) {

        List<paymentCreditCartAndCash> paymentCartAndCashList = homeMainService.getPaymentCartAndCashList(beginDate + " 00:00:00", endDate + " 23:59:59", floor);
        return ResultDate.from("S-1", "성공", "paymentCartAndCashList", paymentCartAndCashList);
    }

    @RequestMapping("/usr/home/getCartItemByCart_id")
    @ResponseBody
    public ResultDate getCartItemByCart_id(int cart_id) {
        List<CartItems> cartItemsList = homeMainService.getCartItemsByCart_id(cart_id);
        return ResultDate.from("S-1", "성공", "cartItemsList", cartItemsList);
    }

    //    ============================================================================= //
    @RequestMapping("/usr/home/receiptReturn")
    public String receiptReturn(Model model) {
        String todayDate = dateFormatter.format(dateNow);
        List<paymentCreditCartAndCash> paymentCartAndCashList = homeMainService.getPaymentCartAndCashList(todayDate + " 00:00:00", todayDate + " 23:59:59", "1");
        model.addAttribute("paymentCartAndCashList", paymentCartAndCashList);
        return "/usr/home/receiptReturn";
    }

    @RequestMapping("/usr/home/productReturn")
    @ResponseBody
    public String productReturn(int cartId) {
        try {
            homeMainService.returnPaymentCartAndCash(cartId);
            homeMainService.insertReturnPayment(cartId);

            homeMainService.cancelReturnPaymentCart(cartId);
            homeMainService.cancelReturnPaymentCash(cartId);
        }catch (Exception e){
        }
        return "";
    }

}
