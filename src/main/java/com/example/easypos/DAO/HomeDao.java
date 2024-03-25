package com.example.easypos.DAO;

import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.Table;
import com.example.easypos.Vo.TableGroup;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface HomeDao {
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
            select * from `table`
            where floor = #{floor}
            """)
    List<Table> getTableList(int floor);

    @Select("""
            select c.*, p.productKorName,
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
            select * from tableGroup
            """)
    List<TableGroup> getTableGroups();

    @Select("""
            select * from CartItems
                where CartItems.floor_id = #{i}
                  and delStatus = 0
                group by table_id;
            """)
    List<CartItems> getOrderTablesList(int i);

// ==============================================================//

    @Update("""
            update `table`
            set updateDate = now(),
                `left` = #{elPosX},
                 top = #{elPosY}
            where number = #{number}
            and floor = #{floor}
            """)
    void updateTablePos(int elPosX, int elPosY, int number, int floor);

// ==============================================================//

    List<Integer> getPayedTotalAmount(String floor, String beginDate, String endDate);

    List<Integer> getPayedTotalCnt(String floor, String beginDate, String endDate);

    List<Integer> getPayedTotalDiscountAmount(String floor, String beginDate, String endDate);

    List<Integer> getNumberOfReturns(String floor, String beginDate, String endDate);

    List<Integer> getAmountOfReturns(String floor, String beginDate, String endDate);

    int getOutstandingAmount(String floor, String beginDate, String endDate);

    @Select("""
            select count(*) from CartItems
            where delStatus = 0;
            """)
    int getOutstandingTables(String floor);
    // ==============================================================//

    @Select("""
            select * from CartItems
            where floor_id = #{floor}
            and table_id = #{currTableNum}
            and delStatus = 0
            """)
    List<CartItems> getCurrCartItem(int currTableNum, int floor);

    @Delete("""
            delete from Cart
            where tabId = #{tabId}
            and floor = #{floor}
            """)
    void removeCart(int floor, int tabId);

    @Select("""
            select * from Cart
                       where tabId = #{tabId}
                       and floor = #{floor}
                       limit 1
            """)
    Cart getCart(int floor, int tabId);

    @Select("""
            select * from CartItems
            where product_id = #{productId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            and delStatus = 0
            """)
    CartItems getCartItem(int productId, int tabId, int floor);

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

    @Update("""
            update Cart
                set updateDate = now(),
                    tabId      = #{afterTableNum},
                    floor      = #{floor}
                where tabId = #{currTableNum}
                and floor = #{floor}
            """)
    void updateCart(int floor, int afterTableNum, int currTableNum);

    @Delete("""
            delete from CartItems
                where table_id = #{currTableNum}
                and floor_id = #{floor}
                and delStatus = 0;
            """)
    void delBeforeCartItem(int currTableNum, int floor);

    // ==============================================================//
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

    // ==============================================================//

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


}
