package com.example.easypos.Services;

import com.example.easypos.DAO.OrderDao;
import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.Product;
import com.example.easypos.Vo.ProductType;
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

    public List<Product> getProductList() {
        return orderDao.getProductList();
    }

    public List<CartItems> getCartItemsList(int tableId, int floor) {
        return orderDao.getCartItemsList(tableId, floor);
    }

    public int getDiscountSumAmount(int tabNum, int floor) {
        return orderDao.getDiscountSumAmount(tabNum, floor);
    }

    // ==============================================================//

    public CartItems getCartItem(int productId, int tabId, int floor) {
        return orderDao.getCartItem(productId, tabId, floor);
    }

    public void cancelProduct(int productId, int tabId, int floor) {
        orderDao.cancelProduct(productId, tabId, floor);
    }

    public Cart getCart(int floor, int tabId) {
        return orderDao.getCart(floor, tabId);
    }

    public void createCart(int floor, int tabId) {
        orderDao.createCart(floor, tabId);
    }

    public void insertCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor, int cart_id) {
        orderDao.insertCartItems(productId, productCnt, productSailPrice, productPrices, productName, tabId, floor, cart_id);
    }

    public Product getProductName(int productId) {
        return orderDao.getProductName(productId);
    }

    public int updateCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor) {
        return orderDao.updateCartItems(productId, productCnt, productSailPrice, productPrices, productName, tabId, floor);
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

    // ==============================================================//


}
