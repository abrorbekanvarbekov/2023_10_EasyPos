//package com.example.easypos.Controllers;
//
//import com.example.easypos.Services.TableService;
//import com.example.easypos.Util.Util;
//import com.example.easypos.Vo.*;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import java.text.SimpleDateFormat;
//import java.time.LocalTime;
//import java.time.format.DateTimeFormatter;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//
//@Controller
//public class TableController {
//    private TableService tableService;
//    private Rq rq;
//    private LocalTime now;
//    private Date dateNow;
//    private DateTimeFormatter formatter;
//    private SimpleDateFormat dateFormatter;
//
//    @Autowired
//    public TableController(TableService tableService, Rq rq) {
//        this.tableService = tableService;
//        this.rq = rq;
//        this.now = LocalTime.now();
//        this.dateNow = new Date();
//        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
//        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
//    }
//
////   ========== Main Page Functions  ============= //
//
//    @RequestMapping("/")
//    public String Tables(Model model, @RequestParam(defaultValue = "1") int floor) {
//
//        if (floor <= 0 || floor > 3) {
//            return rq.jsReturnOnView("잘못 된 번호 입력");
//        }
//
//        rq.floor(floor);
//        List<CartItems> cartItems = tableService.getCartItems(floor);
//        List<Table> tables = tableService.getTableLIst(floor);
//        List<CartItems> priceSumList = tableService.getPriceSumList(floor);
//        List<TableGroup> tableGroups = tableService.getTableGroups();
//        int orderTablesCnt = 0;
//        for (int i = 1; i <= 3; i++) {
//            List<CartItems> orderTablesList = tableService.getOrderTablesList(i);
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
//        return "/usr/home/home";
//    }
//
//
//    @RequestMapping("/usr/tables/update")
//    @ResponseBody
//    public String Update(int elPosX, int elPosY, int number, int floor) {
//        tableService.updateTablePos(elPosX, elPosY, number, floor);
//        return "";
//    }
//
//    @RequestMapping("/usr/tables/movement")
//    @ResponseBody
//    public ResultDate movement(int currTableNum, int afterTableNum, int floor, String msg) {
//        List<CartItems> currCartItems = tableService.getCurrCartItem(currTableNum, floor);
//        List<CartItems> afterCartItems = tableService.getCurrCartItem(afterTableNum, floor);
//
//        if (afterCartItems.size() != 0) {
//            tableService.removeCart(floor, afterTableNum);
//        }
//
//        Cart cart = tableService.getCart(floor, currTableNum);
//        if (currCartItems.size() != 0) {
//            for (CartItems currentCartItem : currCartItems) {
//                CartItems item = tableService.getCartItem(currentCartItem.getProduct_id(), afterTableNum, floor);
//                if (item != null && currTableNum != afterTableNum) {
//                    if (currentCartItem.getProductSailPrice() != 0){
//                        tableService.toMoveCartItems(currentCartItem.getProduct_id(), currentCartItem.getProductName(), afterTableNum,
//                                currentCartItem.getQuantity(), currentCartItem.getProductPrice(), currentCartItem.getProductSumPrice(),
//                                currentCartItem.getProductSailPrice(),floor, cart.getId());
//                    }else if (currentCartItem.getProductSailPrice() == 0){
//                        tableService.toMoveUpdateCartItems(afterTableNum, floor, currentCartItem.getProduct_id(), currentCartItem.getQuantity(),
//                                currentCartItem.getProductSailPrice(), currentCartItem.getProductSumPrice(), currentCartItem.getCart_id());
//                    }
//                    tableService.updateCart(floor, afterTableNum, currTableNum);
//
//                } else if (item == null) {
//                    tableService.toMoveCartItems(currentCartItem.getProduct_id(), currentCartItem.getProductName(), afterTableNum,
//                            currentCartItem.getQuantity(), currentCartItem.getProductPrice(), currentCartItem.getProductSumPrice(),
//                            currentCartItem.getProductSailPrice(),floor, cart.getId());
//                    tableService.updateCart(floor, afterTableNum, currTableNum);
//                }
//            }
//
//            if (msg.equals("true")) {
//                System.out.println(String.format("%d번 테이블이 %d번 테이블로 이동했습니다.", currTableNum, afterTableNum));
//            }
//
//            if (currTableNum != afterTableNum) {
//                tableService.delBeforeCartItem(currTableNum, floor);
//            }
//
//            return ResultDate.from("S-1", "데이터 전송 성공");
//        }
//
//        return ResultDate.from("S-1", "데이터 전송 실패");
//    }
//
//
//    @RequestMapping("/usr/tableGroup/addTableGroup")
//    @ResponseBody
//    public ResultDate addTableGroup(String color) {
//        tableService.addTableGroup(color);
//        List<TableGroup> tableGroups = tableService.getTableGroups();
//        return ResultDate.from("s-1", "data 보내기 성공", "tableGroups", tableGroups);
//    }
//
//    @RequestMapping("/usr/tableGroup/removeTableGroup")
//    @ResponseBody
//    public ResultDate removeTableGroup(int groupId) {
//        tableService.removeTableGroup(groupId);
//        List<TableGroup> tableGroups = tableService.getTableGroups();
//        if (tableGroups.size() == 0) {
//            tableService.truncateForTableGroups();
//        }
//        return ResultDate.from("s-1", "data 보내기 성공", "tableGroups", tableGroups);
//    }
//
//    @RequestMapping("/usr/tableGroup/update")
//    @ResponseBody
//    public ResultDate update(int groupId) {
//        tableService.updateTableGroup(groupId);
//
//        TableGroup tableGroup = tableService.getTableGroupById(groupId);
//        return ResultDate.from("s-1", "data 보내기 성공", "tableGroup", tableGroup);
//    }
//
//
//    @RequestMapping("/usr/main/salesSummary")
//    public String salesSummary(@RequestParam(defaultValue = "전체") String floor, Model model) {
//        String todayDate = dateFormatter.format(dateNow);
//        List<Integer> payedTotalAmount = tableService.getPayedTotalAmount(floor);
//        List<Integer> payedTotalCnt = tableService.getPayedTotalCnt(floor);
//        List<Integer> payedTotalDiscountAmount = tableService.getPayedTotalDiscountAmount(floor);
//        int outstandingAmount = tableService.getOutstandingAmount();
//        int VAT_Amount = (payedTotalAmount.get(1) / 100) * 11;
//        model.addAttribute("floor", floor);
//        model.addAttribute("todayDate", todayDate);
//        model.addAttribute("payedTotalDiscountAmount", String.valueOf(payedTotalDiscountAmount.get(0) + payedTotalDiscountAmount.get(1)));
//        model.addAttribute("payedTotalAmount", String.valueOf(payedTotalAmount.get(0) + payedTotalAmount.get(1)));
//        model.addAttribute("payedCashSumAmount", String.valueOf(payedTotalAmount.get(0)));
//        model.addAttribute("payedCartSumAmount", String.valueOf(payedTotalAmount.get(1)));
//        model.addAttribute("VAT_Amount", String.valueOf(VAT_Amount));
//        model.addAttribute("outstandingAmount", String.valueOf(outstandingAmount));
//        model.addAttribute("expectedSales", String.valueOf(outstandingAmount + payedTotalAmount.get(0) + payedTotalAmount.get(1)));
//        model.addAttribute("payedCashCnt", payedTotalCnt.get(0));
//        model.addAttribute("payedCartCnt", payedTotalCnt.get(1));
//        return "/usr/home/salesSummary";
//    }
////    ============ Order Page Functions ============= //
//
//
//    @RequestMapping("/usr/tables/detail")
//    public String Detail(String tabId, @RequestParam(defaultValue = "1") int floor, Model model) {
//        int tabNum = Integer.parseInt(tabId);
//
//        if (floor <= 0 || floor > 3) {
//            return rq.jsReturnOnView("갯층 값이 잘 못 입력하였습니다.");
//        }
//
//
//        List<ProductType> productTypes = tableService.getProductTypes();
//        List<Product> products = tableService.getProductList();
//        List<CartItems> cartItemsList = tableService.getCartItemsList(tabNum, floor);
//        int discountSumAMount = tableService.getDiscountSumAmount(tabNum, floor);
//
//        model.addAttribute("tabId", tabId);
//        model.addAttribute("floor", floor);
//        model.addAttribute("discountSumAMount", discountSumAMount);
//        model.addAttribute("productTypes", productTypes);
//        model.addAttribute("cartItemsList", cartItemsList);
//        model.addAttribute("products", products);
//        return "/usr/table/detail";
//    }
//
//
//    @RequestMapping("/usr/tables/insertProduct")
//    @ResponseBody
//    public String insertProduct(String productIds, String productCnts,
//                                String productSailPrices, String productPrices, String productNames, String delProductIds,
//                                @RequestParam(defaultValue = "1") int floor, int tabId, String isPrintControl) {
//
//        if (floor <= 0 || floor > 3) {
//            return Util.jsHistoryBack("갯층 값이 잘 못 입력하였습니다.");
//        }
//
//        if (delProductIds.length() != 0) {
//            List<Integer> delProductList = new ArrayList<>();
//            for (String ids : delProductIds.split(",")) {
//                delProductList.add(Integer.parseInt(ids));
//            }
//
//            for (int i = 0; i < delProductList.size(); i++) {
//                CartItems cancelProduct = tableService.getCartItem(delProductList.get(i), tabId, floor);
//                tableService.cancelProduct(delProductList.get(i), tabId, floor);
//                if (isPrintControl.equals("true")) {
//                    System.out.println("     [주문서]     ");
//                    System.out.println(String.format("[%d층]  %d번", floor, tabId));
//                    System.out.println(String.format("%s   " + "    -%d취소", cancelProduct.getProductName(), cancelProduct.getQuantity()));
//                    System.out.println("        " + now.format(formatter));
//                    System.out.println("고객수 :   0");
//                    System.out.println("주문번호 :   0");
//                    System.out.println("===========================");
//                }
//            }
//        }
//
//
//        if (productIds.length() != 0) {
//
//            List<Integer> productIdList = new ArrayList<>();
//            for (String ids : productIds.split(",")) {
//                productIdList.add(Integer.parseInt(ids));
//            }
//
//            List<Integer> productCntList = new ArrayList<>();
//            for (String cnt : productCnts.split(",")) {
//                productCntList.add(Integer.parseInt(cnt));
//            }
//
//            List<Integer> productSailPriceList = new ArrayList<>();
//            for (String cnt : productSailPrices.split(",")) {
//                productSailPriceList.add(Integer.parseInt(cnt));
//            }
//
//            List<Integer> productPricesList = new ArrayList<>();
//            for (String cnt : productPrices.split(",")) {
//                productPricesList.add(Integer.parseInt(cnt));
//            }
//
//            List<String> productNamesList = new ArrayList<>();
//            for (String cnt : productNames.split(",")) {
//                productNamesList.add(cnt);
//            }
//
//            Cart cart;
//
//            cart = tableService.getCart(floor, tabId);
//
//            if (cart == null) {
//                tableService.createCart(floor, tabId);
//                cart = tableService.getCart(floor, tabId);
//            }
//
//            for (int i = 0; i < productIdList.size(); i++) {
//                CartItems cartItem = tableService.getCartItem(productIdList.get(i), tabId, floor);
//                if (cartItem == null) {
//                    tableService.insertCartItems(productIdList.get(i), productCntList.get(i),
//                            productSailPriceList.get(i), productPricesList.get(i), productNamesList.get(i), tabId, floor, cart.getId());
//                    if (isPrintControl.equals("true")) {
//                        Product orderProduct = tableService.getProductName(productIdList.get(i));
//                        System.out.println("     [주문서]     ");
//                        System.out.println(String.format("[%d층]  %d번", floor, tabId));
//                        System.out.println(String.format("%s   " + "    %d", orderProduct.getName(), productCntList.get(i)));
//                        System.out.println("        " + now.format(formatter));
//                        System.out.println("고객수 :   0");
//                        System.out.println("주문번호 :   0");
//                        System.out.println("===========================");
//                    }
//                } else {
//                    if (cartItem.getQuantity() != productCntList.get(i) || cartItem.getProductSailPrice() != productSailPriceList.get(i)) {
//                        tableService.updateCartItems(productIdList.get(i), productCntList.get(i), productSailPriceList.get(i),
//                                productPricesList.get(i), productNamesList.get(i), tabId, floor);
//                        if (isPrintControl.equals("true")) {
//                            System.out.println("     [주문서]     ");
//                            System.out.println(String.format("[%d층]  %d번", floor, tabId));
//                            System.out.println(String.format("%s   " + "    %d", productNamesList.get(i),
//                                    productSailPriceList.get(i) == 0 ? (productCntList.get(i) - cartItem.getQuantity()) : productCntList.get(i)));
//                            System.out.println("        " + now.format(formatter));
//                            System.out.println("고객수 :   0");
//                            System.out.println("주문번호 :   0");
//                            System.out.println("===========================");
//                        }
//                    }
//                }
//            }
//        }
//
//        return Util.jsReplace("/?floor=" + floor);
//    }
//
//    @RequestMapping("/usr/tables/getProduct")
//    @ResponseBody
//    public ResultDate getProduct(int id, int tabId, int floor) {
//
//        if (floor <= 0 || floor > 3) {
//            return ResultDate.from("F-1", "갯층 값이 잘 못 입력하였습니다.");
//        }
//
//        Product product = tableService.getProductById(id);
//        return ResultDate.from("s-1", "data 보내기 성공", "product", product);
//    }
//
//
//    @RequestMapping("/usr/tables/getCartItemSumPrice")
//    @ResponseBody
//    public ResultDate getCartItemSize(int tabId, int floor) {
//
//        if (floor <= 0 || floor > 3) {
//            return ResultDate.from("F-1", "갯층 값이 잘 못 입력하였습니다.");
//        }
//
//        int totalSumPrice = tableService.getTotalSumPrice(tabId, floor);
//        return ResultDate.from("s-1", "data 보내기 성공", "totalSumPrice", totalSumPrice);
//    }
//
//    @RequestMapping("/usr/tables/getProductTotalSumPriceAndTotalQuantity")
//    @ResponseBody
//    public ResultDate getProductTotalSumPriceAndTotalQuantity(int tabId, int floor) {
//        int totalQuantity = tableService.getTotalQuantity(tabId, floor);
//        int totalSumPrice = tableService.getTotalSumPrice(tabId, floor);
//        int totalSailPrice = tableService.getTotalSailPrice(tabId, floor);
//        return ResultDate.from("s-1", "data 보내기 성공",
//                "totalQuantity", totalQuantity,
//                "totalSumPrice", totalSumPrice + totalSailPrice,
//                "amountToPay", totalSumPrice - rq.getLeftAmount());
//    }
//
//    @RequestMapping("/usr/tables/orderPage/payByCreditCart")
//    public String payByCreditCart(String AmountToBeReceivedCart, String CartTotalAmount, String CartSplitAmount,
//                                  String CartTotalSailAmount, int floor, int tabId, Model model) {
//        String CreditCartNumber = Util.getCreditCartNumbers();
//        String CreditCartCompany = Util.getCreditCartCompany();
//        String CreditCartValidYear = Util.getCreditCartValidTHRU();
//        String CreditCartValidMonth = Util.getCreditCartValidTHRUMonth();
//
//
//        model.addAttribute("floor", floor);
//        model.addAttribute("tabId", tabId);
//        model.addAttribute("CreditCartNumber", CreditCartNumber);
//        model.addAttribute("CreditCartCompany", CreditCartCompany);
//        model.addAttribute("CreditCartValidYear", CreditCartValidYear);
//        model.addAttribute("CreditCartValidMonth", CreditCartValidMonth);
//        model.addAttribute("amountToBeReceivedCartS", AmountToBeReceivedCart);
//        model.addAttribute("totalAmount", CartTotalAmount);
//        model.addAttribute("splitAmount", CartSplitAmount);
//        model.addAttribute("cartTotalSailAmount", CartTotalSailAmount);
//        return "/usr/table/payByCreditCart";
//    }
//
//    @RequestMapping("/usr/tables/orderPage/payByCash")
//    public String payByCash(String AmountToBeReceivedCash, String CashTotalAmount, String CashSplitAmount,
//                            String CashTotalSailAmount, int floor, int tabId, Model model) {
//
//
//        model.addAttribute("floor", floor);
//        model.addAttribute("tabId", tabId);
//        model.addAttribute("amountToBeReceivedCash", AmountToBeReceivedCash);
//        model.addAttribute("totalAmount", CashTotalAmount);
//        model.addAttribute("splitAmount", CashSplitAmount);
//        model.addAttribute("cashTotalSailAmount", CashTotalSailAmount);
//        return "/usr/table/payByCash";
//    }
//
//
//    //    ======= Payment =============
//    @RequestMapping("/usr/tables/orderPage/paymentCash")
//    @ResponseBody
//    public ResultDate paymentCash(int floor, int tabId, int totalAmount, int splitAmount,
//                                  int cashTotalSailAmount, int amountToBeReceivedCartS, String isPrintReceipt, @RequestParam(defaultValue = "0") String authorizedNumber) {
//
//        Cart cart = tableService.getCart(floor, tabId);
//
//        if (splitAmount == 0 || splitAmount == amountToBeReceivedCartS) {
//            tableService.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart.getId());
//            tableService.removePaidCartItem(floor, tabId);
//            tableService.removeCart(floor, tabId);
//            rq.leftAmount(0);
//            return ResultDate.from("S-1", String.format("/?floor=%d", floor));
//        } else {
//            tableService.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart.getId());
//            rq.leftAmount(rq.getLeftAmount() + splitAmount);
//            return ResultDate.from("S-1", String.format("/usr/tables/detail?tabId=%d&floor=%d", tabId, floor));
//        }
//    }
//
//    @RequestMapping("/usr/tables/orderPage/paymentCreditCart")
//    @ResponseBody
//    public ResultDate paymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount,
//                                        String CreditCartNumber, int cartTotalSailAmount, int amountToBeReceivedCartS, String isPrintReceipt) {
//
//        Cart cart = tableService.getCart(floor, tabId);
//
//        if (splitAmount == 0 || splitAmount == amountToBeReceivedCartS) {
//            tableService.insertPaymentCreditCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, CreditCartNumber, cart.getId());
//            tableService.removePaidCartItem(floor, tabId);
//            tableService.removeCart(floor, tabId);
//            rq.leftAmount(0);
//            return ResultDate.from("S-1", String.format("/?floor=%d", floor));
//        } else {
//            tableService.insertPaymentCreditCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, CreditCartNumber, cart.getId());
//            rq.leftAmount(rq.getLeftAmount() + splitAmount);
//            return ResultDate.from("S-1", String.format("/usr/tables/detail?tabId=%d&floor=%d", tabId, floor));
//        }
//    }
//
//    @RequestMapping("/usr/tables/getProductSummary")
//    @ResponseBody
//    public ResultDate getProductSummary(int floor, int tabId) {
//        List<CartItems> cartItems = tableService.getCartItemsList(tabId, floor);
//        if (cartItems.size() != 0) {
//            return ResultDate.from("S-1", "성공", "cartItems", cartItems);
//        } else {
//            return ResultDate.from("F-1", "실패");
//        }
//    }
//
//}
//
//
//
