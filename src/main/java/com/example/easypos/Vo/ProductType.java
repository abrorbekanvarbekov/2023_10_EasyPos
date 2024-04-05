package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductType {
    private int id;
    private String regDate;
    private String updateDate;
    private String code;
    private String sequenceNum;
    private String korName;
    private String engName;
    private String authDivision;
    private String color;
    private ArrayList<String> colorList;
}
