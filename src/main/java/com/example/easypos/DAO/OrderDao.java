package com.example.easypos.DAO;

import com.example.easypos.Vo.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderDao {

    @Select("""
            select * from productType
            order by sequenceNum
            """)
    List<ProductType> getProductTypesCnt();

    @Select("""
            select * from productType
            order by sequenceNum
            limit #{limit}, #{proTypeNumIPage}
            """)
    List<ProductType> getProductTypes(int limit, int proTypeNumIPage);

    @Select("""
            select count(*) from `${productTypeCode}`
             """)
    int getProductCnt(String productTypeCode);

    @Select("""
            select p.id, p.price, p.productKorName, i.color 
            from `${productTypeCode}` as i
                     inner join product as p
                     on i.productCode = p.productCode
                where `code` = #{productTypeCode}
                order by i.sequenceNum
                limit #{limitFrom}, #{proItemInPage}
            """)
    List<Product> getProductList(String productTypeCode, String productTypeName, int limitFrom, int proItemInPage);

    @Select("""
            select p.id, c.*
                from product as p
                         inner join CartItems as c
                                    on p.id = c.product_id
                where c.table_id = #{tableId}
                  and c.floor_id = #{floor}
                  and c.delStatus = 0
                  and openingDate = #{openingDate}
                order by regDate
            """)
    List<CartItems> getCartItemsList(int tableId, int floor, String openingDate);

    // ==============================================================//

    @Select("""
            select * from CartItems
            where product_id = #{productId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            and productName = #{productName}
            and delStatus = 0
            and openingDate = #{openingDate}
            limit 1
            """)
    CartItems getCartItem(int productId, String productName, int tabId, int floor, String openingDate);

    @Delete("""
            delete from CartItems
            where product_id = #{productId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            and productName = #{productName}
            and delStatus = 0
            limit 1
            """)
    void cancelProduct(int productId, String productName, int tabId, int floor);

    @Select("""
            select * from Cart
                where tabId = #{tabId}
                and floor = #{floor}
                and openingDate = #{openingDate}
            """)
    Cart getCart(int floor, int tabId, String openingDate);

    @Insert("""
            insert into Cart (regDate, updateDate, tabId, floor, openingDate)
                values (now(), now(), #{tabId} , #{floor}, #{openingDate});
            """)
    void createCart(int floor, int tabId, String openingDate);

    @Insert("""
            insert into CartItems(
                    regDate,
                    updateDate,
                    openingDate,
                    product_id,
                    productName,
                    table_id,
                    quantity,
                    productPrice,
                    productSumPrice,
                    productSailPrice,
                    floor_id,
                    cart_id )
                select now(), now(), #{openingDate}, #{productId}, #{productName}, #{tabId}, #{productCnt}, p.price, #{productPrices}, #{productSailPrice}, #{floor}, #{cart_id}
                from product as p
                where p.id = #{productId}
            """)
    void insertCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName,
                         int tabId, int floor, int cart_id, String openingDate);


    @Update("""
            update CartItems
                 set updateDate = now(),
                     quantity = #{productCnt},
                     productSailPrice = #{productSailPrice},
                     productSumPrice = #{productPrices},
                     productName = #{productName}
                 where table_id = #{tabId}
                 and product_id = #{productId}
                 and floor_id = #{floor}
                 and delStatus = 0
                 and openingDate = #{openingDate}
            """)
    int updateCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor, String openingDate);

    // ==============================================================//

    @Select("""
            select * from product
            where id = #{id}
            """)
    Product getProductById(int id);

    // ==============================================================//

    @Delete("""
            delete from Cart
            where tabId = #{tabId}
            and floor = #{floor}
            """)
    void removeCart(int tabId, int floor);

    @Select("""
            select * from paymentCash
                where cart_id = #{cartId}
                and tabId = #{tabNum}
                and floor = #{floor}
                and openingDate = #{openingDate};
            """)
    List<paymentCash> getPaymentCashList(int tabNum, int floor, int cartId, String openingDate);

    @Select("""
            select cardAmountPaid from paymentCreditCard
                where cart_id = #{cartId}
                and tabId = #{tabNum}
                and floor = #{floor}
                and openingDate = #{openingDate};
            """)
    List<paymentCreditCard> getPaymentCartList(int tabNum, int floor, int cartId, String openingDate);


}