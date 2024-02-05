package com.example.easypos.Services;

import com.example.easypos.DAO.PayDao;
import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.paymentCreditCartAndCash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PayService {
    private PayDao payDao;

    @Autowired
    public PayService(PayDao payDao) {
        this.payDao = payDao;
    }

    public Cart getCart(int floor, int tabId) {
        return payDao.getCart(floor, tabId);
    }

    public void insertPaymentCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cart_id) {
        payDao.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart_id);
    }

    public void removePaidCartItem(int floor, int tabId) {
        payDao.removePaidCartItem(floor, tabId);
    }

    public void removeCart(int floor, int tabId) {
        payDao.removeCart(floor, tabId);
    }

    // ==================================================================//

    public void insertPaymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String payByCreditCartNumber, int cart_id) {
        payDao.insertPaymentCreditCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, payByCreditCartNumber, cart_id);
    }

    public int createCart(int floor, int tabId) {
        return payDao.createCart(floor, tabId);
    }

    public List<CartItems> getIsExistCartItem(int floor, int tabId) {
        return payDao.getIsExistCartItem(floor, tabId);
    }

    public List<CartItems> getPaidCartItem(int tabId, int floor, int cartId) {
        return payDao.getPaidCartItem(tabId, floor, cartId);
    }

    public void insertPaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber, int cart_id) {
        payDao.insertPaymentCartAndCashForCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, creditCartNumber, cart_id);
    }

    public paymentCreditCartAndCash getExistPaymentCartAndCashItem(int cart_id) {
        return payDao.getExistPaymentCartAndCashItem(cart_id);
    }

    public void updatePaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber, int cart_id) {
        payDao.updatePaymentCartAndCashForCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, creditCartNumber, cart_id);
    }

    public void insertPaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cart_id) {
        payDao.insertPaymentCartAndCashForCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart_id);
    }

    public void updatePaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int amountToBeReceivedCartS, int cashTotalSailAmount, int cart_id) {
        payDao.updatePaymentCartAndCashForCash(floor, tabId, totalAmount, amountToBeReceivedCartS, cashTotalSailAmount, cart_id);
    }

    // ==================================================================//


}
