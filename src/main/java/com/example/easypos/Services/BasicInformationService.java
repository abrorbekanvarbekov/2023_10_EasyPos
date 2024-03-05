package com.example.easypos.Services;

import com.example.easypos.DAO.BasicInformationDao;
import com.example.easypos.Vo.Product;
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
}
