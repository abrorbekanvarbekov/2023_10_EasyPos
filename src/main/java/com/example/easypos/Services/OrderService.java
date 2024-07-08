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

    public int getProductCnt(String productTypeCode) {
        return orderDao.getProductCnt(productTypeCode);
    }

    public List<Product> getProductList(String productTypeCode, String productTypeName, int limitFrom, int proItemInPage) {
        return orderDao.getProductList(productTypeCode, productTypeName, limitFrom, proItemInPage);
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

    public void insertCartItems(int productId, int productCnt, int productSailPrice, int productPrices,
                                String productName, int tabId, int floor, int cart_id, String openingDate) {
        orderDao.insertCartItems(productId, productCnt, productSailPrice, productPrices, productName, tabId, floor, cart_id, openingDate);
    }

    public int updateCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor, String openingDate) {
        return orderDao.updateCartItems(productId, productCnt, productSailPrice, productPrices, productName, tabId, floor, openingDate);
    }

    // ==============================================================//

    public Product getProductById(int id) {
        return orderDao.getProductById(id);
    }

    // ==============================================================//

    public void removeCart(int tabId, int floor) {
        orderDao.removeCart(tabId, floor);
    }

    public List<paymentCash> getPaymentCashList(int tabNum, int floor, int cart_id, String openingDate) {
        return orderDao.getPaymentCashList(tabNum, floor, cart_id, openingDate);
    }

    public List<paymentCreditCard> getPaymentCartList(int tabNum, int floor, int cart_id, String openingDate) {
        return orderDao.getPaymentCartList(tabNum, floor, cart_id, openingDate);
    }


    // ==============================================================//


}