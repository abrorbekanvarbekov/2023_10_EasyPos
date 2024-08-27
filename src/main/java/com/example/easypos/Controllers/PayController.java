package com.example.easypos.Controllers;

import com.example.easypos.Services.PayService;
import com.example.easypos.Util.Util;
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

    @RequestMapping("/usr/tables/orderPage/payByCash")
    public String payByCash(int AmountToBeReceivedCash, int CashTotalAmount, int CashSplitAmount,
                            int CashChangeAmount, int CashTotalSailAmount, int floor, int tabId, Model model) {

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
    public ResultDate paymentCash(int floor, int tabId, int totalAmount, int splitAmount, int cashChangeAmount,
                                  int cashTotalSailAmount, int amountToBeReceivedCash, String isPrintReceipt, @RequestParam(defaultValue = "0") String authorizedNumber) {

        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String openingDate = businessFullDate[0];
        Cart cart = payService.getCart(floor, tabId);

        List<CartItems> cartItemsList = payService.getPaidCartItem(tabId, floor, cart.getId(), openingDate);
        if (isPrintReceipt.equals("true")) {
            int productSUmPrice = 0;
            System.out.println("     메뉴         단가        수량        금액");
            for (CartItems item : cartItemsList) {
                productSUmPrice += item.getProductSumPrice();
                System.out.println(String.format("%s        %d       %d     %d",
                        item.getProductName(),
                        item.getProductPrice(),
                        item.getQuantity(),
                        item.getProductSumPrice()));
            }
            System.out.println("------------------------------------------------");
            System.out.println(String.format("부가세 과세 물품가액  :                 %d", (productSUmPrice - productSUmPrice / 100 * 10)));
            System.out.println(String.format("부      가        세  :                 %d", productSUmPrice / 100 * 10));
            System.out.println("------------------------------------------------");
            System.out.println(String.format("합    계  :       %d", productSUmPrice));
            System.out.println(String.format("받을금액  :       %d", productSUmPrice));
            System.out.println(String.format("받은금액  :       %d", amountToBeReceivedCash));
            System.out.println(String.format("거스름돈  :       %d", (amountToBeReceivedCash - productSUmPrice)));
        }

        if (splitAmount == 0 || splitAmount == amountToBeReceivedCash || splitAmount > amountToBeReceivedCash) {
            payService.insertPaymentCash(floor, tabId, totalAmount, splitAmount > amountToBeReceivedCash ? splitAmount : amountToBeReceivedCash,
                    cashTotalSailAmount, cart.getId(), openingDate);

            paymentCreditCardAndCash paymentCardAndCash = payService.getExistPaymentCardAndCashItem(cart.getId(), openingDate);
            if (paymentCardAndCash == null) {
                payService.insertPaymentCartAndCashForCash(floor, tabId, totalAmount, splitAmount > amountToBeReceivedCash ? splitAmount : amountToBeReceivedCash,
                        cashTotalSailAmount, cart.getId(), openingDate);
            } else {
                payService.updatePaymentCartAndCashForCash(floor, tabId, totalAmount, splitAmount > amountToBeReceivedCash ? splitAmount : amountToBeReceivedCash,
                        cashTotalSailAmount, cart.getId(), openingDate);
            }

            payService.removePaidCartItem(floor, tabId, openingDate);
            payService.removeCart(floor, tabId, openingDate);
            rq.leftAmount(0);

            return ResultDate.from("S-1", String.format("/?floor=%d", floor));

        } else {
            payService.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart.getId(), openingDate);

            paymentCreditCardAndCash paymentCardAndCash = payService.getExistPaymentCardAndCashItem(cart.getId(), openingDate);
            if (paymentCardAndCash == null) {
                payService.insertPaymentCartAndCashForCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart.getId(), openingDate);
            } else {
                payService.updatePaymentCartAndCashForCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart.getId(), openingDate);
            }

            rq.leftAmount(rq.getLeftAmount() + splitAmount);
            return ResultDate.from("S-1", String.format("/usr/tables/detail?tabId=%d&floor=%d", tabId, floor));
        }
    }

    // ==================================================================//

    @RequestMapping("/usr/tables/orderPage/payByCreditCard")
    public String payByCreditCard(int AmountToBeReceivedCard, int CardTotalAmount, int CardSplitAmount,
                                  int CardTotalSailAmount, int floor, int tabId, Model model) {
        String CreditCardNumber = Util.getCreditCartNumbers();
        String CreditCardCompany = Util.getCreditCartCompany();
        String CreditCardValidYear = Util.getCreditCartValidTHRU();
        String CreditCardValidMonth = Util.getCreditCartValidTHRUMonth();

        model.addAttribute("floor", floor);
        model.addAttribute("tabId", tabId);
        model.addAttribute("CreditCardNumber", CreditCardNumber);
        model.addAttribute("CreditCardCompany", CreditCardCompany);
        model.addAttribute("CreditCardValidYear", CreditCardValidYear);
        model.addAttribute("CreditCardValidMonth", CreditCardValidMonth);
        model.addAttribute("amountToBeReceivedCard", AmountToBeReceivedCard);
        model.addAttribute("totalAmount", CardTotalAmount);
        model.addAttribute("splitAmount", CardSplitAmount);
        model.addAttribute("cardTotalSailAmount", CardTotalSailAmount);
        return "/usr/table/payByCreditCart";
    }

    // ==================================================================//

    @RequestMapping("/usr/tables/orderPage/paymentCreditCard")
    @ResponseBody
    public ResultDate paymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount,
                                        String CreditCardNumber, int cardTotalSailAmount, int amountToBeReceivedCard, String isPrintReceipt) {

        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String openingDate = businessFullDate[0];
        Cart cart = payService.getCart(floor, tabId);

        List<CartItems> cartItemsList = payService.getPaidCartItem(tabId, floor, cart.getId(), openingDate);
        if (isPrintReceipt.equals("true")) {
            int productSUmPrice = 0;
            System.out.println("     메뉴         단가        수량        금액");
            for (CartItems item : cartItemsList) {
                productSUmPrice += item.getProductSumPrice();
                System.out.println(String.format("%s        %d       %d     %d",
                        item.getProductName(),
                        item.getProductPrice(),
                        item.getQuantity(),
                        item.getProductSumPrice()));
            }
            System.out.println("------------------------------------------------");
            System.out.println(String.format("부가세 과세 물품가액  :                 %d", (productSUmPrice - productSUmPrice / 100 * 10)));
            System.out.println(String.format("부      가        세  :                 %d", productSUmPrice / 100 * 10));
            System.out.println("------------------------------------------------");
            System.out.println(String.format("합    계  :       %d", productSUmPrice));
            System.out.println(String.format("받을금액  :       %d", productSUmPrice));
            System.out.println(String.format("받은금액  :       %d", amountToBeReceivedCard));
            System.out.println(String.format("거스름돈  :       %d", (amountToBeReceivedCard - productSUmPrice)));
        }

        if (splitAmount == 0 || splitAmount == amountToBeReceivedCard || splitAmount > amountToBeReceivedCard) {
            payService.insertPaymentCreditCard(floor, tabId, totalAmount, splitAmount > amountToBeReceivedCard ? splitAmount : amountToBeReceivedCard,
                    cardTotalSailAmount, CreditCardNumber, cart.getId(), openingDate);

            paymentCreditCardAndCash paymentCardAndCash = payService.getExistPaymentCardAndCashItem(cart.getId(), openingDate);
            if (paymentCardAndCash == null) {
                payService.insertPaymentCartAndCashForCart(floor, tabId, totalAmount, splitAmount > amountToBeReceivedCard ? splitAmount : amountToBeReceivedCard,
                        cardTotalSailAmount, CreditCardNumber, cart.getId(), openingDate);
            } else {
                payService.updatePaymentCartAndCashForCart(floor, tabId, totalAmount, splitAmount > amountToBeReceivedCard ? splitAmount : amountToBeReceivedCard,
                        cardTotalSailAmount, CreditCardNumber, cart.getId(), openingDate);
            }

            payService.removePaidCartItem(floor, tabId, openingDate);
            payService.removeCart(floor, tabId, openingDate);
            rq.leftAmount(0);
            return ResultDate.from("S-1", String.format("/?floor=%d", floor));
        } else {
            payService.insertPaymentCreditCard(floor, tabId, totalAmount, splitAmount, cardTotalSailAmount, CreditCardNumber, cart.getId(), openingDate);

            paymentCreditCardAndCash paymentCardAndCash = payService.getExistPaymentCardAndCashItem(cart.getId(), openingDate);
            if (paymentCardAndCash == null) {
                payService.insertPaymentCartAndCashForCart(floor, tabId, totalAmount, splitAmount, cardTotalSailAmount, CreditCardNumber, cart.getId(), openingDate);
            } else {
                payService.updatePaymentCartAndCashForCart(floor, tabId, totalAmount, splitAmount, cardTotalSailAmount, CreditCardNumber, cart.getId(), openingDate);
            }

            rq.leftAmount(rq.getLeftAmount() + splitAmount);
            return ResultDate.from("S-1", String.format("/usr/tables/detail?tabId=%d&floor=%d", tabId, floor));
        }
    }

    // ==================================================================//

    @RequestMapping("/usr/tables/orderPage/isExistCartItem")
    @ResponseBody
    public ResultDate isExistCartItem(int floor, int tabId) {
        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String openingDate = businessFullDate[0];

        List<CartItems> cartItem = payService.getIsExistCartItem(floor, tabId, openingDate);
        if (cartItem.size() == 0) {
            return ResultDate.from("F-1", "실패", "false", cartItem);
        }

        return ResultDate.from("S-1", "성공", "true", cartItem);
    }
}
