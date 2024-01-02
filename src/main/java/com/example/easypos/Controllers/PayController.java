package com.example.easypos.Controllers;

import com.example.easypos.Services.PayService;
import com.example.easypos.Util.Util;
import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.ResultDate;
import com.example.easypos.Vo.Rq;
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

@Controller
public class PayController {
    private PayService payService;
    private Rq rq;
    private LocalTime now;
    private Date dateNow;
    private DateTimeFormatter formatter;
    private SimpleDateFormat dateFormatter;

    @Autowired
    public PayController(PayService payService, Rq rq) {
        this.payService = payService;
        this.rq = rq;
        this.now = LocalTime.now();
        this.dateNow = new Date();
        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    // ==================================================================//

    @RequestMapping("/usr/tables/orderPage/payByCreditCart")
    public String payByCreditCart(String AmountToBeReceivedCart, String CartTotalAmount, String CartSplitAmount,
                                  String CartTotalSailAmount, int floor, int tabId, Model model) {
        String CreditCartNumber = Util.getCreditCartNumbers();
        String CreditCartCompany = Util.getCreditCartCompany();
        String CreditCartValidYear = Util.getCreditCartValidTHRU();
        String CreditCartValidMonth = Util.getCreditCartValidTHRUMonth();


        model.addAttribute("floor", floor);
        model.addAttribute("tabId", tabId);
        model.addAttribute("CreditCartNumber", CreditCartNumber);
        model.addAttribute("CreditCartCompany", CreditCartCompany);
        model.addAttribute("CreditCartValidYear", CreditCartValidYear);
        model.addAttribute("CreditCartValidMonth", CreditCartValidMonth);
        model.addAttribute("amountToBeReceivedCartS", AmountToBeReceivedCart);
        model.addAttribute("totalAmount", CartTotalAmount);
        model.addAttribute("splitAmount", CartSplitAmount);
        model.addAttribute("cartTotalSailAmount", CartTotalSailAmount);
        return "/usr/table/payByCreditCart";
    }

    // ==================================================================//

    @RequestMapping("/usr/tables/orderPage/payByCash")
    public String payByCash(String AmountToBeReceivedCash, String CashTotalAmount, String CashSplitAmount,
                            String CashTotalSailAmount, int floor, int tabId, Model model) {


        model.addAttribute("floor", floor);
        model.addAttribute("tabId", tabId);
        model.addAttribute("amountToBeReceivedCash", AmountToBeReceivedCash);
        model.addAttribute("totalAmount", CashTotalAmount);
        model.addAttribute("splitAmount", CashSplitAmount);
        model.addAttribute("cashTotalSailAmount", CashTotalSailAmount);
        return "/usr/table/payByCash";
    }

    // ==================================================================//

    @RequestMapping("/usr/tables/orderPage/paymentCash")
    @ResponseBody
    public ResultDate paymentCash(int floor, int tabId, int totalAmount, int splitAmount,
                                  int cashTotalSailAmount, int amountToBeReceivedCartS, String isPrintReceipt, @RequestParam(defaultValue = "0") String authorizedNumber) {

        Cart cart = payService.getCart(floor, tabId);

        if (splitAmount == 0 || splitAmount == amountToBeReceivedCartS) {
            payService.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart.getId());
            payService.removePaidCartItem(floor, tabId);
            payService.removeCart(floor, tabId);
            rq.leftAmount(0);
            return ResultDate.from("S-1", String.format("/?floor=%d", floor));
        } else {
            payService.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart.getId());
            rq.leftAmount(rq.getLeftAmount() + splitAmount);
            return ResultDate.from("S-1", String.format("/usr/tables/detail?tabId=%d&floor=%d", tabId, floor));
        }
    }

    // ==================================================================//

    @RequestMapping("/usr/tables/orderPage/paymentCreditCart")
    @ResponseBody
    public ResultDate paymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount,
                                        String CreditCartNumber, int cartTotalSailAmount, int amountToBeReceivedCartS, String isPrintReceipt) {

        Cart cart = payService.getCart(floor, tabId);

        if (splitAmount == 0 || splitAmount == amountToBeReceivedCartS) {
            payService.insertPaymentCreditCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, CreditCartNumber, cart.getId());
            payService.removePaidCartItem(floor, tabId);
            payService.removeCart(floor, tabId);
            rq.leftAmount(0);
            return ResultDate.from("S-1", String.format("/?floor=%d", floor));
        } else {
            payService.insertPaymentCreditCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, CreditCartNumber, cart.getId());
            rq.leftAmount(rq.getLeftAmount() + splitAmount);
            return ResultDate.from("S-1", String.format("/usr/tables/detail?tabId=%d&floor=%d", tabId, floor));
        }
    }

    // ==================================================================//


}
