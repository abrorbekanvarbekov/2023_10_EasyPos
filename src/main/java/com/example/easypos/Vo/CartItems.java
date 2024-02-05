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
    private String productName;
    private int productPrice;
    private int productSumPrice;
    private int priceSum;
    private int productSailPrice;
    private int cart_id;
    private int floor_id;
    private int cartAmountPaid;
    private int cashAmountPaid;
    private int isReturn;
    private int totalAmount;
    private int discountAmount;
}
