package com.example.easypos.VoBasicInformation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class productSmallClassification {
    private int id;
    private String regDate;
    private String updateDate;
    private String bigClassificationCode;
    private String middleClassificationCode;
    private String smallClassificationCode;
    private String smallClassificationName;
    private int productCnt;
    private int delStatus;
    private String delDate;
}
