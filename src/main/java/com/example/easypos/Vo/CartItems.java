package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItems {
    private int id;
    private String regDate;
    private String updateDate;
    private int product_id;
    private int table_id;
    private int quantity;
    private String name;
    private int price;
    private int PriceSum;
}
