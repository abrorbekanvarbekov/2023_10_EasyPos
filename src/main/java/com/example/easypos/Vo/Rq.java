package com.example.easypos.Vo;

import com.example.easypos.Util.Util;
import lombok.Getter;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
    @Getter
    private int floor;
    @Getter
    private int leftAmount;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;

    public Rq(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        this.request = request;
        this.response = response;
        this.session = session;

        int floor = 0;
        int leftAmount = 0;
        if (session.getAttribute("floor") != null){
            floor = (int) session.getAttribute("floor");
        }

        if (session.getAttribute("leftAmount") != null){
            leftAmount = (int) session.getAttribute("leftAmount");
        }

        this.leftAmount =  leftAmount;
        this.floor = floor;
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

    public void floor(int floor) {
        this.session.setAttribute("floor", floor);
    }


    public void leftAmount(int amount) {
        this.session.setAttribute("leftAmount", amount);
    }

    public void init() {

    }
}
