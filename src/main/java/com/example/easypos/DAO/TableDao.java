package com.example.easypos.DAO;

import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.Product;
import com.example.easypos.Vo.ProductType;
import com.example.easypos.Vo.Table;
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
            where id = #{id}
            """)
    void updateTablePos(int elPosX, int elPosY, int id);

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
            insert into CartItems
            set regDate = now(),
                updateDate = now(),
                product_id = #{id},
                floor_id = #{floor_id},
                table_id = #{tabId},
                quantity = 1       
            """)
    void insertCartItems(int id, int tabId, int floor_id);

    @Select("""
            select p.*, c.quantity
            from product as p
                     inner join CartItems as c
                        on p.id = c.product_id
            where c.table_id = #{tableId}
            and c.floor_id = #{floor}
            """)
    List<CartItems> getCartItemsList(int tableId, int floor);

    @Select("""
            select * from CartItems
            where product_id = #{productId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            """)
    CartItems getCartItem(int productId, int tabId, int floor);

    @Update("""
            update CartItems
                 set updateDate = now(),
                     quantity = quantity + 1
                 where table_id = #{tabId}
                 and product_id = #{id}
                 and floor_id = #{floor}
            """)
    int updateCartItems(int id, int tabId, int floor);

    @Select("""
            select p.*, 
                    c.quantity, 
                    c.table_id
                from product as p
                    inner join CartItems as c
                    on p.id = c.product_id
                where c.floor_id = #{floor}
            """)
    List<CartItems> getCartItems(int floor);

    @Select("""
            select c.*, p.name, p.price,
                sum(c.quantity * p.price ) as priceSum
            from CartItems as c
                inner join product as p
                    on c.product_id = p.id
                where c.floor_id = #{floor}
                group by c.table_id
            """)
    List<CartItems> getPriceSumList(int floor);

    @Select("""
              select count(*) from CartItems
                where table_id = #{tabId}
                and floor_id = #{floor}
            """)
    int getTotalQuantity(int tabId, int floor);

    @Select("""
            select 
                   sum(c.quantity * p.price) as sumPrice
            from product as p
                     inner join CartItems as c
                                on p.id = c.product_id
            where c.floor_id = #{floor}
            and c.table_id = #{tabId};            
            """)
    int getTotalSumPrice(int tabId, int floor);

    @Select("""
            select * from `table`
                where floor = #{floor};      
            """)
    List<Table> getAllTable(int floor);

    @Delete("""
            delete from CartItems
            where product_id = #{productId}
            and table_id = #{tabId}
            and floor_id = #{floor}
            """)
    void cancelProduct(int productId, int tabId, int floor);
}
