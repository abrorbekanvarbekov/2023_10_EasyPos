package com.example.easypos.DAO;

import com.example.easypos.Vo.ProductType;
import com.example.easypos.Vo.Table;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
            select * from productType
            where id = #{id}
            """)
    ProductType getProductTypeById(int id);
}
