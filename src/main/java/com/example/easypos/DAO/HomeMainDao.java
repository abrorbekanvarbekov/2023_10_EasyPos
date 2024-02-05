package com.example.easypos.DAO;

import com.example.easypos.Vo.CartItems;
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
}
