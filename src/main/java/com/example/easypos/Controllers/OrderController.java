package com.example.easypos.Controllers;

import com.example.easypos.Services.OrderService;
import com.example.easypos.Util.Util;
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
public class OrderController {
    private OrderService orderService;
    private Rq rq;
    private LocalTime now;
    private Date dateNow;
    private DateTimeFormatter formatter;
    private SimpleDateFormat dateFormatter;

    @Autowired
    public OrderController(OrderService orderService, Rq rq) {
        this.orderService = orderService;
        this.rq = rq;
        this.now = LocalTime.now();
        this.dateNow = new Date();
        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    @RequestMapping("/usr/tables/detail")
    public String Detail(String tabId, @RequestParam(defaultValue = "1") int floor, Model model) throws ParseException {

        int tabNum = Integer.parseInt(tabId);
        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String businessDate = businessFullDate[0];
        String currentDate = dateFormatter.format(dateNow);
        Date format1 = dateFormatter.parse(businessDate);
        Date format2 = dateFormatter.parse(currentDate);
        long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이

        String beginDate = businessDate + " 00:00:00";
        if (diffSec != 0) {
            businessDate = currentDate;
        }
        String endDate = businessDate + " 23:59:59";

        if (floor <= 0 || floor > 3) {
            return rq.jsReturnOnView("갯층 값이 잘 못 입력하였습니다.");
        }

        List<ProductType> productTypes = orderService.getProductTypes();
        List<Product> products = orderService.getProductList(productTypes.get(0).getCode(), productTypes.get(0).getKorName());
        List<CartItems> cartItemsList = orderService.getCartItemsList(tabNum, floor, beginDate, endDate);

        int totalQuantity = 0;
        int totalPrice = 0;
        int discountSumAMount = 0;
        int receiveAmount = 0;

        if (cartItemsList.size() != 0) {
            totalQuantity = cartItemsList.size();
            for (CartItems cartItems : cartItemsList) {
                totalPrice += (cartItems.getProductSumPrice() + cartItems.getProductSailPrice());
                discountSumAMount += cartItems.getProductSailPrice();
            }
            receiveAmount = (totalPrice - discountSumAMount);
        }

        Cart cart = orderService.getCart(floor, tabNum, beginDate, endDate);

        if (cart != null) {
            List<paymentCash> paymentCashList = orderService.getPaymentCashList(tabNum, floor, cart.getId());
            List<paymentCreditCart> paymentCartList = orderService.getPaymentCartList(tabNum, floor, cart.getId());

            if (paymentCartList.size() != 0 || paymentCashList.size() != 0) {
                model.addAttribute("paymentCashList", paymentCashList);
                model.addAttribute("paymentCartList", paymentCartList);
            }
        }

        model.addAttribute("tabId", tabId);
        model.addAttribute("floor", floor);
        model.addAttribute("productTypes", productTypes);
        model.addAttribute("cartItemsList", cartItemsList);
        model.addAttribute("products", products);
        model.addAttribute("totalQuantity", totalQuantity);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("discountSumAMount", discountSumAMount);
        model.addAttribute("receiveAmount", receiveAmount);
        return "/usr/table/detail";
    }

    // ==============================================================//
    @RequestMapping("/usr/tables/detail/getProduct")
    @ResponseBody
    public ResponseEntity getProductList(String productTypeCode, String productTypeName) {

        List<Product> productList = orderService.getProductList(productTypeCode, productTypeName);
        return ResponseEntity.ok().body(productList);
    }
    // ==============================================================//

    @RequestMapping("/usr/tables/insertProduct")
    @ResponseBody
    public String insertProduct(@RequestParam(defaultValue = "") List<Integer> productIdList,
                                @RequestParam(defaultValue = "") List<Integer> productCntList,
                                @RequestParam(defaultValue = "") List<Integer> productSailPriceList,
                                @RequestParam(defaultValue = "") List<Integer> productPricesList,
                                @RequestParam(defaultValue = "") List<String> productNamesList,
                                @RequestParam(defaultValue = "") List<Integer> updateProIdList,
                                @RequestParam(defaultValue = "") List<String> updateProNameList,
                                @RequestParam(defaultValue = "") List<Integer> updateProCntList,
                                @RequestParam(defaultValue = "") List<Integer> updateProPriceList,
                                @RequestParam(defaultValue = "") List<Integer> updateProSailPriceList,
                                @RequestParam(defaultValue = "") List<Integer> delProductList,
                                @RequestParam(defaultValue = "") List<String> delProductNameList,
                                @RequestParam(defaultValue = "1") int floor,
                                int tabId, String isPrintControl) throws ParseException {

        String[] businessFullDate = rq.getBusinessDate().split(" ");
        String businessDate = businessFullDate[0] + " ";
        String currentDate = dateFormatter.format(dateNow);
        Date format1 = dateFormatter.parse(businessDate);
        Date format2 = dateFormatter.parse(currentDate);
        long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이
        String beginDate = businessDate + " 00:00:00";

        // 만약에 영업일이 현재 날짜랑 안 맞을 때
        if (diffSec != 0) {
            businessDate = currentDate;
        }
        String endDate = businessDate + " 23:59:59";

        if (floor <= 0 || floor > 3) {
            return Util.jsHistoryBack("갯층 값이 잘 못 입력하였습니다.");
        }

        // 새 주문하거나 새주문한 상품을 추가할 때 작동
        if (productIdList.size() != 0) {
            Cart cart;
            cart = orderService.getCart(floor, tabId, beginDate, endDate);
            if (cart == null) {
                orderService.createCart(floor, tabId);
                cart = orderService.getCart(floor, tabId, beginDate, endDate);
            }

            for (int i = 0; i < productIdList.size(); i++) {
                CartItems cartItem = orderService.getCartItem(productIdList.get(i), productNamesList.get(i), tabId, floor);

                if (cartItem == null || (productNamesList.get(i).startsWith("[S]"))) {
                    orderService.insertCartItems(businessDate, productIdList.get(i), productCntList.get(i),
                            productSailPriceList.get(i), productPricesList.get(i), productNamesList.get(i), tabId, floor, cart.getId());

                    if (isPrintControl.equals("true")) {
                        System.out.println("     [주문서]     ");
                        System.out.println(String.format("[%d층]  %d번", floor, tabId));
                        System.out.println(String.format("%s   " + "    %d", productNamesList.get(i), productCntList.get(i)));
                        System.out.println("        " + now.format(formatter));
                        System.out.println("고객수 :   0");
                        System.out.println("주문번호 :   0");
                        System.out.println("===========================");
                    }

                } else {
                    int productCnt = cartItem.getQuantity() + productCntList.get(i);
                    int productSailPrice = cartItem.getProductSailPrice() + productSailPriceList.get(i);
                    int productPrice = cartItem.getProductSumPrice() + productPricesList.get(i);

                    orderService.updateCartItems(businessDate, productIdList.get(i), productCnt, productSailPrice,
                            productPrice, productNamesList.get(i), tabId, floor);

                    if (isPrintControl.equals("true")) {
                        System.out.println("     [주문서]     ");
                        System.out.println(String.format("[%d층]  %d번", floor, tabId));
                        System.out.println(String.format("%s   " + "    %d", productNamesList.get(i), (productCntList.get(i) - cartItem.getQuantity())));
                        System.out.println("        " + now.format(formatter));
                        System.out.println("고객수 :   0");
                        System.out.println("주문번호 :   0");
                        System.out.println("===========================");
                    }
                }
            }
        }
        // 원래 있던 상품을 + 버튼으로 추가 시 아님 상품을 사비서 처리 할때 작동
        if (updateProIdList.size() != 0) {

            for (int i = 0; i < updateProIdList.size(); i++) {
                String updateProName = updateProNameList.get(i);
                if (updateProNameList.get(i).startsWith("[S]")) {
                    updateProName = updateProNameList.get(i).replace("[S]", "");
                } else if (updateProNameList.get(i).startsWith("[S]") == false) {
                    updateProName = "[S]".concat(updateProNameList.get(i));
                }

                CartItems updateProduct = orderService.getCartItem(updateProIdList.get(i), updateProNameList.get(i), tabId, floor);
                CartItems updateFreeProduct = orderService.getCartItem(updateProIdList.get(i), updateProName, tabId, floor);

                if (updateProduct != null || updateFreeProduct != null) {
                    orderService.updateCartItems(businessDate, updateProIdList.get(i), updateProCntList.get(i), updateProSailPriceList.get(i),
                            updateProPriceList.get(i), updateProNameList.get(i), tabId, floor);
                    int updateProCnt = updateProduct == null ? updateFreeProduct.getQuantity() + 1 : updateProduct.getQuantity();
                    if (isPrintControl.equals("true")) {
                        System.out.println("     [주문서]     ");
                        System.out.println(String.format("[%d층]  %d번", floor, tabId));
                        System.out.println(String.format("%s   " + "    %d", updateProNameList.get(i), updateProCntList.get(i) - updateProCnt));
                        System.out.println("        " + now.format(formatter));
                        System.out.println("고객수 :   0");
                        System.out.println("주문번호 :   0");
                        System.out.println("===========================");
                    }
                }
            }
        }
        // 상품을 취소 할 때 작동
        if (delProductList.size() != 0) {
            for (int i = 0; i < delProductList.size(); i++) {
                CartItems cancelProduct = orderService.getCartItem(delProductList.get(i), delProductNameList.get(i), tabId, floor);
                if (cancelProduct != null) {
                    orderService.cancelProduct(delProductList.get(i), delProductNameList.get(i), tabId, floor);

                    if (isPrintControl.equals("true")) {
                        System.out.println("     [주문서]     ");
                        System.out.println(String.format("[%d층]  %d번", floor, tabId));
                        System.out.println(String.format("%s   " + "    -%d취소", cancelProduct.getProductName(), cancelProduct.getQuantity()));
                        System.out.println("        " + now.format(formatter));
                        System.out.println("고객수 :   0");
                        System.out.println("주문번호 :   0");
                        System.out.println("===========================");
                    }

                    List<CartItems> cartItems = orderService.getCartItemsList(tabId, floor, beginDate, endDate);
                    if (cartItems.size() == 0) {
                        orderService.removeCart(tabId, floor);
                    }
                }
            }
        }

        return Util.jsReplace("/?floor=" + floor);
    }

    // ==============================================================//

    @RequestMapping("/usr/tables/getProduct")
    @ResponseBody
    public ResultDate getProduct(int id, int tabId, int floor) {

        if (floor <= 0 || floor > 3) {
            return ResultDate.from("F-1", "갯층 값이 잘 못 입력하였습니다.");
        }

        Product product = orderService.getProductById(id);
        return ResultDate.from("s-1", "data 보내기 성공", "product", product);
    }

    // ==============================================================//

    @RequestMapping("/usr/tables/getCartItemSumPrice")
    @ResponseBody
    public ResultDate getCartItemSize(int tabId, int floor) {

        if (floor <= 0 || floor > 3) {
            return ResultDate.from("F-1", "갯층 값이 잘 못 입력하였습니다.");
        }

        int totalSumPrice = orderService.getTotalSumPrice(tabId, floor);
        return ResultDate.from("s-1", "data 보내기 성공", "totalSumPrice", totalSumPrice);
    }

    // ==============================================================//

    @RequestMapping("/usr/tables/getProductTotalSumPriceAndTotalQuantity")
    @ResponseBody
    public ResultDate getProductTotalSumPriceAndTotalQuantity(int tabId, int floor) {
        int totalQuantity = orderService.getTotalQuantity(tabId, floor);
        int totalSumPrice = orderService.getTotalSumPrice(tabId, floor);
        int totalSailPrice = orderService.getTotalSailPrice(tabId, floor);
        return ResultDate.from("s-1", "data 보내기 성공",
                "totalQuantity", totalQuantity,
                "totalSumPrice", totalSumPrice + totalSailPrice,
                "amountToPay", totalSumPrice - rq.getLeftAmount());
    }

    // ==============================================================//


}
