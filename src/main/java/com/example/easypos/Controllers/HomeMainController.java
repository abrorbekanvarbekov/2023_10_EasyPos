package com.example.easypos.Controllers;

import com.example.easypos.Services.HomeMainService;
import com.example.easypos.Vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
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
        return ResultDate.from("S-1", "/usr/home-main/homeMainPage");
    }

    //    ============================================================================= //

    @RequestMapping("/usr/home-main/deadlineSettlement")
    public String deadlineSettlement(Model model) throws ParseException {

        String floor = String.valueOf(rq.getFloor());
        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String businessDate = businessFullDate[0];
        String openingTime = businessFullDate[1];
        String currentDate = dateFormatter.format(dateNow);
        Date format1 = dateFormatter.parse(businessDate);
        Date format2 = dateFormatter.parse(currentDate);
        long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이

        String beginDate = rq.getBusinessDate();

        if (diffSec != 0) {
            businessDate = currentDate;
        }

        String endDate = businessDate + " 23:59:59";


        List<Integer> payedTotalAmount = homeMainService.getPayedTotalAmount(floor, beginDate, endDate);
        List<Integer> payedTotalCnt = homeMainService.getPayedTotalCnt(floor, beginDate, endDate);
        List<Integer> payedTotalDiscountAmount = homeMainService.getPayedTotalDiscountAmount(floor, beginDate, endDate);
        List<Integer> numberOfReturns = homeMainService.getNumberOfReturns(floor, beginDate, endDate);
        List<Integer> amountOfReturns = homeMainService.getAmountOfReturns(floor, beginDate, endDate);
        int outstandingAmount = homeMainService.getOutstandingAmount(floor, beginDate, endDate);
        int outstandingTables = homeMainService.getOutstandingTables(floor, beginDate, endDate);
        int VAT_Amount = (payedTotalAmount.get(0) / 100) * 11;

        StringBuffer businessDateToFormat = new StringBuffer(businessDate.replaceAll("-", ""));
        businessDateToFormat.insert(4, "년 ");
        businessDateToFormat.insert(8, "월 ");
        businessDateToFormat.insert(12, "일 ");

        model.addAttribute("businessDate", businessDate);
        model.addAttribute("openingTime", openingTime);
        model.addAttribute("businessDateToFormat", businessDateToFormat);
        model.addAttribute("payedTotalDiscountAmount", String.valueOf(payedTotalDiscountAmount.get(0)));
        model.addAttribute("payedTotalAmount", String.valueOf(payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCartSumAmount", String.valueOf(payedTotalAmount.get(0)));
        model.addAttribute("payedCashSumAmount", String.valueOf(payedTotalAmount.get(1)));
        model.addAttribute("VAT_Amount", String.valueOf(VAT_Amount));
        model.addAttribute("NETsaleAmount", String.valueOf((payedTotalAmount.get(0) + payedTotalAmount.get(1)) - VAT_Amount));
        model.addAttribute("outstandingAmount", String.valueOf(outstandingAmount));
        model.addAttribute("outstandingTables", outstandingTables);
        model.addAttribute("expectedSales", String.valueOf(outstandingAmount + payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("payedCartCnt", payedTotalCnt.get(0));
        model.addAttribute("payedCashCnt", payedTotalCnt.get(1));
        model.addAttribute("numberOfReturns", String.valueOf(numberOfReturns.get(0) + numberOfReturns.get(1)));
        model.addAttribute("amountOfReturns", String.valueOf(amountOfReturns.get(0) + amountOfReturns.get(1)));
        return "/usr/home-main/deadlineSettlement";
    }

    @RequestMapping("/usr/home-main/setDeadlineSettlement")
    @ResponseBody
    public ResultDate<String> setDeadlineSettlement(String openingDate, String openEmployeeName, String openEmployeeCode, String closeEmployeeName, String closeEmployeeCode, int totalSales, int totalSalesCount, int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCart) {
        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String businessDate = businessFullDate[0];

        try {
            deadlineSettlement deadlineSettlement = homeMainService.getDeadlineSettlement(openingDate);
            if (deadlineSettlement == null) {
                homeMainService.insertDeadlineSettlement(openingDate, openEmployeeName, openEmployeeCode, closeEmployeeName, closeEmployeeCode, totalSales, totalSalesCount, discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCart);
            } else {
                homeMainService.updateDeadlineSettlement(openingDate, openEmployeeName, openEmployeeCode, closeEmployeeName, closeEmployeeCode, totalSales, totalSalesCount, discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCart);
            }

            rq.logout();
            rq.logoutToEmployee();
            homeMainService.removeLeftCartItem(businessDate);
            homeMainService.removeLeftCart(businessDate);
            return ResultDate.from("S-1", "/usr/member/loginPage");
        } catch (Exception e) {
            return ResultDate.from("F-1", e.getMessage());
        }
    }

    @RequestMapping("/usr/home-main/getDeadlineSettlement")
    @ResponseBody
    public ResponseEntity getDeadlineSettlement(String openingDate) throws ParseException {

        deadlineSettlement deadlineSettlement = homeMainService.getDeadlineSettlement(openingDate);
        String currentDate = dateFormatter.format(dateNow);
        Date format1 = dateFormatter.parse(openingDate);
        Date format2 = dateFormatter.parse(currentDate);
        long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이

        if (deadlineSettlement != null || diffSec < 0) {
            return ResponseEntity.ok().body(deadlineSettlement);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @RequestMapping("/usr/home-main/salesInformationManagement")
    public String SalesInformationManagement() {
        return "/usr/home-main/basicInformation";
    }
}
