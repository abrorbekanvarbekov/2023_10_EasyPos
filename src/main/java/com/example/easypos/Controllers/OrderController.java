package com.example.easypos.Controllers;

import com.example.easypos.Services.OrderService;
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
import java.util.ArrayList;
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
    public String Detail(String tabId, @RequestParam(defaultValue = "1") int floor, Model model) {
        int tabNum = Integer.parseInt(tabId);

        if (floor <= 0 || floor > 3) {
            return rq.jsReturnOnView("갯층 값이 잘 못 입력하였습니다.");
        }


        List<ProductType> productTypes = orderService.getProductTypes();
        List<Product> products = orderService.getProductList();
        List<CartItems> cartItemsList = orderService.getCartItemsList(tabNum, floor);
        int discountSumAMount = orderService.getDiscountSumAmount(tabNum, floor);

        model.addAttribute("tabId", tabId);
        model.addAttribute("floor", floor);
        model.addAttribute("discountSumAMount", discountSumAMount);
        model.addAttribute("productTypes", productTypes);
        model.addAttribute("cartItemsList", cartItemsList);
        model.addAttribute("products", products);
        return "/usr/table/detail";
    }

    // ==============================================================//

    @RequestMapping("/usr/tables/insertProduct")
    @ResponseBody
    public String insertProduct(String productIds, String productCnts,
                                String productSailPrices, String productPrices, String productNames, String delProductIds,
                                @RequestParam(defaultValue = "1") int floor, int tabId, String isPrintControl) {

        if (floor <= 0 || floor > 3) {
            return Util.jsHistoryBack("갯층 값이 잘 못 입력하였습니다.");
        }

        if (delProductIds.length() != 0) {
            List<Integer> delProductList = new ArrayList<>();
            for (String ids : delProductIds.split(",")) {
                delProductList.add(Integer.parseInt(ids));
            }

            System.out.println(delProductList);
            for (int i = 0; i < delProductList.size(); i++) {
                CartItems cancelProduct = orderService.getCartItem(delProductList.get(i), tabId, floor);
                orderService.cancelProduct(delProductList.get(i), tabId, floor);
                if (isPrintControl.equals("true")) {
                    System.out.println("     [주문서]     ");
                    System.out.println(String.format("[%d층]  %d번", floor, tabId));
                    System.out.println(String.format("%s   " + "    -%d취소", cancelProduct.getProductName(), cancelProduct.getQuantity()));
                    System.out.println("        " + now.format(formatter));
                    System.out.println("고객수 :   0");
                    System.out.println("주문번호 :   0");
                    System.out.println("===========================");
                }
            }
        }


        if (productIds.length() != 0) {

            List<Integer> productIdList = new ArrayList<>();
            for (String ids : productIds.split(",")) {
                productIdList.add(Integer.parseInt(ids));
            }

            List<Integer> productCntList = new ArrayList<>();
            for (String cnt : productCnts.split(",")) {
                productCntList.add(Integer.parseInt(cnt));
            }

            List<Integer> productSailPriceList = new ArrayList<>();
            for (String cnt : productSailPrices.split(",")) {
                productSailPriceList.add(Integer.parseInt(cnt));
            }

            List<Integer> productPricesList = new ArrayList<>();
            for (String cnt : productPrices.split(",")) {
                productPricesList.add(Integer.parseInt(cnt));
            }

            List<String> productNamesList = new ArrayList<>();
            for (String cnt : productNames.split(",")) {
                productNamesList.add(cnt);
            }

            Cart cart;

            cart = orderService.getCart(floor, tabId);

            if (cart == null) {
                orderService.createCart(floor, tabId);
                cart = orderService.getCart(floor, tabId);
            }

            for (int i = 0; i < productIdList.size(); i++) {
                CartItems cartItem = orderService.getCartItem(productIdList.get(i), tabId, floor);
                if (cartItem == null) {
                    orderService.insertCartItems(productIdList.get(i), productCntList.get(i),
                            productSailPriceList.get(i), productPricesList.get(i), productNamesList.get(i), tabId, floor, cart.getId());
                    if (isPrintControl.equals("true")) {
                        Product orderProduct = orderService.getProductName(productIdList.get(i));
                        System.out.println("     [주문서]     ");
                        System.out.println(String.format("[%d층]  %d번", floor, tabId));
                        System.out.println(String.format("%s   " + "    %d", orderProduct.getName(), productCntList.get(i)));
                        System.out.println("        " + now.format(formatter));
                        System.out.println("고객수 :   0");
                        System.out.println("주문번호 :   0");
                        System.out.println("===========================");
                    }
                } else {
                    if (cartItem.getQuantity() != productCntList.get(i) || cartItem.getProductSailPrice() != productSailPriceList.get(i)) {
                        orderService.updateCartItems(productIdList.get(i), productCntList.get(i), productSailPriceList.get(i),
                                productPricesList.get(i), productNamesList.get(i), tabId, floor);
                        if (isPrintControl.equals("true")) {
                            System.out.println("     [주문서]     ");
                            System.out.println(String.format("[%d층]  %d번", floor, tabId));
                            System.out.println(String.format("%s   " + "    %d", productNamesList.get(i),
                                    productSailPriceList.get(i) == 0 ? (productCntList.get(i) - cartItem.getQuantity()) : productCntList.get(i)));
                            System.out.println("        " + now.format(formatter));
                            System.out.println("고객수 :   0");
                            System.out.println("주문번호 :   0");
                            System.out.println("===========================");
                        }
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
