package com.example.easypos.Vo;

import lombok.Data;


@Data
public class ResultDate<DT> {
    private String resultCode;
    private String msg;
    private String dataName;
    private DT data1;
    private String data2Name;
    private Object data2;

    public static <DT>ResultDate<DT> from (String resultCode, String msg){
        return from(resultCode, msg, null, null);
    }

    public static <DT>ResultDate<DT> from (String resultCode, String msg, DT data1){
        return from(resultCode, msg,null);
    }

    public static <DT>ResultDate<DT> from (String resultCode, String msg, String dataName, DT data1){
        ResultDate<DT> rd = new ResultDate<>();
        rd.resultCode = resultCode;
        rd.msg = msg;
        rd.dataName = dataName;
        rd.data1 = data1;
        return rd;
    }

    public static <DT>ResultDate<DT> from (String resultCode, String msg, String dataName, DT data1, DT data2){
        ResultDate<DT> rd = new ResultDate<>();
        rd.resultCode = resultCode;
        rd.msg = msg;
        rd.dataName = dataName;
        rd.data1 = data1;
        rd.data2 = data2;
        return rd;
    }

    public boolean isSuccess(){
        return this.resultCode.startsWith("S-");
    }

    public boolean isFail(){
        return isSuccess() == false;
    }

    public void setData2(String data2Name, Object data2) {
        this.data2Name = data2Name;
        this.data2 = data2;
    }
}
