package com.example.easypos.Controllers;

import com.example.easypos.Services.HomeMainService;
import com.example.easypos.Services.HomeService;
import com.example.easypos.Vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
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

    private HomeService homeService;

    @Autowired
    public HomeMainController(HomeMainService homeMainService, Rq rq, HomeService homeService) {
        this.homeMainService = homeMainService;
        this.homeService = homeService;
        this.rq = rq;
        this.now = LocalTime.now();
        this.dateNow = new Date();
        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    @RequestMapping("/usr/home-main/homeMainPage")
    public String homeMainPage() {
        return "usr/home-main/homeMainPage";
    }

    //    ============================================================================= //
    @RequestMapping("/usr/home-main/salesHistory")
    public String salesHistory(Model model) {
        String todayDate = dateFormatter.format(dateNow);
        List<paymentCreditCartAndCash> paymentCartAndCashList = homeMainService.getPaymentCartAndCashList(todayDate + " 00:00:00", todayDate + " 23:59:59", "1");
        model.addAttribute("paymentCartAndCashList", paymentCartAndCashList);
        return "usr/home-main/salesHistory";
    }


    @RequestMapping("/usr/home-main/getPaymentCartList")
    @ResponseBody
    public ResultDate getPaymentCartList(String beginDate, String endDate, String floor) {

        List<paymentCreditCartAndCash> paymentCartAndCashList = homeMainService.getPaymentCartAndCashList(beginDate + " 00:00:00", endDate + " 23:59:59", floor);
        return ResultDate.from("S-1", "성공", "paymentCartAndCashList", paymentCartAndCashList);
    }

    @RequestMapping("/usr/home-main/getCartItemByCart_id")
    @ResponseBody
    public ResultDate getCartItemByCart_id(int cart_id) {
        List<CartItems> cartItemsList = homeMainService.getCartItemsByCart_id(cart_id);
        return ResultDate.from("S-1", "성공", "cartItemsList", cartItemsList);
    }

    //    ============================================================================= //

    @RequestMapping("/usr/home-main/receiptReturn")
    public String receiptReturn(Model model) {
        String todayDate = dateFormatter.format(dateNow);
        List<paymentCreditCartAndCash> paymentCartAndCashList = homeMainService.getPaymentCartAndCashList(todayDate + " 00:00:00", todayDate + " 23:59:59", "1");
        model.addAttribute("paymentCartAndCashList", paymentCartAndCashList);
        return "usr/home-main/receiptReturn";
    }

    @RequestMapping("/usr/home-main/productReturn")
    @ResponseBody
    public ResultDate<String> productReturn(int cartId) {
        homeMainService.returnPaymentCartAndCash(cartId);
        homeMainService.insertReturnPayment(cartId);

        homeMainService.cancelReturnPaymentCart(cartId);
        homeMainService.cancelReturnPaymentCash(cartId);
        return ResultDate.from("S-1", "/usr/home/homeMainPage");
    }

    //    ============================================================================= //

    @RequestMapping("/usr/home-main/deadlineSettlement")
    public String deadlineSettlement(Model model) {

        List<Integer> payedTotalAmount = homeService.getPayedTotalAmount("전체");
        List<Integer> payedTotalCnt = homeService.getPayedTotalCnt("전체");
        List<Integer> payedTotalDiscountAmount = homeService.getPayedTotalDiscountAmount("전체");
        List<Integer> numberOfReturns = homeService.getNumberOfReturns("전체");
        List<Integer> amountOfReturns = homeService.getAmountOfReturns("전체");
        int outstandingAmount = homeService.getOutstandingAmount("전체");
        int VAT_Amount = (payedTotalAmount.get(0) / 100) * 11;
        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String businessDate = businessFullDate[0];
        String openingTime = businessFullDate[1];

        model.addAttribute("businessDate", businessDate);
        model.addAttribute("openingTime", openingTime);
        model.addAttribute("payedTotalDiscountAmount", String.valueOf(payedTotalDiscountAmount.get(0)));
        model.addAttribute("payedTotalAmount", String.valueOf(payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCartSumAmount", String.valueOf(payedTotalAmount.get(0)));
        model.addAttribute("payedCashSumAmount", String.valueOf(payedTotalAmount.get(1)));
        model.addAttribute("VAT_Amount", String.valueOf(VAT_Amount));
        model.addAttribute("NETsaleAmount", String.valueOf((payedTotalAmount.get(0) + payedTotalAmount.get(1)) - VAT_Amount));
        model.addAttribute("outstandingAmount", String.valueOf(outstandingAmount));
        model.addAttribute("expectedSales", String.valueOf(outstandingAmount + payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCartCnt", payedTotalCnt.get(0));
        model.addAttribute("payedCashCnt", payedTotalCnt.get(1));
        model.addAttribute("numberOfReturns", String.valueOf(numberOfReturns.get(0) + numberOfReturns.get(1)));
        model.addAttribute("amountOfReturns", String.valueOf(amountOfReturns.get(0) + amountOfReturns.get(1)));
        return "/usr/home-main/deadlineSettlement";
    }
}
