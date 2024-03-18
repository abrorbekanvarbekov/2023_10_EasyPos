package com.example.easypos.DAO;

import com.example.easypos.Vo.Product;
import com.example.easypos.Vo.ProductType;
import com.example.easypos.VoBasicInformation.productBigClassification;
import com.example.easypos.VoBasicInformation.productMiddleClassification;
import com.example.easypos.VoBasicInformation.productSmallClassification;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface BasicInformationDao {

    List<productBigClassification> getBigClassification(String searchClassificationName, String bigClassificationCode);

    List<productMiddleClassification> getMiddleClassifications(String searchClassificationName, String bigClassificationCode);

    List<productSmallClassification> getSmallClassification(String bigClassificationCode, String middleClassificationCode, String searchClassificationName);

    @Select("""
            select *
            from productBigClassification
            where bigClassificationCode = #{classificationCode};
            """)
    productBigClassification getBigClassificationByName(String classificationCode);

    @Select("""
            select *
            from productMiddleClassification
            where middleClassificationCode = #{classificationCode}
            and bigClassificationCode = #{bigClassificationCode};
            """)
    productMiddleClassification getMiddleClassificationByName(String classificationCode, String bigClassificationCode);

    @Select("""
            select *
            from productSmallClassification
            where smallClassificationCode = #{classificationCode}
            and bigClassificationCode = #{bigClassificationCode}
            and middleClassificationCode = #{middleClassificationCode};
            """)
    productSmallClassification getSmallClassificationByName(String classificationCode, String bigClassificationCode, String middleClassificationCode);

    @Insert("""
            insert into productBigClassification(regDate, updateDate, bigClassificationCode, bigClassificationName,
                                                     middleClassificationCnt)
                select now(), now(), #{classificationCode}, #{classificationName}, count(middle.id)
                from productMiddleClassification as middle
                where middle.bigClassificationCode = #{classificationCode};
            """)
    void insertBigClassification(String classificationCode, String classificationName);

    @Update("""
            update productBigClassification
                set updateDate             = now(),
                    bigClassificationName  = #{bigClassificationName}
                where bigClassificationCode = #{bigClassificationCode};
            """)
    void updateBigClassification(String bigClassificationCode, String bigClassificationName);

    @Update("""
            update productBigClassification
                set updateDate             = now(),
                    middleClassificationCnt = middleClassificationCnt + #{middleClassificationCnt}
                where bigClassificationCode = #{bigClassificationCode};
            """)
    void updateBigClassificationCnt(String bigClassificationCode, String middleClassificationCode, String middleClassificationCnt);

    @Insert("""
            insert into productMiddleClassification(regDate, updateDate, bigClassificationCode, middleClassificationCode,
                                                        middleClassificationName, smallClassificationCnt)
                select now(), now(), #{bigClassificationCode}, #{classificationCode}, #{classificationName}, count(small.id)
                from productSmallClassification as small
                where small.bigClassificationCode = #{bigClassificationCode}
                and small.middleClassificationCode = #{classificationCode};
            """)
    void insertMiddleClassification(String classificationCode, String classificationName, String bigClassificationCode);

    @Update("""
            update productMiddleClassification
                set updateDate             = now(),
                    middleClassificationName  = #{middleClassificationName}
                where bigClassificationCode = #{bigClassificationCode}
                    and middleClassificationCode = #{middleClassificationCode};
            """)
    void updateMiddleClassification(String bigClassificationCode, String middleClassificationCode, String middleClassificationName);

    @Update("""
            update productMiddleClassification
                set updateDate             = now(),
                    smallClassificationCnt = smallClassificationCnt + #{smallClassificationCnt}
                where bigClassificationCode = #{bigClassificationCode}
                and middleClassificationCode = #{middleClassificationCode};
            """)
    void updateMiddleClassificationCnt(String bigClassificationCode, String middleClassificationCode, String smallClassificationCnt);

    @Insert("""
            insert into productSmallClassification
            set regDate                  = now(),
                updateDate               = now(),
                bigClassificationCode = #{bigClassificationCode},
                middleClassificationCode = #{middleClassificationCode},
                        smallClassificationCode  = #{classificationCode},
                        smallClassificationName  = #{classificationName},
                        productCnt               = 0;
            """)
    void insertSmallClassification(String classificationCode, String classificationName, String bigClassificationCode, String middleClassificationCode);

    @Update("""
            update productSmallClassification
                set updateDate             = now(),
                    smallClassificationName  = #{smallClassificationName}
                where bigClassificationCode = #{bigClassificationCode}
                    and middleClassificationCode = #{middleClassificationCode}
                    and smallClassificationCode = #{smallClassificationCode};
            """)
    void updateSmallClassification(String bigClassificationCode, String middleClassificationCode, String smallClassificationCode, String smallClassificationName);

    @Delete("""
            delete  from productBigClassification
            where bigClassificationCode = #{removeClassificationId};
            """)
    void removeBigClassification(String removeClassificationId);

    @Delete("""
            delete  from productMiddleClassification
            where bigClassificationCode = #{checkedBigClassificationCode}
            and middleClassificationCode = #{removeClassificationId};
            """)
    void removeMiddleClassification(String removeClassificationId, String checkedBigClassificationCode);

    @Delete("""
            delete  from productSmallClassification
            where bigClassificationCode = #{checkedBigClassificationCode}
            and middleClassificationCode = #{checkedMiddleClassificationCode}
            and smallClassificationCode = #{removeClassificationId};
            """)
    void removeSmallClassification(String removeClassificationId, String checkedBigClassificationCode, String checkedMiddleClassificationCode);

    List<Product> getProductList(String bigClassificationCode, String middleClassificationCode, String smallClassificationCode,
                                 String searchCategory, String productName);


    @Insert("""
            insert into product
            set regDate                  = now(),
                updateDate               = now(),
                productCode              = lpad(#{productCode}, '6', '0'),
                bigClassificationCode    = #{bigClassificationCode},
                middleClassificationCode = #{middleClassificationCode},
                smallClassificationCode  = #{smallClassificationCode},
                productKorName           = #{productKorName},
                productEngName           = #{productEngName},
                price                    = #{price},
                costPrice                = #{costPrice};
            """)
    int addProduct(int productCode, String bigClassificationCode, String middleClassificationCode, String smallClassificationCode,
                   String productKorName, String productEngName, int price, int costPrice);


    @Select("""
            select ifnull(max(id), 0) from product;
            """)
    int getProductListSize();

    @Update("""
            update product
                set updateDate            = now(),
                    bigClassificationCode = #{bigClassificationCode},
                    middleClassificationCode = #{middleClassificationCode},
                    smallClassificationCode = #{smallClassificationCode},
                    productKorName = #{productKorName},
                    productEngName = #{productEngName},
                    price = #{price},
                    costPrice = #{costPrice}
                where id = #{productId}
            """)
    int modifyProduct(int productId, String bigClassificationCode, String middleClassificationCode,
                      String smallClassificationCode, String productKorName, String productEngName, int price, int costPrice);


    @Delete("""
            delete from product
            where id = #{productId};
            """)
    int delProduct(int productId);

    @Update("""
            update productSmallClassification
                set updateDate             = now(),
                    productCnt  = productCnt + #{productCnt}
                where bigClassificationCode = #{bigClassificationCode}
                    and middleClassificationCode = #{middleClassificationCode}
                    and smallClassificationCode = #{smallClassificationCode};
            """)
    void updateSmallClassProductCnt(String bigClassificationCode, String middleClassificationCode,
                                    String smallClassificationCode, int productCnt);

    List<ProductType> getProductTypeList(String searchKeyword);

    @Select("""
            select ifnull(max(id), 0) from productType;
            """)
    int getProductTypeListSize();

    @Insert("""
            insert into productType
            set regDate      = now(),
                updateDate   = now(),
                `code`       = lpad(#{productTypeCode}, '3', '0'),
                korName      = #{productTypeKorName},
                engName      = #{productTypeEngName},
                authDivision = '매장',
                color        = #{productTypeColor};
            """)
    int addProductType(int productTypeCode, String productTypeKorName, String productTypeEngName, String productTypeColor);

    @Select("""
            select * from product
            where productType = #{productTypeId};
            """)
    List<Product> getProducts(String productTypeId);

    @Select("""
            select * from product
                where id = #{productId}
                and productType = #{productTypeId};
            """)
    Product getDuplicatePro(int productId, String productTypeId);

    @Update("""
            update product
                set updateDate = now(),
                    productType = #{productTypeId},
                    color = #{productTypeColor}
                where id = #{productId}
            """)
    int addTypeForProduct(int productId, String productTypeId, String productTypeColor);


}
