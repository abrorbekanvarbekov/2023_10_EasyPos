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
    private String middleClassificationCode;
    private String smallClassificationCode;
    private String productType;
    private String productKorName;
    private String productEngName;
    private String color;
    private int price;
    private int costPrice;
    private int quantity;
}
