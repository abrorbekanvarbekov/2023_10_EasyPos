package com.example.easypos.Services;

import com.example.easypos.DAO.PayDao;
import com.example.easypos.Vo.Cart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    // ==================================================================//


}
