package com.example.easypos.Services;

import com.example.easypos.DAO.HomeMainDao;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.deadlineSettlement;
import com.example.easypos.Vo.paymentCreditCartAndCash;
import com.example.easypos.VoBasicInformation.productBigClassification;
import com.example.easypos.VoBasicInformation.productMiddleClassification;
import com.example.easypos.VoBasicInformation.productSmallClassification;
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

    public List<Integer> getPayedTotalAmount(String floor, String beginDate, String endDate) {
        return homeMainDao.getPayedTotalAmount(floor, beginDate, endDate);
    }

    public List<Integer> getPayedTotalCnt(String floor, String beginDate, String endDate) {
        return homeMainDao.getPayedTotalCnt(floor, beginDate, endDate);
    }

    public List<Integer> getPayedTotalDiscountAmount(String floor, String beginDate, String endDate) {
        return homeMainDao.getPayedTotalDiscountAmount(floor, beginDate, endDate);
    }

    public int getOutstandingAmount(String floor, String beginDate, String endDate) {
        return homeMainDao.getOutstandingAmount(floor, beginDate, endDate);
    }

    public List<Integer> getNumberOfReturns(String floor, String beginDate, String endDate) {
        return homeMainDao.getNumberOfReturns(floor, beginDate, endDate);
    }

    public List<Integer> getAmountOfReturns(String floor, String beginDate, String endDate) {
        return homeMainDao.getAmountOfReturns(floor, beginDate, endDate);
    }

    public int getOutstandingTables(String floor) {
        return homeMainDao.getOutstandingTables(floor);
    }

    public void insertDeadlineSettlement(String businessDate, String openingDate, String employeeName, String employeeCode, int totalSales, int totalSalesCount,
                                         int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCart) {
        homeMainDao.insertDeadlineSettlement(businessDate, openingDate, employeeName, employeeCode, totalSales, totalSalesCount,
                discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCart);
    }

    public deadlineSettlement getDeadlineSettlement(String businessDate) {
        return homeMainDao.getDeadlineSettlement(businessDate);
    }

    public void updateDeadlineSettlement(String businessDate, String openingDate, String employeeName, String employeeCode, int totalSales, int totalSalesCount,
                                         int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCart) {
        homeMainDao.updateDeadlineSettlement(businessDate, openingDate, employeeName, employeeCode, totalSales, totalSalesCount,
                discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCart);
    }

}
