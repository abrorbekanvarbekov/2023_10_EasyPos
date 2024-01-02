package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TableGroup {
    private int id;
    private String regDate;
    private String updateDate;
    private int groupNum;
    private int tableCnt;
    private String color;
}
