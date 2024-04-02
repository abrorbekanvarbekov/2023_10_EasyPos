package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class paymentCreditCard {
    private int id;
    private String regDate;
    private String updateDate;
    private int tabId;
    private int floor;
    private int cartTotalAmount;
    private int cartAmountPaid;
    private int sumCartAmountPaid;
    private int discountAmount;
    private String payByCreditCartNumber;
    private int cart_id;
}
