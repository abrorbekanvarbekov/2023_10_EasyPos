package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    private int id;
    private String regDate;
    private String updateDate;
    private String productCode;
    private String bigClassificationCode;
    private String bigClassificationName;
    private String middleClassificationCode;
    private String middleClassificationName;
    private String smallClassificationCode;
    private String smallClassificationName;
    private String productKorName;
    private String productEngName;
    private String color;
    private int price;
    private int costPrice;
    private int quantity;
}
