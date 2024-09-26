package com.example.easypos.Services;

import com.example.easypos.DAO.BasicInformationDao;
import com.example.easypos.Vo.Product;
import com.example.easypos.Vo.ProductType;
import com.example.easypos.Vo.Table;
import com.example.easypos.VoBasicInformation.productBigClassification;
import com.example.easypos.VoBasicInformation.productMiddleClassification;
import com.example.easypos.VoBasicInformation.productSmallClassification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BasicInformationService {
    private BasicInformationDao basicInformationDao;

    @Autowired
    public BasicInformationService(BasicInformationDao basicInformationDao) {
        this.basicInformationDao = basicInformationDao;
    }


    //     ===================================== 상품분류관리 ======================= //

    public List<productBigClassification> getBigClassification(String searchClassificationName, String bigClassificationCode) {
        return basicInformationDao.getBigClassification(searchClassificationName, bigClassificationCode);
    }

    public List<productMiddleClassification> getMiddleClassifications(String searchClassificationName, String bigClassificationCode) {
        return basicInformationDao.getMiddleClassifications(searchClassificationName, bigClassificationCode);
    }

    public List<productSmallClassification> getSmallClassification(String bigClassificationCode, String middleClassificationCode, String searchClassificationName) {
        return basicInformationDao.getSmallClassification(bigClassificationCode, middleClassificationCode, searchClassificationName);
    }

    public productBigClassification getBigClassificationByName(String classificationCode) {
        return basicInformationDao.getBigClassificationByName(classificationCode);
    }

    public productMiddleClassification getMiddleClassificationByName(String classificationCode, String bigClassificationCode) {
        return basicInformationDao.getMiddleClassificationByName(classificationCode, bigClassificationCode);
    }

    public productSmallClassification getSmallClassificationByName(String classificationName, String bigClassificationCode, String middleClassificationCode) {
        return basicInformationDao.getSmallClassificationByName(classificationName, bigClassificationCode, middleClassificationCode);
    }

    public void insertBigClassification(String classificationCode, String classificationName) {
        basicInformationDao.insertBigClassification(classificationCode, classificationName);
    }

    public void updateBigClassification(String bigClassificationCode, String bigClassificationName) {
        basicInformationDao.updateBigClassification(bigClassificationCode, bigClassificationName);
    }

    public void updateBigClassificationCnt(String bigClassificationCode, String middleClassificationCode, String middleClassificationCnt) {
        basicInformationDao.updateBigClassificationCnt(bigClassificationCode, middleClassificationCode, middleClassificationCnt);
    }

    public void insertMiddleClassification(String classificationCode, String classificationName, String bigClassificationCode) {
        basicInformationDao.insertMiddleClassification(classificationCode, classificationName, bigClassificationCode);
    }

    public void updateMiddleClassification(String bigClassificationCode, String middleClassificationCode, String middleClassificationName) {
        basicInformationDao.updateMiddleClassification(bigClassificationCode, middleClassificationCode, middleClassificationName);
    }

    public void updateMiddleClassificationCnt(String bigClassificationCode, String middleClassificationCode, String smallClassificationCnt) {
        basicInformationDao.updateMiddleClassificationCnt(bigClassificationCode, middleClassificationCode, smallClassificationCnt);
    }


    public void insertSmallClassification(String classificationCode, String classificationName, String bigClassificationCode, String middleClassificationCode) {
        basicInformationDao.insertSmallClassification(classificationCode, classificationName, bigClassificationCode, middleClassificationCode);
    }


    public void updateSmallClassification(String bigClassificationCode, String middleClassificationCode, String smallClassificationCode, String smallClassificationName) {
        basicInformationDao.updateSmallClassification(bigClassificationCode, middleClassificationCode, smallClassificationCode, smallClassificationName);
    }

    public void removeBigClassification(String removeClassificationId) {
        basicInformationDao.removeBigClassification(removeClassificationId);
    }

    public void removeMiddleClassification(String removeClassificationId, String checkedBigClassificationCode) {
        basicInformationDao.removeMiddleClassification(removeClassificationId, checkedBigClassificationCode);
    }

    public void removeSmallClassification(String removeClassificationId, String checkedBigClassificationCode, String checkedMiddleClassificationCode) {
        basicInformationDao.removeSmallClassification(removeClassificationId, checkedBigClassificationCode, checkedMiddleClassificationCode);
    }


    //     ===================================== 상품 조회 ======================= //

    public List<Product> getProductList(String bigClassificationCode, String middleClassificationCode, String smallClassificationCode,
                                        String searchCategory, String productName) {
        return basicInformationDao.
                getProductList(bigClassificationCode, middleClassificationCode, smallClassificationCode, searchCategory, productName);
    }

    //     ===================================== 상품 등록 ======================= //

    public int addProduct(List<String> bigClassificationCodeList, List<String> middleClassificationCodeList, List<String> smallClassificationCodeList, List<String> productKorNameList,
                          List<String> productEngNameList, List<Integer> priceList, List<Integer> costPriceList) {
        int result = 0;
        for (int i = 0; i < bigClassificationCodeList.size(); i++) {
            int productCode = basicInformationDao.getProductListSize();
            String bigClassificationCode = bigClassificationCodeList.get(i);
            String middleClassificationCode = middleClassificationCodeList.get(i);
            String smallClassificationCode = smallClassificationCodeList.get(i);
            String productKorName = productKorNameList.get(i);
            String productEngName = productEngNameList.get(i);
            int price = priceList.get(i);
            int costPrice = costPriceList.get(i);
            result = basicInformationDao.addProduct(productCode + 1, bigClassificationCode,
                    middleClassificationCode, smallClassificationCode,
                    productKorName, productEngName, price, costPrice);

            if (result == 1) {
                basicInformationDao.updateSmallClassProductCnt(bigClassificationCode, middleClassificationCode,
                        smallClassificationCode, 1);
            }
        }
        return result;
    }

    //     ===================================== 상품 삭제 ======================= //

    public int delProduct(List<String> delProductIds) {
        int result = 0;
        for (int i = 0; i < delProductIds.size(); i++) {
            int productId = Integer.parseInt(delProductIds.get(i));
            result = basicInformationDao.delProduct(productId);
        }
        return result;
    }

    public int modifyProduct(List<String> updateProductIdList, List<String> bigClassificationCodeList,
                             List<String> middleClassificationCodeList, List<String> smallClassificationCodeList,
                             List<String> productKorNameList, List<String> productEngNameList,
                             List<Integer> priceList, List<Integer> costPriceList) {
        int result = 0;
        for (int i = 0; i < updateProductIdList.size(); i++) {
            int productId = Integer.parseInt(updateProductIdList.get(i));
            String bigClassificationCode = bigClassificationCodeList.get(i);
            String middleClassificationCode = middleClassificationCodeList.get(i);
            String smallClassificationCode = smallClassificationCodeList.get(i);
            String productKorName = productKorNameList.get(i);
            String productEngName = productEngNameList.get(i);
            int price = priceList.get(i);
            int costPrice = costPriceList.get(i);
            result = basicInformationDao.modifyProduct(productId, bigClassificationCode, middleClassificationCode, smallClassificationCode,
                    productKorName, productEngName, price, costPrice);
        }

        return result;
    }

    public List<ProductType> getProductTypeList(String searchKeyword) {
        return basicInformationDao.getProductTypeList(searchKeyword);
    }


    public int addProductType(List<String> newProTypeSequenceNumList, List<String> productTypeKorNameList,
                              List<String> productTypeEngNameList, List<String> productTypeColorList) {
        int result = 0;
        for (int i = 0; i < productTypeKorNameList.size(); i++) {
            int productTypeCode = basicInformationDao.getProductTypeListSize();
            String productTypeKorName = productTypeKorNameList.get(i);
            String productTypeEngName = productTypeEngNameList.get(i);
            String productTypeColor = productTypeColorList.get(i);
            int sequenceNum = Integer.parseInt(newProTypeSequenceNumList.get(i));
            result = basicInformationDao.addProductType(productTypeCode + 1, productTypeKorName, productTypeEngName,
                    productTypeColor, sequenceNum);

            if (result == 1) {
                String proTypeCode = String.format("%03d", productTypeCode + 1);
                ProductType productType = basicInformationDao.getProductType(proTypeCode, productTypeKorName);

                String dropSql = "drop table if exists `" + productType.getCode() + "`";
                basicInformationDao.createAndDropTable(dropSql);
                String createSql = "create table " + "`" + productType.getCode() + "`" + "\n" +
                        "                (\n" +
                        "                    id          int unsigned not null primary key auto_increment,\n" +
                        "                    regDate     datetime     not null,\n" +
                        "                    updateDate  datetime     not null,\n" +
                        "                    `code`      varchar(50)  not null,\n" +
                        "                    korName     varchar(100) not null,\n" +
                        "                    productCode varchar(50)  not null,\n" +
                        "                    color       varchar(50)  not null,\n" +
                        "                    sequenceNum int                    \n" +
                        "                );";
                basicInformationDao.createAndDropTable(createSql);
            }
        }
        return result;
    }

    public int updateProductType(List<String> updateProductTypeCodeList, List<String> updateProTypeKorNameList, List<String> updateProTypeEngNameList, List<String> updateProTypeColorList) {
        int result = 0;
        for (int i = 0; i < updateProTypeKorNameList.size(); i++) {
            int productTypeCode = Integer.parseInt(updateProductTypeCodeList.get(i));
            String updateProTypeKorName = updateProTypeKorNameList.get(i);
            String updateProTypeEngName = updateProTypeEngNameList.get(i);
            String updateProTypeColor = updateProTypeColorList.get(i);
            result = basicInformationDao.updateProductType(productTypeCode, updateProTypeKorName, updateProTypeEngName, updateProTypeColor);
        }
        return result;
    }

    public int updateProTypeSequenceNum(List<String> proTypeCodeList, List<String> proTypeSequenceNumLIst) {
        int result = 0;
        if (proTypeCodeList.size() != 0) {
            for (int i = 0; i < proTypeCodeList.size(); i++) {
                int sequenceNum = Integer.parseInt(proTypeSequenceNumLIst.get(i));
                String productTypeCode = proTypeCodeList.get(i);
                result = basicInformationDao.updateProTypeSequenceNum(sequenceNum, productTypeCode);
            }
        }
        return result;
    }

    public List<Product> getProducts(String productTypeCode) {
        return basicInformationDao.getProducts(productTypeCode);
    }

    public int delProductTypes(List<String> delProTypeIdList) {
        int result = 0;
        for (int i = 0; i < delProTypeIdList.size(); i++) {
            int delProductTypeId = Integer.parseInt(delProTypeIdList.get(i));
            ProductType productType = basicInformationDao.getProductTypeById(delProductTypeId);
            result = basicInformationDao.delProductTypes(delProductTypeId);
            if (result == 1) {
                String dropSql = "drop table if exists `" + productType.getCode() + "`";
                basicInformationDao.createAndDropTable(dropSql);
            }
        }
        return result;
    }

    public int addTypeFromProducts(List<String> productCodeList, String productTypeId, String productTypeColor) {
        int result = 0;
        if (productCodeList.size() != 0) {
            for (int i = 0; i < productCodeList.size(); i++) {
                Product isDuplicatePro = basicInformationDao.getDuplicatePro(productCodeList.get(i), productTypeId);
                if (isDuplicatePro == null) {
                    List<Product> productLength = basicInformationDao.getProducts(productTypeId);
                    int sequenceNum = productLength.size() + 1;
                    result = basicInformationDao.appendProForTypeItem(productCodeList.get(i), productTypeId, productTypeColor, sequenceNum);
                }
            }
        }
        return result;
    }


    public int updateProducts(List<String> updateProductCodeList, List<String> updateProSequenceNumList, List<String> updateProductColorList, String selectProTypeCode) {
        int result = 0;
        if (updateProductCodeList.size() != 0) {
            for (int i = 0; i < updateProductCodeList.size(); i++) {
                String productCode = updateProductCodeList.get(i);
                String proSequenceNum = updateProSequenceNumList.get(i);
                String productNewColor = updateProductColorList.get(i);
                result = basicInformationDao.updateProducts(productCode, proSequenceNum, productNewColor, selectProTypeCode);
            }
        }
        return result;
    }

    public int updateProductsSequenceNum(List<String> proSequenceNumLIst, List<String> productProCodeList, String selectProTypeCode) {
        int result = 0;
        if (proSequenceNumLIst.size() != 0) {
            for (int i = 0; i < proSequenceNumLIst.size(); i++) {
                int sequenceNum = Integer.parseInt(proSequenceNumLIst.get(i));
                String productCode = productProCodeList.get(i);
                result = basicInformationDao.updateProductsSequenceNum(sequenceNum, productCode, selectProTypeCode);
            }
        }
        return result;
    }

    public int delTypeForProducts(List<String> delProductCodeList, String productTypeCode) {
        int result = 0;
        for (int i = 0; i < delProductCodeList.size(); i++) {
            result = basicInformationDao.delProductFromItem(delProductCodeList.get(i), productTypeCode);
        }
        return result;
    }

    public int updateProductTypes(List<String> proTypeSeqNumList, List<String> proTypeCodesList, List<String> proTypeNamesList, List<String> proTypeColorsList) {
        int result = 0;
        if (proTypeCodesList.size() != 0) {
            for (int i = 0; i < proTypeCodesList.size(); i++) {
                int sequenceNum = Integer.parseInt(proTypeSeqNumList.get(i));
                String proTypeCode = proTypeCodesList.get(i);
                String proTypeName = proTypeNamesList.get(i);
                String proTypeColor = proTypeColorsList.get(i);
                result = basicInformationDao.updateProductTypes(sequenceNum, proTypeCode, proTypeName, proTypeColor);
            }
        }
        return result;
    }

    //    =========== 테이블 배치 ===================//
    public List<Table> getTables(int floor) {
        return basicInformationDao.getTables(floor);
    }

}
