package com.example.easypos.DAO;

import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.deadlineSettlement;
import com.example.easypos.Vo.paymentCreditCartAndCash;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface HomeMainDao {

    @Select("""
            select tabId, floor, cart_id, CashAmountPaid, CartAmountPaid,totalAmount,regDate,isReturn,discountAmount,
                        ifnull(sum(CashAmountPaid), 0) as sumCashAmountPaid,
                        ifnull(sum(CartAmountPaid), 0) as sumCartAmountPaid
            from paymentCreditCartAndCash
                 WHERE regDate >= #{beginDate}
                   AND regDate <= #{endDate}
                   and floor = #{floor}
                 group by regDate
            """)
    List<paymentCreditCartAndCash> getPaymentCartAndCashList(String beginDate, String endDate, String floor);

    @Select("""
            select cartI.*, pay.CartAmountPaid, pay.CashAmountPaid, pay.totalAmount, pay.discountAmount
                from CartItems as cartI
                         inner join paymentCreditCartAndCash as pay
                                    on cartI.cart_id = pay.cart_id
                where cartI.cart_id = #{cartId}
                group by cartI.productName
            """)
    List<CartItems> getCartItemsByCart_id(int cartId);


    @Update("""
            update paymentCreditCartAndCash
            set isReturn = 2
            where cart_id = #{cartId}
            """)
    int returnPaymentCartAndCash(int cartId);


    @Insert("""
            insert into paymentCreditCartAndCash(regDate, updateDate, tabId, floor, totalAmount, CartAmountPaid, CashAmountPaid,
                                                 discountAmount, payByCreditCartNumber, cart_id, isReturn)
            select now(),
                   updateDate,
                   tabId,
                   floor,
                   totalAmount,
                   CartAmountPaid,
                   CashAmountPaid,
                   discountAmount,
                   payByCreditCartNumber,
                   cart_id,
                   1
            from paymentCreditCartAndCash
            where paymentCreditCartAndCash.cart_id = #{cartId}
            """)
    void insertReturnPayment(int cartId);

    @Delete("""
            delete from paymentCreditCart
            where cart_id = #{cartId}
            """)
    void cancelReturnPaymentCart(int cartId);

    @Delete("""
            delete from paymentCash
            where cart_id = #{cartId}
            """)
    void cancelReturnPaymentCash(int cartId);

    List<Integer> getPayedTotalAmount(String floor, String beginDate, String endDate);

    List<Integer> getPayedTotalCnt(String floor, String beginDate, String endDate);

    List<Integer> getPayedTotalDiscountAmount(String floor, String beginDate, String endDate);

    List<Integer> getNumberOfReturns(String floor, String beginDate, String endDate);

    List<Integer> getAmountOfReturns(String floor, String beginDate, String endDate);

    int getOutstandingAmount(String floor, String beginDate, String endDate);

    @Select("""
            select count(distinct table_id) from CartItems
                where delStatus = 0
                and regDate > #{beginDate}
                and regDate < #{endDate};
            """)
    int getOutstandingTables(String floor, String beginDate, String endDate);

    @Insert("""
            insert into deadlineSettlement
            set openingDate = #{openingDate},
                closingDate = now(),
                openEmployeeName = #{openEmployeeName},
                openEmployeeCode = #{openEmployeeCode},
                closeEmployeeName = #{closeEmployeeName},
                closeEmployeeCode = #{closeEmployeeCode},
                totalSales = #{totalSales},
                totalSalesCount = #{totalSalesCount},
                discountAmount = #{discountAmount},
                VAT = #{VAT},
                NETSales = #{NETSales},
                amountOfReturns = #{amountOfReturns},
                paidByCash = #{paidByCash},
                paidByCart = #{paidByCart}
            """)
    void insertDeadlineSettlement(String openingDate, String openEmployeeName, String openEmployeeCode, String closeEmployeeName,
                                  String closeEmployeeCode, int totalSales, int totalSalesCount,
                                  int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCart);

    @Select("""
            select * from deadlineSettlement
            where openingDate = #{openingDate}
            limit 1
            """)
    deadlineSettlement getDeadlineSettlement(String openingDate);

    @Update("""
            update deadlineSettlement
                set openingDate = #{openingDate},
                    closingDate = now(),
                    openEmployeeName = #{openEmployeeName},
                    openEmployeeCode = #{openEmployeeCode},
                    closeEmployeeName = #{closeEmployeeName},
                    closeEmployeeCode = #{closeEmployeeCode},
                    totalSales = #{totalSales},
                    totalSalesCount = #{totalSalesCount},
                    discountAmount = #{discountAmount},
                    VAT = #{VAT},
                    NETSales = #{NETSales},
                    amountOfReturns = #{amountOfReturns},
                    paidByCash = #{paidByCash},
                    paidByCart = #{paidByCart}
                where openingDate = #{openingDate}
            """)
    void updateDeadlineSettlement(String openingDate, String openEmployeeName, String openEmployeeCode, String closeEmployeeName, String closeEmployeeCode, int totalSales, int totalSalesCount,
                                  int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCart);

    @Update("""
            delete from CartItems
                where openingDate = #{businessDate}
                and delStatus = 0
            """)
    void removeLeftCartItem(String businessDate);

    @Update("""
            delete from Cart
                where openingDate = #{businessDate}
            """)
    void removeLeftCart(String businessDate);
}
