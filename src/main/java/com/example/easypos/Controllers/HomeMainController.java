package com.example.easypos.Controllers;

import com.example.easypos.Services.HomeMainService;
import com.example.easypos.Vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
        String endDate = dateFormatter.format(dateNow) + " 23:59:59";
        List<paymentCreditCardAndCash> paymentCardAndCashList = homeMainService.getPaymentCartAndCashList(rq.getOpeningDate(), endDate, "1");
        model.addAttribute("paymentCardAndCashList", paymentCardAndCashList);
        return "usr/home-main/salesHistory";
    }


    @RequestMapping("/usr/home-main/getPaymentCartList")
    @ResponseBody
    public ResultDate getPaymentCartList(String beginDate, String endDate, String floor) {
        List<paymentCreditCardAndCash> paymentCardAndCashList = homeMainService.getPaymentCartAndCashList(beginDate, endDate, floor);
        return ResultDate.from("S-1", "성공", "paymentCardAndCashList", paymentCardAndCashList);
    }

    @RequestMapping("/usr/home-main/getCartItemByCart_id")
    @ResponseBody
    public ResultDate getCartItemByCart_id(int cart_id) {
        List<CartItems> cartItemsList = homeMainService.getCartItemsByCart_id(cart_id, rq.getOpeningDate());
        return ResultDate.from("S-1", "성공", "cartItemsList", cartItemsList);
    }

    //    ============================================================================= //

    @RequestMapping("/usr/home-main/receiptReturn")
    public String receiptReturn(Model model) {
        String endDate = dateFormatter.format(dateNow) + " 23:59:59";
        List<paymentCreditCardAndCash> paymendCardAndCashList = homeMainService.getPaymentCartAndCashList(rq.getOpeningDate(), endDate, "1");
        model.addAttribute("paymentCardAndCashList", paymendCardAndCashList);
        return "usr/home-main/receiptReturn";
    }

    @RequestMapping("/usr/home-main/productReturn")
    @ResponseBody
    public ResultDate<String> productReturn(int cartId) {
        homeMainService.returnPaymentCartAndCash(cartId, rq.getOpeningDate());
        homeMainService.insertReturnPayment(cartId, rq.getOpeningDate());

        homeMainService.cancelReturnPaymentCart(cartId, rq.getOpeningDate());
        homeMainService.cancelReturnPaymentCash(cartId, rq.getOpeningDate());
        return ResultDate.from("S-1", "/usr/home-main/homeMainPage");
    }

    //    ============================================================================= //

    @RequestMapping("/usr/home-main/deadlineSettlement")
    public String deadlineSettlement(Model model) {

        String floor = String.valueOf(rq.getFloor());

        List<Integer> payedTotalAmount = homeMainService.getPayedTotalAmount(floor, rq.getOpeningDate());
        List<Integer> payedTotalCnt = homeMainService.getPayedTotalCnt(floor, rq.getOpeningDate());
        List<Integer> payedTotalDiscountAmount = homeMainService.getPayedTotalDiscountAmount(floor, rq.getOpeningDate());
        List<Integer> numberOfReturns = homeMainService.getNumberOfReturns(floor, rq.getOpeningDate());
        List<Integer> amountOfReturns = homeMainService.getAmountOfReturns(floor, rq.getOpeningDate());
        int outstandingAmount = homeMainService.getOutstandingAmount(floor, rq.getOpeningDate());
        int outstandingTables = homeMainService.getOutstandingTables(floor, rq.getOpeningDate());
        int VAT_Amount = (payedTotalAmount.get(0) / 100) * 11;

        StringBuffer businessDateToFormat = new StringBuffer(rq.getOpeningDate().replaceAll("-", ""));
        businessDateToFormat.insert(4, "년 ");
        businessDateToFormat.insert(8, "월 ");
        businessDateToFormat.insert(12, "일 ");

        model.addAttribute("businessDateToFormat", businessDateToFormat);
        model.addAttribute("payedTotalDiscountAmount", String.valueOf(payedTotalDiscountAmount.get(0)));
        model.addAttribute("payedTotalAmount", String.valueOf(payedTotalAmount.get(0) + payedTotalAmount.get(1)));
        model.addAttribute("tableUnitPrice", String.valueOf((payedTotalAmount.get(0) + payedTotalAmount.get(1))));
        model.addAttribute("payedCardSumAmount", String.valueOf(payedTotalAmount.get(0)));
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
    public ResultDate<String> setDeadlineSettlement(String openEmployeeName, String openEmployeeCode, String closeEmployeeName, String closeEmployeeCode, int totalSales, int totalSalesCount, int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCard) {
        try {
            deadlineSettlement deadlineSettlement = homeMainService.getDeadlineSettlement(rq.getOpeningDate());
            if (deadlineSettlement == null) {
                homeMainService.insertDeadlineSettlement(rq.getOpeningDate(), openEmployeeName, openEmployeeCode, closeEmployeeName, closeEmployeeCode, totalSales, totalSalesCount, discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCard);
            } else {
                homeMainService.updateDeadlineSettlement(rq.getOpeningDate(), openEmployeeName, openEmployeeCode, closeEmployeeName, closeEmployeeCode, totalSales, totalSalesCount, discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCard);
            }

            rq.deadlineSetLogOut();
            homeMainService.removeLeftCartItem(rq.getOpeningDate());
            homeMainService.removeLeftCart(rq.getOpeningDate());
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

    @RequestMapping("/usr/home-main/tableLayout")
    public String tableLayout(int floor, Model model) {
        List<Table> tableList = homeMainService.getTableList(floor);
        model.addAttribute("tableList", tableList);
        return "usr/home-main/otherManagement";
    }

    @RequestMapping("/usr/home-main/createTable")
    @ResponseBody
    public ResponseEntity<?> createTable(int tableNum, String tableColor, int floor, int width,
                                         int height, int top, int left, int border_radius) {
        int result = homeMainService.createTable(tableNum, tableColor, floor, width,
                height, top, left, border_radius);
        if (result == 1) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.badRequest().body("테이블이 생성되지 않았습니다.");
        }
    }

    @RequestMapping("/usr/home-main/updateTable")
    @ResponseBody
    public ResponseEntity<?> updateTable(int width, int height, int elPosX, int elPosY, int number, int floor) {
        homeMainService.updateTable(width, height, elPosX, elPosY, number, floor);
        return ResponseEntity.ok().build();

    }
}
