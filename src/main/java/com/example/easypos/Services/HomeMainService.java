
package com.example.easypos.Services;

import com.example.easypos.DAO.HomeMainDao;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.deadlineSettlement;
import com.example.easypos.Vo.paymentCreditCardAndCash;
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

    public List<paymentCreditCardAndCash> getPaymentCartAndCashList(String openingDate, String floor) {
        return homeMainDao.getPaymentCartAndCashList(openingDate, floor);
    }

    public List<CartItems> getCartItemsByCart_id(int cartId, String openingDate) {
        return homeMainDao.getCartItemsByCart_id(cartId, openingDate);
    }


    public void returnPaymentCartAndCash(int cartId, String openingDate) {
        homeMainDao.returnPaymentCartAndCash(cartId, openingDate);
    }

    public void insertReturnPayment(int cartId, String openingDate) {
        homeMainDao.insertReturnPayment(cartId, openingDate);
    }

    public void cancelReturnPaymentCart(int cartId, String openingDate) {
        homeMainDao.cancelReturnPaymentCart(cartId, openingDate);
    }

    public void cancelReturnPaymentCash(int cartId, String openingDate) {
        homeMainDao.cancelReturnPaymentCash(cartId, openingDate);
    }


    public List<Integer> getPayedTotalAmount(String floor, String openingDate) {
        return homeMainDao.getPayedTotalAmount(floor, openingDate);
    }

    public List<Integer> getPayedTotalCnt(String floor, String openingDate) {
        return homeMainDao.getPayedTotalCnt(floor, openingDate);
    }

    public List<Integer> getPayedTotalDiscountAmount(String floor, String openingDate) {
        return homeMainDao.getPayedTotalDiscountAmount(floor, openingDate);
    }

    public int getOutstandingAmount(String floor, String openingDate) {
        return homeMainDao.getOutstandingAmount(floor, openingDate);
    }

    public List<Integer> getNumberOfReturns(String floor, String openingDate) {
        return homeMainDao.getNumberOfReturns(floor, openingDate);
    }

    public List<Integer> getAmountOfReturns(String floor, String openingDate) {
        return homeMainDao.getAmountOfReturns(floor, openingDate);
    }

    public int getOutstandingTables(String floor, String openingDate) {
        return homeMainDao.getOutstandingTables(floor, openingDate);
    }

    public void insertDeadlineSettlement(String openingDate, String openEmployeeName, String openEmployeeCode, String closeEmployeeName, String closeEmployeeCode, int totalSales, int totalSalesCount,
                                         int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCart) {
        homeMainDao.insertDeadlineSettlement(openingDate, openEmployeeName, openEmployeeCode, closeEmployeeName, closeEmployeeCode, totalSales, totalSalesCount,
                discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCart);
    }

    public deadlineSettlement getDeadlineSettlement(String openingDate) {
        return homeMainDao.getDeadlineSettlement(openingDate);
    }

    public void updateDeadlineSettlement(String openingDate, String openEmployeeName, String openEmployeeCode, String closeEmployeeName, String closeEmployeeCode, int totalSales, int totalSalesCount,
                                         int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCart) {
        homeMainDao.updateDeadlineSettlement(openingDate, openEmployeeName, openEmployeeCode, closeEmployeeName, closeEmployeeCode, totalSales, totalSalesCount,
                discountAmount, VAT, NETSales, amountOfReturns, paidByCash, paidByCart);
    }

    public void removeLeftCartItem(String businessDate) {
        homeMainDao.removeLeftCartItem(businessDate);
    }

    public void removeLeftCart(String businessDate) {
        homeMainDao.removeLeftCart(businessDate);
    }
}
