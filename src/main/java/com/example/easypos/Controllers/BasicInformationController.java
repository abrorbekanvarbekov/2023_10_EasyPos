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

    @RequestMapping("/usr/basic-information/getBigClassification")
    @ResponseBody
    public ResultDate getBigClassification(String searchClassificationName) {

        List<productBigClassification> bigClassificationList = basicInformationService.getBigClassification(searchClassificationName);
        if (bigClassificationList.size() != 0) {
            return ResultDate.from("S-1", "success", "bigClassificationList", bigClassificationList);
        }
        return ResultDate.from("F-1", "Fail");
    }

    @RequestMapping("/usr/basic-information/getMiddleClassification")
    @ResponseBody
    public ResultDate getMiddleClassification(String classificationCode, String searchClassificationName) {

        List<productMiddleClassification> middleClassificationList = basicInformationService.getMiddleClassifications(searchClassificationName, classificationCode);
        if (middleClassificationList.size() != 0) {
            return ResultDate.from("S-1", "success", "middleClassificationList", middleClassificationList);
        }
        return ResultDate.from("F-1", "Fail");
    }

    @RequestMapping("/usr/basic-information/getSmallClassification")
    @ResponseBody
    public ResultDate getSmallClassification(String bigClassificationCode, String middleClassificationCode, String searchClassificationName) {

        List<productSmallClassification> smallClassificationList = basicInformationService.
                getSmallClassification(bigClassificationCode, middleClassificationCode, searchClassificationName);
        if (smallClassificationList.size() != 0) {
            return ResultDate.from("S-1", "success", "smallClassificationList", smallClassificationList);
        }

        return ResultDate.from("F-1", "Fail");
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
                    basicInformationService.
                            insertMiddleClassification(classificationCodeList.get(i), classificationNameList.get(i), bigClassificationCode);
                    // ========= bigClassificationUpdate =======//
                    basicInformationService.
                            updateBigClassificationCnt(bigClassificationCode, classificationCodeList.get(i), "1");
                } else {
                    // ======== update ============ //
                    basicInformationService.
                            updateMiddleClassification(bigClassificationCode, classificationCodeList.get(i), classificationNameList.get(i));
                }

            } else if (classificationName.equals("productSmallClassification")) {
                productSmallClassification smallClassification = basicInformationService.
                        getSmallClassificationByName(classificationCodeList.get(i), bigClassificationCode, middleClassificationCode);
                if (smallClassification == null) {
                    // ======== insert ============ //
                    basicInformationService.
                            insertSmallClassification(
                                    classificationCodeList.get(i), classificationNameList.get(i), bigClassificationCode, middleClassificationCode);
                    // ========= middleClassificationUpdate =======//
                    basicInformationService.
                            updateMiddleClassificationCnt(bigClassificationCode, middleClassificationCode, "1");
                } else {
                    // ======== update ============ //
                    basicInformationService.
                            updateSmallClassification(
                                    bigClassificationCode, middleClassificationCode, classificationCodeList.get(i), classificationNameList.get(i));
                }

            }
        }

        return ResponseEntity.ok("success");
    }


    @RequestMapping("/usr/basic-information/removeClassification")
    @ResponseBody
    public ResponseEntity removeClassification(String removeClassificationId, String removeClassificationType,
                                               String checkedBigClassificationCode, String checkedMiddleClassificationCode) {


        if (removeClassificationType.equals("big")) {
            basicInformationService.removeBigClassification(removeClassificationId);
            return ResponseEntity.ok().build();
        } else if (removeClassificationType.equals("middle")) {
            basicInformationService.
                    updateBigClassificationCnt(checkedBigClassificationCode, removeClassificationId, "-1");
            basicInformationService.removeMiddleClassification(removeClassificationId, checkedBigClassificationCode);
            return ResponseEntity.ok().build();
        } else if (removeClassificationType.equals("small")) {
            basicInformationService.
                    updateMiddleClassificationCnt(checkedBigClassificationCode, checkedMiddleClassificationCode, "-1");
            basicInformationService.removeSmallClassification(removeClassificationId, checkedBigClassificationCode, checkedMiddleClassificationCode);
            return ResponseEntity.ok().build();
        }

        return ResponseEntity.badRequest().build();
    }
}
