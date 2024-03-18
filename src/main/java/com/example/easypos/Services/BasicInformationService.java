package com.example.easypos.Services;

import com.example.easypos.DAO.BasicInformationDao;
import com.example.easypos.Vo.Product;
import com.example.easypos.Vo.ProductType;
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

    public int addProductType(List<String> productTypeKorNameList, List<String> productTypeEngNameList, List<String> productTypeColorList) {
        int result = 0;
        for (int i = 0; i < productTypeKorNameList.size(); i++) {
            int productTypeCode = basicInformationDao.getProductTypeListSize();
            String productTypeKorName = productTypeKorNameList.get(i);
            String productTypeEngName = productTypeEngNameList.get(i);
            String productTypeColor = productTypeColorList.get(i);
            result = basicInformationDao.addProductType(productTypeCode + 1, productTypeKorName, productTypeEngName, productTypeColor);
        }
        return result;
    }

    public int updateProductType(List<String> updateProTypeIdList, List<String> updateProTypeKorNameList, List<String> updateProTypeEngNameList, List<String> updateProTypeColorList) {
        int result = 0;
        for (int i = 0; i < updateProTypeKorNameList.size(); i++) {
            int productTypeId = Integer.parseInt(updateProTypeIdList.get(i));
            String updateProTypeKorName = updateProTypeKorNameList.get(i);
            String updateProTypeEngName = updateProTypeEngNameList.get(i);
            String updateProTypeColor = updateProTypeColorList.get(i);
            result = basicInformationDao.updateProductType(productTypeId, updateProTypeKorName, updateProTypeEngName, updateProTypeColor);
        }
        return result;
    }

    public List<Product> getProducts(String productTypeId) {
        return basicInformationDao.getProducts(productTypeId);
    }

    public int delProductTypes(List<String> delProTypeIdList) {
        int result = 0;
        for (int i = 0; i < delProTypeIdList.size(); i++) {
            int delProductTypeId = Integer.parseInt(delProTypeIdList.get(i));
            result = basicInformationDao.delProductTypes(delProductTypeId);
        }
        return result;
    }

    public int addTypeForProducts(List<String> productIdList, String productTypeId, String productTypeColor) {
        int result = 0;
        if (productIdList.size() != 0) {
            for (int i = 0; i < productIdList.size(); i++) {
                int productId = Integer.parseInt(productIdList.get(i));
                Product isDuplicatePro = basicInformationDao.getDuplicatePro(productId, productTypeId);
                if (isDuplicatePro == null) {
                    result = basicInformationDao.addTypeForProduct(productId, productTypeId, productTypeColor);
                }
            }
        }
        return result;
    }


    public int updateProducts(List<String> updateProductIdList, List<String> updateProductColorList) {
        int result = 0;
        if (updateProductIdList.size() != 0) {
            for (int i = 0; i < updateProductIdList.size(); i++) {
                int productId = Integer.parseInt(updateProductIdList.get(i));
                String productNewColor = updateProductColorList.get(i);
                result = basicInformationDao.updateProducts(productId, productNewColor);
            }
        }

        return result;
    }

    public int delTypeForProducts(List<String> delProductIdList) {
        int result = 0;
        for (int i = 0; i < delProductIdList.size(); i++) {
            int delProductId = Integer.parseInt(delProductIdList.get(i));
            result = basicInformationDao.delTypeForProducts(delProductId);
        }
        return result;
    }


}
