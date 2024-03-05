package com.example.easypos.VoBasicInformation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class productMiddleClassification {
    private int id;
    private String regDate;
    private String updateDate;
    private String bigClassificationCode;
    private String middleClassificationCode;
    private String middleClassificationName;
    private int smallClassificationCnt;
    private int delStatus;
    private String delDate;
}
