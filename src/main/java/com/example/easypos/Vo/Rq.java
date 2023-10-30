package com.example.easypos.Vo;

import com.example.easypos.Util.Util;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
    private HttpServletRequest request;
    private HttpServletResponse response;

    public Rq(HttpServletRequest request, HttpServletResponse response){
        this.request = request;
        this.response = response;

        this.request.setAttribute("rq", this);
    }

    public void jsPrintHistoryBack(String msg){
        this.response.setContentType("text/html; charset=UTF-8;");

        try {
            this.response.getWriter().append(Util.jsHistoryBack(msg));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public String jsReturnOnView(String msg) {
        this.request.setAttribute("msg", msg);
        return "usr/common/errorPage";
    }

    public void init() {

    }
}
