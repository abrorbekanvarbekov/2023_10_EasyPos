package com.example.easypos.Util;

import javax.servlet.http.HttpServletRequest;
import java.security.MessageDigest;
import java.util.ArrayList;

public class Util {
    private HttpServletRequest request;

    public Util(HttpServletRequest request) {
        this.request = request;
    }

    public static boolean empty(Object obj) {
        if (obj == null) {
            return true;
        }
        String str = (String) obj;
        return str.trim().length() == 0;
    }

    public static String jsHistoryBack(String msg) {
        if (msg == null) {
            msg = "";
        }

        return String.format("""
                   <script>
                     const msg = '%s'.trim();
                     if (msg.length > 0){
                         alert(msg);
                     }
                     history.back();
                   </script> 
                """, msg);
    }


    public static String jsReplace(String msg, String uri) {
        if (msg == null) {
            msg = "";
        }
        if (uri == null) {
            uri = "";
        }
        return String.format("""
                <script>
                    const msg = '%s'.trim();
                    if(msg.length > 0){
                        alert(msg);
                    }
                    location.replace('%s');
                </script>
                                
                """, msg, uri);
    }

    public static String jsReplace(String uri) {
        if (uri == null) {
            uri = "";
        }
        return String.format("""
                <script>
                    location.replace('%s');
                </script>
                """, uri);
    }

    public static String sha256(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();

            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception ex) {
            return "";
        }
    }

    public static String getTempPassword(int length) {
        int index = 0;
        char[] charArr = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
                'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};

        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < length; i++) {
            index = (int) (charArr.length * Math.random());
            sb.append(charArr[index]);
        }

        return sb.toString();
    }


    public static String getCreditCartNumbers() {
        int index = 0;
        char[] charArr = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < 16; i++) {
            index = (int) (charArr.length * Math.random());

            sb.append(charArr[index]);
        }

//        String.valueOf(sb.replace(4, 11, "*******"));

        return sb.toString();
    }

    public static String getCreditCartCompany() {
        int index = 0;
        String[] StrArr = new String[]{"KB국민", "농협은행", "수협은행", "신한은행",
                "우리은행", "하나은행", "기업은행", "카카오뱅크",
                "산업은행", "케이뱅크", "토스뱅크", "우체국은행"};

        StringBuffer sb = new StringBuffer();

        index = (int) (StrArr.length * Math.random());
        sb.append(StrArr[index]);

        return sb.toString();
    }


    public static String getCreditCartValidTHRU() {
        int index = 0;
        ArrayList<String> strArr = new ArrayList<>();
        for (int i = 2025; i <= 2045; i++) {
            strArr.add(String.valueOf(i));
        }

        StringBuffer sb = new StringBuffer();
        index = (int) (strArr.size() * Math.random());
        sb.append(strArr.get(index));

        return sb.toString();
    }

    public static String getCreditCartValidTHRUMonth() {
        int index = 0;
        ArrayList<String> strArr = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            strArr.add(String.valueOf(i));
        }

        StringBuffer sb = new StringBuffer();
        index = (int) (strArr.size() * Math.random());
        sb.append(strArr.get(index));

        return sb.toString();
    }
}
