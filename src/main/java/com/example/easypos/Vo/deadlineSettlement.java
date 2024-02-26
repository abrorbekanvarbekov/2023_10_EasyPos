package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class deadlineSettlement {
    private int id;
    private String businessDate;
    private String updateDate;
    private String openingDate;
    private String employeeName;
    private String employeeCode;
    private int totalSales;
    private int totalSalesCount;
    private int discountAmount;
    private int VAT;
    private int NETSales;
    private int amountOfReturns;
    private int paidByCash;
    private int paidByCart;
}
