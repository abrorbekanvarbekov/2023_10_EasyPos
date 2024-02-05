package com.example.easypos.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employee {
    private int id ;
    private String regDate;
    private String updateDate;
    private int userId;
    private int employeeCode;
    private String employeePw;
    private int authLevel;
    private String name;
    private String cellphoneNum;
    private String email;
    private int delStatus;
}
