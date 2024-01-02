package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class paymentCash {
    private int id;
    private String regDate;
    private String updateDate;
    private int tabId;
    private int floor;
    private int cashTotalAmount;
    private int cashAmountPaid;
    private int discountAmount;
}
