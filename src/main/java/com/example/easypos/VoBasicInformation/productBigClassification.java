package com.example.easypos.VoBasicInformation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class productBigClassification {
    private int id;
    private String regDate;
    private String updateDate;
    private String bigClassificationCode;
    private String bigClassificationName;
    private int middleClassificationCnt;
    private int delStatus;
    private String delDate;
}
