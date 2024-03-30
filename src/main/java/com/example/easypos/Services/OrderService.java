package com.example.easypos.Services;

import com.example.easypos.DAO.OrderDao;
import com.example.easypos.Vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    private OrderDao orderDao;

    @Autowired
    public OrderService(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    public List<ProductType> getProductTypes() {
        return orderDao.getProductTypes();
    }

    public List<Product> getProductList(String productTypeCode, String productTypeName) {
        return orderDao.getProductList(productTypeCode, productTypeName);
    }

    public List<CartItems> getCartItemsList(int tableId, int floor, String openingDate) {
        return orderDao.getCartItemsList(tableId, floor, openingDate);
    }

    // ==============================================================//

    public CartItems getCartItem(int productId, String productName, int tabId, int floor, String openingDate) {
        return orderDao.getCartItem(productId, productName, tabId, floor, openingDate);
    }

    public void cancelProduct(int productId, String productName, int tabId, int floor) {
        orderDao.cancelProduct(productId, productName, tabId, floor);
    }

    public Cart getCart(int floor, int tabId, String openingDate) {
        return orderDao.getCart(floor, tabId, openingDate);
    }

    public void createCart(int floor, int tabId, String openingDate) {
        orderDao.createCart(floor, tabId, openingDate);
    }

    public void insertCartItems(String businessDate, int productId, int productCnt, int productSailPrice, int productPrices,
                                String productName, int tabId, int floor, int cart_id, String openingDate) {
        orderDao.insertCartItems(businessDate, productId, productCnt, productSailPrice, productPrices, productName, tabId, floor, cart_id, openingDate);
    }

    public int updateCartItems(String businessDate, int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor) {
        return orderDao.updateCartItems(businessDate, productId, productCnt, productSailPrice, productPrices, productName, tabId, floor);
    }

    // ==============================================================//

    public Product getProductById(int id) {
        return orderDao.getProductById(id);
    }

    // ==============================================================//

    public int getTotalSumPrice(int tabId, int floor) {
        return orderDao.getTotalSumPrice(tabId, floor);
    }

    public int getTotalQuantity(int tabId, int floor) {
        return orderDao.getTotalQuantity(tabId, floor);
    }

    public int getTotalSailPrice(int tabId, int floor) {
        return orderDao.getTotalSailPrice(tabId, floor);
    }

    public void removeCart(int tabId, int floor) {
        orderDao.removeCart(tabId, floor);
    }

    public List<paymentCash> getPaymentCashList(int tabNum, int floor, int cart_id) {
        return orderDao.getPaymentCashList(tabNum, floor, cart_id);
    }

    public List<paymentCreditCart> getPaymentCartList(int tabNum, int floor, int cart_id) {
        return orderDao.getPaymentCartList(tabNum, floor, cart_id);
    }


    // ==============================================================//


}
