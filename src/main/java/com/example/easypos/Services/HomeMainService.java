package com.example.easypos.Services;

import com.example.easypos.DAO.HomeMainDao;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.paymentCreditCartAndCash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class HomeMainService {
    private HomeMainDao homeMainDao;

    @Autowired
    public HomeMainService(HomeMainDao homeMainDao) {
        this.homeMainDao = homeMainDao;
    }

    public List<paymentCreditCartAndCash> getPaymentCartAndCashList(String beginDate, String endDate, String floor) {
        return homeMainDao.getPaymentCartAndCashList(beginDate, endDate, floor);
    }

    public List<CartItems> getCartItemsByCart_id(int cartId) {
        return homeMainDao.getCartItemsByCart_id(cartId);
    }


    public void returnPaymentCartAndCash(int cartId) {
        homeMainDao.returnPaymentCartAndCash(cartId);
    }

    public void insertReturnPayment(int cartId) {
        homeMainDao.insertReturnPayment(cartId);
    }

    public void cancelReturnPaymentCart(int cartId) {
        homeMainDao.cancelReturnPaymentCart(cartId);
    }

    public void cancelReturnPaymentCash(int cartId) {
        homeMainDao.cancelReturnPaymentCash(cartId);
    }
}
