package com.example.easypos.Controllers;

import com.example.easypos.Services.BasicInformationService;
import com.example.easypos.Vo.*;
import com.example.easypos.VoBasicInformation.productBigClassification;
import com.example.easypos.VoBasicInformation.productMiddleClassification;
import com.example.easypos.VoBasicInformation.productSmallClassification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class BasicInformationController {
    private BasicInformationService basicInformationService;
    private Rq rq;
    private LocalTime now;
    private Date dateNow;
    private DateTimeFormatter formatter;
    private SimpleDateFormat dateFormatter;


    @Autowired
    public BasicInformationController(BasicInformationService basicInformationService, Rq rq) {
        this.basicInformationService = basicInformationService;
        this.rq = rq;
        this.now = LocalTime.now();
        this.dateNow = new Date();
        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    //     ========================== 상품분류관리 ============================//

    @RequestMapping("/usr/basic-information/getBigClassification")
    @ResponseBody
    public ResponseEntity getBigClassification(@RequestParam(defaultValue = "") String searchClassificationName, @RequestParam(defaultValue = "") String bigClassificationCode) {
        List<productBigClassification> bigClassificationList = basicInformationService.getBigClassification(searchClassificationName, bigClassificationCode);

        if (bigClassificationList.size() != 0) {
            return ResponseEntity.ok(bigClassificationList);
        }

        return ResponseEntity.noContent().build();
    }

    @RequestMapping("/usr/basic-information/getMiddleClassification")
    @ResponseBody
    public ResponseEntity getMiddleClassification(String bigClassificationCode, @RequestParam(defaultValue = "") String searchClassificationName) {

        List<productMiddleClassification> middleClassificationList = basicInformationService.getMiddleClassifications(searchClassificationName, bigClassificationCode);
        if (middleClassificationList.size() != 0) {
            return ResponseEntity.ok(middleClassificationList);
        }

        return ResponseEntity.noContent().build();
    }

    @RequestMapping("/usr/basic-information/getSmallClassification")
    @ResponseBody
    public ResponseEntity getSmallClassification(String bigClassificationCode, String middleClassificationCode, @RequestParam(defaultValue = "") String searchClassificationName) {

        List<productSmallClassification> smallClassificationList = basicInformationService.getSmallClassification(bigClassificationCode, middleClassificationCode, searchClassificationName);

        if (smallClassificationList.size() != 0) {
            return ResponseEntity.ok(smallClassificationList);
        }

        return ResponseEntity.noContent().build();
    }


    @RequestMapping("/usr/basic-information/createClassification")
    @ResponseBody
    public ResponseEntity createClassification(@RequestParam List<String> classificationNameList, @RequestParam List<String> classificationCodeList,
                                               String classificationName, String bigClassificationCode, String middleClassificationCode) {

        for (int i = 0; i < classificationCodeList.size(); i++) {
            if (classificationName.equals("productBigClassification")) {
                productBigClassification bigClassification = basicInformationService.getBigClassificationByName(classificationCodeList.get(i));

                if (bigClassification == null) {
                    // ======== insert ============ //
                    basicInformationService.insertBigClassification(classificationCodeList.get(i), classificationNameList.get(i));
                } else {
                    // ======== update ============ //
                    basicInformationService.updateBigClassification(classificationCodeList.get(i), classificationNameList.get(i));
                }

            } else if (classificationName.equals("productMiddleClassification")) {
                productMiddleClassification middleClassification = basicInformationService.getMiddleClassificationByName(classificationCodeList.get(i), bigClassificationCode);
                if (middleClassification == null) {
                    // ======== insert ============ //
                    basicInformationService.insertMiddleClassification(classificationCodeList.get(i), classificationNameList.get(i), bigClassificationCode);
                    // ========= bigClassificationUpdate =======//
                    basicInformationService.updateBigClassificationCnt(bigClassificationCode, classificationCodeList.get(i), "1");
                } else {
                    // ======== update ============ //
                    basicInformationService.updateMiddleClassification(bigClassificationCode, classificationCodeList.get(i), classificationNameList.get(i));
                }

            } else if (classificationName.equals("productSmallClassification")) {
                productSmallClassification smallClassification = basicInformationService.getSmallClassificationByName(classificationCodeList.get(i), bigClassificationCode, middleClassificationCode);
                if (smallClassification == null) {
                    // ======== insert ============ //
                    basicInformationService.insertSmallClassification(classificationCodeList.get(i), classificationNameList.get(i), bigClassificationCode, middleClassificationCode);
                    // ========= middleClassificationUpdate =======//
                    basicInformationService.updateMiddleClassificationCnt(bigClassificationCode, middleClassificationCode, "1");
                } else {
                    // ======== update ============ //
                    basicInformationService.updateSmallClassification(bigClassificationCode, middleClassificationCode, classificationCodeList.get(i), classificationNameList.get(i));
                }

            }
        }

        return ResponseEntity.ok("success");
    }


    @RequestMapping("/usr/basic-information/removeClassification")
    @ResponseBody
    public ResponseEntity removeClassification(String removeClassificationId, String removeClassificationType, String checkedBigClassificationCode, String checkedMiddleClassificationCode) {


        if (removeClassificationType.equals("big")) {
            basicInformationService.removeBigClassification(removeClassificationId);
            return ResponseEntity.ok().build();
        } else if (removeClassificationType.equals("middle")) {
            basicInformationService.updateBigClassificationCnt(checkedBigClassificationCode, removeClassificationId, "-1");
            basicInformationService.removeMiddleClassification(removeClassificationId, checkedBigClassificationCode);
            return ResponseEntity.ok().build();
        } else if (removeClassificationType.equals("small")) {
            basicInformationService.updateMiddleClassificationCnt(checkedBigClassificationCode, checkedMiddleClassificationCode, "-1");
            basicInformationService.removeSmallClassification(removeClassificationId, checkedBigClassificationCode, checkedMiddleClassificationCode);
            return ResponseEntity.ok().build();
        }

        return ResponseEntity.badRequest().build();
    }


    //     ========================== 상품 조회 ============================//
    @RequestMapping("/usr/basic-information/productSearch")
    @ResponseBody
    public ResponseEntity productSearch(String bigClassificationCode, String middleClassificationCode, String smallClassificationCode, String searchCategory, String productName) {

        List<Product> productList = basicInformationService.getProductList(bigClassificationCode, middleClassificationCode, smallClassificationCode, searchCategory, productName);

        if (productList.size() != 0) {
            return ResponseEntity.ok(productList);
        }

        return ResponseEntity.noContent().build();
    }


    //     ========================== 상품 등록 ============================//
    @RequestMapping("/usr/basic-information/addProduct")
    @ResponseBody
    public ResponseEntity addProduct(@RequestParam(defaultValue = " ") List<String> bigClassificationCodeList,
                                     @RequestParam(defaultValue = " ") List<String> middleClassificationCodeList,
                                     @RequestParam(defaultValue = " ") List<String> smallClassificationCodeList,
                                     @RequestParam(defaultValue = " ") List<String> productKorNameList,
                                     @RequestParam(defaultValue = " ") List<String> productEngNameList,
                                     @RequestParam List<Integer> priceList,
                                     @RequestParam List<Integer> costPriceList) {

        int result = basicInformationService.addProduct(bigClassificationCodeList, middleClassificationCodeList, smallClassificationCodeList, productKorNameList, productEngNameList, priceList, costPriceList);

        if (result == 1) {
            return ResponseEntity.ok().body("성공");
        } else {
            return ResponseEntity.ok().body("실패");
        }
    }

    //     ========================== 상품 삭제 ============================//
    @RequestMapping("/usr/basic-information/delProduct")
    @ResponseBody
    public ResultDate delProduct(@RequestParam List<String> delProductIds) {

        int result = basicInformationService.delProduct(delProductIds);
        if (result == 1) {
            return ResultDate.from("S-1", "성공");
        } else {
            return ResultDate.from("F-1", "실패");
        }
    }

    //     ========================== 상품 수정 ============================//
    @RequestMapping("/usr/basic-information/modifyProduct")
    @ResponseBody
    public ResultDate modifyProduct(@RequestParam(defaultValue = " ") List<String> updateProductIdList,
                                    @RequestParam(defaultValue = " ") List<String> bigClassificationCodeList,
                                    @RequestParam(defaultValue = " ") List<String> middleClassificationCodeList,
                                    @RequestParam(defaultValue = " ") List<String> smallClassificationCodeList,
                                    @RequestParam(defaultValue = " ") List<String> productKorNameList,
                                    @RequestParam(defaultValue = " ") List<String> productEngNameList,
                                    @RequestParam List<Integer> priceList,
                                    @RequestParam List<Integer> costPriceList) {

        int result = basicInformationService.modifyProduct(updateProductIdList, bigClassificationCodeList, middleClassificationCodeList, smallClassificationCodeList, productKorNameList, productEngNameList, priceList, costPriceList);

        if (result == 1) {
            return ResultDate.from("S-1", "성공");
        } else {
            return ResultDate.from("F-1", "실패");
        }
    }

    // ========================= 터치키 상품 등록 ======================//
    @RequestMapping("/usr/basic-information/touchKeyManagement/getProductType")
    @ResponseBody
    public ResponseEntity getProductType(String searchKeyword) {
        List<ProductType> productTypeList = basicInformationService.getProductTypeList(searchKeyword);
        return ResponseEntity.ok().body(productTypeList);
    }


    @RequestMapping("/usr/basic-information/touchKeyManagement/addProductTypes")
    @ResponseBody
    public ResponseEntity addProductTypes(@RequestParam(defaultValue = " ") List<String> newProTypeSequenceNumList,
                                          @RequestParam(defaultValue = " ") List<String> productTypeKorNameList,
                                          @RequestParam(defaultValue = " ") List<String> productTypeEngNameList,
                                          @RequestParam(defaultValue = " ") List<String> productTypeColorList) {

        int result = basicInformationService.addProductType(newProTypeSequenceNumList, productTypeKorNameList, productTypeEngNameList, productTypeColorList);

        if (result == 1) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @RequestMapping("/usr/basic-information/touchKeyManagement/updateProductTypes")
    @ResponseBody
    public ResponseEntity updateProductTypes(@RequestParam(defaultValue = " ") List<String> updateProductTypeCodeList,
                                             @RequestParam(defaultValue = " ") List<String> updateProTypeSequenceNumList,
                                             @RequestParam(defaultValue = " ") List<String> updateProTypeKorNameList,
                                             @RequestParam(defaultValue = " ") List<String> updateProTypeEngNameList,
                                             @RequestParam(defaultValue = " ") List<String> updateProTypeColorList) {

        int result = basicInformationService.updateProductType(updateProductTypeCodeList, updateProTypeKorNameList, updateProTypeEngNameList, updateProTypeColorList);
        System.out.println(updateProTypeSequenceNumList);
        if (result == 1) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @RequestMapping("/usr/basic-information/touchKeyManagement/delProductTypes")
    @ResponseBody
    public ResponseEntity delProductTypes(@RequestParam List<String> delProTypeIdList) {
        int result = basicInformationService.delProductTypes(delProTypeIdList);

        if (result == 1) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @RequestMapping("/usr/basic-information/touchKeyManagement/getProducts")
    @ResponseBody
    public ResponseEntity getProducts(String productTypeCode) {
        List<Product> productList = basicInformationService.getProducts(productTypeCode);
        return ResponseEntity.ok().body(productList);
    }

    @RequestMapping("/usr/basic-information/touchKeyManagement/addTypeForProducts")
    @ResponseBody
    public ResultDate addTypeFromProducts(@RequestParam List<String> productCodeList, String productTypeId, String productTypeColor) {
        int result = basicInformationService.addTypeFromProducts(productCodeList, productTypeId, productTypeColor);
        if (result == 1) {
            return ResultDate.from("S-1", "성공");
        } else {
            return ResultDate.from("F-1", "실패");
        }
    }

    @RequestMapping("/usr/basic-information/touchKeyManagement/updateProducts")
    @ResponseBody
    public ResponseEntity updateProducts(@RequestParam List<String> updateProductCodeList,
                                         @RequestParam List<String> updateProSequenceNumList,
                                         @RequestParam List<String> updateProductColorList,
                                                            String selectProTypeCode) {

        int result = basicInformationService.updateProducts(updateProductCodeList, updateProSequenceNumList, updateProductColorList, selectProTypeCode);
        if (result == 1) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @RequestMapping("/usr/basic-information/touchKeyManagement/delTypeForProducts")
    @ResponseBody
    public ResponseEntity delTypeForProducts(@RequestParam List<String> delProductCodeList, String productTypeCode) {

        int result = basicInformationService.delTypeForProducts(delProductCodeList, productTypeCode);
        if (result == 1) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
