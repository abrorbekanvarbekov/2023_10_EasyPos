package com.example.easypos.DAO;

import com.example.easypos.Vo.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderDao {
    @Select("""
            select * from productType
            """)
    List<ProductType> getProductTypes();

    @Select("""
            select p.* from `${productTypeCode}` as i
                     inner join product as p
                     on i.productCode = p.productCode
                where `code` = #{productTypeCode}
            """)
    List<Product> getProductList(String productTypeCode, String productTypeName);

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

    @Select("""
            select ifnull(sum(CartItems.productSailPrice), 0) from CartItems
                 where delStatus = 0
                   and table_id = #{tabNum}
                   and CartItems.floor_id = #{floor}
            """)
    int getDiscountSumAmount(int tabNum, int floor);

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
    void insertCartItems(String businessDate, int productId, int productCnt, int productSailPrice, int productPrices, String productName,
                         int tabId, int floor, int cart_id, String openingDate);

    @Select("""
            select * from product
                 where id = #{productId} 
            """)
    Product getProductName(int productId);

    @Update("""
            update CartItems
                 set updateDate = concat(#{businessDate}, curtime()),
                     quantity = #{productCnt},
                     productSailPrice = #{productSailPrice},
                     productSumPrice = #{productPrices},
                     productName = #{productName}
                 where table_id = #{tabId}
                 and product_id = #{productId}
                 and floor_id = #{floor}
                 and delStatus = 0
            """)
    int updateCartItems(String businessDate, int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor);

    // ==============================================================//

    @Select("""
            select * from product
            where id = #{id}
            """)
    Product getProductById(int id);

    // ==============================================================//

    @Select("""
            select ifnull(sum(c.productSumPrice), 0) as sumPrice
                from CartItems as c
                where c.floor_id = #{floor}
                  and c.table_id = #{tabId}
                  and c.delStatus = 0          
            """)
    int getTotalSumPrice(int tabId, int floor);

    @Select("""
              select count(*) from CartItems
                where table_id = #{tabId}
                and floor_id = #{floor}
                and delStatus = 0
            """)
    int getTotalQuantity(int tabId, int floor);

    @Select("""
            select ifnull(sum(c.productSailPrice), 0) as sumSailPrice
                from CartItems as c
                where c.floor_id = #{floor}
                  and c.table_id = #{tabId}
                  and c.delStatus = 0  
            """)
    int getTotalSailPrice(int tabId, int floor);

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
            and floor = #{floor};
            """)
    List<paymentCash> getPaymentCashList(int tabNum, int floor, int cartId);

    @Select("""
            select cartAmountPaid from paymentCreditCart
            where cart_id = #{cartId}
            and tabId = #{tabNum}
            and floor = #{floor};
            """)
    List<paymentCreditCart> getPaymentCartList(int tabNum, int floor, int cartId);
}
