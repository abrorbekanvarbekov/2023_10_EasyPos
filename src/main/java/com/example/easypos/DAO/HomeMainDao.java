package com.example.easypos.DAO;

import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.deadlineSettlement;
import com.example.easypos.Vo.paymentCreditCardAndCash;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface HomeMainDao {

    @Select("""
            select tabId, floor, cart_id, CashAmountPaid, CartAmountPaid,totalAmount,regDate,isReturn,discountAmount,
                        ifnull(sum(CashAmountPaid), 0) as sumCashAmountPaid,
                        ifnull(sum(CartAmountPaid), 0) as sumCartAmountPaid
            from paymentCreditCardAndCash
                 WHERE floor = #{floor}
                   and openingDate = #{openingDate}
                 group by regDate
            """)
    List<paymentCreditCardAndCash> getPaymentCartAndCashList(String openingDate, String floor);

    @Select("""
            select cartI.*, pay.CartAmountPaid, pay.CashAmountPaid, pay.totalAmount, pay.discountAmount
                from CartItems as cartI
                         inner join paymentCreditCardAndCash as pay
                                    on cartI.cart_id = pay.cart_id
                where cartI.cart_id = #{cartId}
                and cartI.openingDate = #{openingDate}
                group by cartI.productName
            """)
    List<CartItems> getCartItemsByCart_id(int cartId, String openingDate);


    @Update("""
            update paymentCreditCardAndCash
                set isReturn = 2
                    where cart_id = #{cartId}
                    and openingDate = #{openingDate}
            """)
    int returnPaymentCartAndCash(int cartId, String openingDate);


    @Insert("""
            insert into paymentCreditCardAndCash(regDate, updateDate, tabId, floor, totalAmount, CartAmountPaid, CashAmountPaid,
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
            from paymentCreditCardAndCash
                where paymentCreditCardAndCash.cart_id = #{cartId}
                and paymentCreditCardAndCash.openingDate = #{openingDate}
            """)
    void insertReturnPayment(int cartId, String openingDate);

    @Delete("""
            delete from paymentCreditCart
                where cart_id = #{cartId}
                and openingDate = #{openingDate}
            """)
    void cancelReturnPaymentCart(int cartId, String openingDate);

    @Delete("""
            delete from paymentCash
                where cart_id = #{cartId}
                and openingDate = #{openingDate}
            """)
    void cancelReturnPaymentCash(int cartId, String openingDate);

    List<Integer> getPayedTotalAmount(String floor, String openingDate);

    List<Integer> getPayedTotalCnt(String floor, String openingDate);

    List<Integer> getPayedTotalDiscountAmount(String floor, String openingDate);

    List<Integer> getNumberOfReturns(String floor, String openingDate);

    List<Integer> getAmountOfReturns(String floor, String openingDate);

    int getOutstandingAmount(String floor, String openingDate);

    @Select("""
            select count(distinct table_id) from CartItems
                where delStatus = 0
                and openingDate = #{openingDate}
            """)
    int getOutstandingTables(String floor, String openingDate);

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