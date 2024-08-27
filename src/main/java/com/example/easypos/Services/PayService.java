package com.example.easypos.Services;

import com.example.easypos.DAO.PayDao;
import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.paymentCreditCardAndCash;
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

    public void insertPaymentCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cart_id, String openingDate) {
        payDao.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart_id, openingDate);
    }

    public void removePaidCartItem(int floor, int tabId, String openingDate) {
        payDao.removePaidCartItem(floor, tabId, openingDate);
    }

    public void removeCart(int floor, int tabId, String openingDate) {
        payDao.removeCart(floor, tabId, openingDate);
    }

    // ==================================================================//

    public void insertPaymentCreditCard(int floor, int tabId, int totalAmount, int splitAmount, int cardTotalSailAmount,
                                        String payByCreditCardNumber, int cart_id, String openingDate) {
        payDao.insertPaymentCreditCard(floor, tabId, totalAmount, splitAmount, cardTotalSailAmount, payByCreditCardNumber, cart_id, openingDate);
    }

    public int createCart(int floor, int tabId) {
        return payDao.createCart(floor, tabId);
    }

    public List<CartItems> getIsExistCartItem(int floor, int tabId, String openingDate) {
        return payDao.getIsExistCartItem(floor, tabId, openingDate);
    }

    public List<CartItems> getPaidCartItem(int tabId, int floor, int cartId, String openingDate) {
        return payDao.getPaidCartItem(tabId, floor, cartId, openingDate);
    }

    public void insertPaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber,
                                                int cart_id, String openingDate) {
        payDao.insertPaymentCardAndCashForCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, creditCartNumber, cart_id, openingDate);
    }

    public paymentCreditCardAndCash getExistPaymentCardAndCashItem(int cart_id, String openingDate) {
        return payDao.getExistPaymentCardAndCashItem(cart_id, openingDate);
    }

    public void updatePaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber,
                                                int cart_id, String openingDate) {
        payDao.updatePaymentCardAndCashForCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, creditCartNumber, cart_id, openingDate);
    }

    public void insertPaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cart_id, String openingDate) {
        payDao.insertPaymentCardAndCashForCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart_id, openingDate);
    }

    public void updatePaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int amountToBeReceivedCartS, int cashTotalSailAmount, int cart_id, String openingDate) {
        payDao.updatePaymentCartAndCashForCash(floor, tabId, totalAmount, amountToBeReceivedCartS, cashTotalSailAmount, cart_id, openingDate);
    }

    // ==================================================================//


}
