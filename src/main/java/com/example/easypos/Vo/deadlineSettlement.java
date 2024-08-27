package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class deadlineSettlement {
    private int id;
    private String openingDate;
    private String closingDate;
    private String updateDate;
    private String openEmployeeName;
    private String openEmployeeCode;
    private String closeEmployeeName;
    private String closeEmployeeCode;
    private int totalSales;
    private int totalSalesCount;
    private int discountAmount;
    private int VAT;
    private int NETSales;
    private int amountOfReturns;
    private int paidByCash;
    private int paidByCard;
}
