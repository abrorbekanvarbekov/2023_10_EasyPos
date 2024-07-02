package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Table {
    private int id;
    private String regDate;
    private String updateDate;
    private String tableName;
    private int width;
    private int height;
    private int left;
    private int top;
    private int authLevel;
    private int floor;
    private String bgColor;
}
