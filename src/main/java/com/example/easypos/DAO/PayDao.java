package com.example.easypos.DAO;

import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.paymentCreditCardAndCash;
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
                openingDate= #{openingDate},
                floor = #{floor},
                tabId = #{tabId},
                cashTotalAmount = #{totalAmount},
                cashAmountPaid = #{splitAmount},
                discountAmount = #{cashTotalSailAmount},
                cart_id = #{cart_id}
            """)
    void insertPaymentCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cart_id, String openingDate);

    @Update("""
            update CartItems
                set delDate       = now(),
                    delStatus = 1
                where table_id = #{tabId}
                  and floor_id = #{floor}
                  and openingDate = #{openingDate};
            """)
    void removePaidCartItem(int floor, int tabId, String openingDate);

    @Delete("""
            delete from Cart
            where tabId = #{tabId}
            and floor = #{floor}
            and openingDate = #{openingDate}
            """)
    void removeCart(int floor, int tabId, String openingDate);

    // ==================================================================//

    @Insert("""
            insert into paymentCreditCard
            set regDate = now(),
                updateDate= now(),
                openingDate= #{openingDate},
                floor = #{floor},
                tabId = #{tabId},
                cartTotalAmount = #{totalAmount},
                cartAmountPaid = #{splitAmount},
                discountAmount = #{cartTotalSailAmount},
                payByCreditCartNumber = #{payByCreditCartNumber},
                cart_id = #{cart_id}
            """)
    void insertPaymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String payByCreditCartNumber,
                                 int cart_id, String openingDate);

    @Insert("""
             insert into Cart (regDate, updateDate, tabId, floor)
                values (now(), now(), #{tabId} , #{floor});
            """)
    int createCart(int floor, int tabId);

    @Select("""
            select * from CartItems
                where floor_id = #{floor}
                and table_id = #{tabId}
                and delStatus = 0
                and openingDate = #{openingDate};
            """)
    List<CartItems> getIsExistCartItem(int floor, int tabId, String openingDate);

    @Select("""
            select * from CartItems
            where cart_id = #{cartId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            and openingDate = #{openingDate}
            """)
    List<CartItems> getPaidCartItem(int tabId, int floor, int cartId, String openingDate);

    @Insert("""
            insert into paymentCreditCardAndCash
            set regDate = now(),
                updateDate = now(),
                openingDate = #{openingDate},
                tabId = #{tabId},
                floor = #{floor},
                totalAmount = #{totalAmount},
                CartAmountPaid = #{splitAmount},
                CashAmountPaid = 0,
                discountAmount = #{cartTotalSailAmount},
                payByCreditCartNumber = #{creditCartNumber},
                cart_id = #{cartId}
            """)
    void insertPaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber,
                                         int cartId, String openingDate);

    @Select("""
            select * from paymentCreditCardAndCash
                where cart_id = #{cartId}
                and openingDate = #{openingDate};
            """)
    paymentCreditCardAndCash getExistPaymentCartAndCashItem(int cartId, String openingDate);

    @Update("""
            update paymentCreditCardAndCash
                set updateDate = now(),
                    CartAmountPaid = CartAmountPaid + #{splitAmount}
                where cart_id = #{cartId}
                and tabId = #{tabId}
                and floor = #{floor}
                and openingDate = #{openingDate};
            """)
    void updatePaymentCartAndCashForCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber,
                                         int cartId, String openingDate);

    @Insert("""
            insert into paymentCreditCardAndCash
                set regDate = now(),
                    updateDate = now(),
                    openingDate = #{openingDate},
                    tabId = #{tabId},
                    floor = #{floor},
                    totalAmount = #{totalAmount},
                    CartAmountPaid = 0,
                    CashAmountPaid = #{splitAmount},
                    discountAmount = #{cashTotalSailAmount},
                    payByCreditCartNumber = '0',
                    cart_id = #{cartId}
            """)
    void insertPaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cartId, String openingDate);

    @Update("""
            update paymentCreditCardAndCash
                set updateDate = now(),
                    CashAmountPaid = CashAmountPaid + #{amountToBeReceivedCartS}
                where cart_id = #{cartId}
                and tabId = #{tabId}
                and floor = #{floor}
                and openingDate = #{openingDate};
            """)
    void updatePaymentCartAndCashForCash(int floor, int tabId, int totalAmount, int amountToBeReceivedCartS, int cashTotalSailAmount, int cartId, String openingDate);
}
