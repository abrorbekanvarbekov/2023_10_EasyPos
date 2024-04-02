package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class paymentCreditCardAndCash {
    private int id;
    private String regDate;
    private String updateDate;
    private String openingDate;
    private int tabId;
    private int floor;
    private int totalAmount;
    private int CartAmountPaid;
    private int sumCartAmountPaid;
    private int CashAmountPaid;
    private int sumCashAmountPaid;
    private int discountAmount;
    private int cart_id;
    private int isReturn;

}
