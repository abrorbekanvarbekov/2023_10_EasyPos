package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class paymentCreditCartAndCash {
    private int id;
    private String regDate;
    private String updateDate;
    private int tabId;
    private int floor;
    private int totalAmount;
    private int CartAmountPaid;
    private int CashAmountPaid;
    private int discountAmount;
    private int payByCreditCartNumber;
}
