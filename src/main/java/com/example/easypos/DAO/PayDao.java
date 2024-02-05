package com.example.easypos.DAO;

import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.paymentCreditCartAndCash;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface PayDao {
    @Select("""
            select * from Cart
                       where tabId = #{tabId}
                       and floor = #{floor}
            """)
    Cart getCart(int floor, int tabId);

    @Insert("""
            insert into paymentCash
            set regDate = now(),
                updateDate= now(),
                floor = #{floor},
                tabId = #{tabId},
                cashTotalAmount = #{totalAmount},
                cashAmountPaid = #{splitAmount},
                discountAmount = #{cashTotalSailAmount},
                cart_id = #{cart_id}
            """)
    void insertPaymentCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cart_id);

    @Update("""
            update CartItems
                set delDate       = now(),
                    delStatus = 1
                where table_id = #{tabId}
                  and floor_id = #{floor}
            """)
    void removePaidCartItem(int floor, int tabId);

    @Delete("""
            delete from Cart
            where tabId = #{tabId}
            and floor = #{floor}
            """)
    void removeCart(int floor, int tabId);

    // ==================================================================//

    @Insert("""
            insert into paymentCreditCart
            set regDate = now(),
                updateDate= now(),
                floor = #{floor},
                tabId = #{tabId},
                cartTotalAmount = #{totalAmount},
                cartAmountPaid = #{splitAmount},
                discountAmount = #{cartTotalSailAmount},
                payByCreditCartNumber = #{payByCreditCartNumber},
                cart_id = #{cart_id}
            """)
    void insertPaymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String payByCreditCartNumber, int cart_id);

    @Insert("""
             insert into Cart (regDate, updateDate, tabId, floor)
                values (now(), now(), #{tabId} , #{floor});
            """)
    int createCart(int floor, int tabId);

    @Select("""
            select * from CartItems
                where floor_id = #{floor}
                and table_id = #{tabId}
                and delStatus = 0;
            """)
    List<CartItems> getIsExistCartItem(int floor, int tabId);

    @Select("""
            select * from CartItems
            where cart_id = #{cartId}
            and table_id = #{tabId}
            and floor_id = #{floor};
            """)
    List<CartItems> getPaidCartItem(int tabId, int floor, int cartId);

    @Insert("""
            insert into paymentCreditCartAndCash
            set regDate = now(),
                updateDate = now(),
                tabId = #{tabId},
                floor = #{floor},
                totalAmount = #{totalAmount},
                CartAmountPaid = #{splitAmount},
                CashAmountPaid = 0,
                discountAmount = #{cartTotalSailAmount},
                payByCreditCartNumber = #{creditCartNumber},
                cart_id = #{cartId}
            """)
    void insertPaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber, int cartId);

    @Select("""
            select * from paymentCreditCartAndCash
            where cart_id = #{cartId};
            """)
    paymentCreditCartAndCash getExistPaymentCartAndCashItem(int cartId);

    @Update("""
            update paymentCreditCartAndCash
            set updateDate = now(),
                CartAmountPaid = CartAmountPaid + #{splitAmount}
            where cart_id = #{cartId}
            and tabId = #{tabId}
            and floor = #{floor}
            """)
    void updatePaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber, int cartId);

    @Insert("""
            insert into paymentCreditCartAndCash
            set regDate = now(),
                updateDate = now(),
                tabId = #{tabId},
                floor = #{floor},
                totalAmount = #{totalAmount},
                CartAmountPaid = 0,
                CashAmountPaid = #{splitAmount},
                discountAmount = #{cashTotalSailAmount},
                payByCreditCartNumber = '0',
                cart_id = #{cartId}
            """)
    void insertPaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cartId);

    @Update("""
            update paymentCreditCartAndCash
                set updateDate = now(),
                    CashAmountPaid = CashAmountPaid + #{amountToBeReceivedCartS}
                where cart_id = #{cartId}
                and tabId = #{tabId}
                and floor = #{floor}
            """)
    void updatePaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int amountToBeReceivedCartS, int cashTotalSailAmount, int cartId);
}
