package com.example.easypos.DAO;

import com.example.easypos.Vo.Cart;
import org.apache.ibatis.annotations.*;

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


}
