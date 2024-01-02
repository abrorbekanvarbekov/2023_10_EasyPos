package com.example.easypos.DAO;

import com.example.easypos.Vo.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TableDao {
    @Select("""
            select * from `table`
            where floor = #{floor}
            """)
    List<Table> getTableList(int floor);

    @Update("""
            update `table`
            set updateDate = now(),
                `left` = #{elPosX},
                 top = #{elPosY}
            where number = #{number}
            and floor = #{floor}
            """)
    void updateTablePos(int elPosX, int elPosY, int number, int floor);

    @Select("""
            select * from productType
            """)
    List<ProductType> getProductTypes();

    @Select("""
            select * from product
            where id = #{id}
            """)
    Product getProductById(int id);

    @Select("""
            select * from product
            """)
    List<Product> getProductList();

    @Insert("""
            insert into CartItems(
                    regDate,
                    updateDate,
                    product_id,
                    productName,
                    table_id,
                    quantity,
                    productPrice,
                    productSumPrice,
                    productSailPrice,
                    floor_id,
                    cart_id)
                select now(), now(), #{productId}, #{productName}, #{tabId}, #{productCnt}, p.price, #{productPrices}, #{productSailPrice}, #{floor}, #{cart_id}
                from product as p
                where p.id = #{productId}
            """)
    void insertCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor, int cart_id);

    @Select("""
            select p.id, c.*
                from product as p
                         inner join CartItems as c
                                    on p.id = c.product_id
                where c.table_id = #{tableId}
                  and c.floor_id = #{floor}
                  and c.delStatus = 0
                order by regDate
            """)
    List<CartItems> getCartItemsList(int tableId, int floor);

    @Select("""
            select * from CartItems
            where product_id = #{productId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            and delStatus = 0
            """)
    CartItems getCartItem(int productId, int tabId, int floor);

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
            """)
    int updateCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor);

    @Select("""
            select   c.productName,
                     c.quantity,
                     c.table_id,
                     c.productPrice,
                     c.productSumPrice
              from CartItems as c
              where c.floor_id = #{floor}
                    and c.delStatus = 0;
            """)
    List<CartItems> getCartItems(int floor);

    @Select("""
            select * from product
                 where id = #{productId} 
            """)
    Product getProductName(int productId);

    @Select("""
            select c.*, p.name,
                    sum(c.productSumPrice ) as priceSum
                from CartItems as c
                         inner join product as p
                                    on c.product_id = p.id
                where c.floor_id = #{floor}
                and c.delStatus = 0
                group by c.table_id;
            """)
    List<CartItems> getPriceSumList(int floor);

    @Select("""
              select count(*) from CartItems
                where table_id = #{tabId}
                and floor_id = #{floor}
                and delStatus = 0
            """)
    int getTotalQuantity(int tabId, int floor);

    @Select("""
            select ifnull(sum(c.productSumPrice), 0) as sumPrice
                from CartItems as c
                where c.floor_id = #{floor}
                  and c.table_id = #{tabId}
                  and c.delStatus = 0          
            """)
    int getTotalSumPrice(int tabId, int floor);

    @Select("""
            select ifnull(sum(c.productSailPrice), 0) as sumSailPrice
                from CartItems as c
                where c.floor_id = #{floor}
                  and c.table_id = #{tabId}
                  and c.delStatus = 0  
            """)
    int getTotalSailPrice(int tabId, int floor);

    @Delete("""
            delete from CartItems
            where product_id = #{productId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            """)
    void cancelProduct(int productId, int tabId, int floor);


    @Select("""
            select * from CartItems
            where floor_id = #{floor}
            and table_id = #{currTableNum}
            and delStatus = 0
            """)
    List<CartItems> getCurrCartItem(int currTableNum, int floor);

    @Update("""
            insert into CartItems(
                    regDate,
                    updateDate,
                    product_id,
                    productName,
                    table_id,
                    quantity,
                    productPrice,
                    productSumPrice,
                    productSailPrice,
                    floor_id,
                    cart_id)
                select now(), now(), #{product_id}, #{productName}, #{table_id}, #{quantity}, #{productPrice}, #{productSumPrice}, #{productSailPrice}, #{floor_id}, #{cartId}
                from product as p
                where p.id = #{product_id}
                and delStatus = 0;
            """)
    void toMoveCartItems(int product_id, String productName, int table_id, int quantity, int productPrice, int productSumPrice, int productSailPrice, int floor_id, int cartId);

    @Delete("""
            delete from CartItems
                where table_id = #{currTableNum}
                and floor_id = #{floor}
                and delStatus = 0;
            """)
    void delBeforeCartItem(int currTableNum, int floor);

    @Update("""
            update CartItems as c
                    inner join product as p
                    on c.product_id = p.id
                set c.updateDate = now(),
                    c.quantity   = c.quantity + #{quantity},
                    c.productSailPrice = #{productSailPrice},
                    c.productSumPrice = p.price * (c.quantity + #{quantity}),
                    c.cart_id    = #{cart_id}
                where c.table_id =   #{afterTableNum}
                  and c.product_id = #{productId}
                  and c.floor_id =   #{floor}
                  and c.delStatus = 0;
            """)
    void toMoveUpdateCartItems(int afterTableNum, int floor, int productId, int quantity, int productSailPrice, int productSumPrice, int cart_id);

    @Select("""
            select * from tableGroup
            """)
    List<TableGroup> getTableGroups();

    @Insert("""
            insert into tableGroup
                set regDate    = now(),
                    updateDate =now(),
                    groupNum = 0,
                    tableCnt = 0,
                    color   = #{color}
            """)
    void addTableGroup(String color);

    @Delete("""
            delete from tableGroup
            where id = #{groupId}
            """)
    void removeTableGroup(int groupId);

    @Select("""
            truncate tableGroup;
            """)
    void truncateForTableGroups();

    @Update("""
            update tableGroup
            set updateDate = now(),
                tableCnt = tableCnt + 1
            where id = #{groupId};
            """)
    void updateTableGroup(int groupId);

    @Select("""
            select * from tableGroup
            where id = #{groupId}
            """)
    TableGroup getTableGroupById(int groupId);

    @Select("""
            select * from CartItems
                where CartItems.floor_id = #{i}
                  and delStatus = 0
                group by table_id;
            """)
    List<CartItems> getOrderTablesList(int i);

    @Update("""
            update CartItems
                set updateDate = now(),
                    productSumPrice = 0,
                    productPrice = 0,
                    productName = #{productName},
                    productSailPrice = #{productSailPrice}
                where table_id = #{tabId}
                  and floor_id = #{floor}
                  and product_id = #{productId}
            """)
    void freeProductUpdate(int productId, int tabId, int floor, String productName, int productSailPrice);

    @Update("""
            update CartItems
                 inner join product as p
                 on CartItems.product_id = p.id
                 set CartItems.updateDate = now(),
                     CartItems.productSumPrice = p.price * CartItems.quantity,
                     CartItems.productPrice = p.price,
                     CartItems.productName = p.name,
                     CartItems.productSailPrice = ${productSailPrice}
                 where CartItems.table_id = #{tabId}
                   and CartItems.floor_id = #{floor}
                   and CartItems.product_id = #{productId}
            """)
    void cancelFreeProduct(int productId, int tabId, int floor, String productName, int productSailPrice);

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

    @Update("""
            update paymentCreditCartAndCash
                set updateDate = now(),
                    totalAmount = #{totalAmount},
                    CartAmountPaid = cartAmountPaid + #{splitAmount},
                    discountAmount = #{cartTotalSailAmount},
                    payByCreditCartNumber = #{creditCartNumber}
                where tabId = #{tabId}
                and floor = #{floor}
                and id = #{id}
            """)
    void updatePaymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber, int id);

    @Update("""
            update CartItems
                set delDate       = now(),
                    delStatus = 1
                where table_id = #{tabId}
                  and floor_id = #{floor}
            """)
    void removePaidCartItem(int floor, int tabId);

    List<Integer> getPayedTotalAmount(String floor);

    List<Integer> getPayedTotalCnt(String floor);

    List<Integer> getPayedTotalDiscountAmount(String floor);

    @Select("""
            select ifnull(sum(CartItems.productSumPrice), 0)
                from CartItems
                where delStatus = 0;
            """)
    int getOutstandingAmount();

    @Select("""
            select ifnull(sum(CartItems.productSailPrice), 0) from CartItems
                 where delStatus = 0
                   and table_id = #{tabNum}
                   and CartItems.floor_id = #{floor}
            """)
    int getDiscountSumAmount(int tabNum, int floor);


    @Select("""
            select id from paymentCreditCartAndCash
            order by regDate desc limit 1;
            """)
    int paymentCreditCartAndCashLastId();

    @Select("""
            select * from Cart
                       where tabId = #{tabId}
                       and floor = #{floor}
            """)
    Cart getCart(int floor, int tabId);

    @Insert("""
            insert into Cart (regDate, updateDate, tabId, floor)
                values (now(), now(), #{tabId} , #{floor});
            """)
    void createCart(int floor, int tabId);

    @Delete("""
            delete from Cart
            where tabId = #{tabId}
            and floor = #{floor}
            """)
    void removeCart(int floor, int tabId);

    @Update("""
            update Cart
                set updateDate = now(),
                    tabId      = #{afterTableNum},
                    floor      = #{floor}
                where tabId = #{currTableNum}
                and floor = #{floor}
            """)
    void updateCart(int floor, int afterTableNum, int currTableNum);
}
