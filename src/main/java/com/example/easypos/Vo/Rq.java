package com.example.easypos.Vo;

import com.example.easypos.Services.MemberService;
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
    private int loginedMemberId;
    @Getter
    private String businessDate;
    @Getter
    private Members loginedMember;
    @Getter
    private Employee loginedEmployee;
    @Getter
    private int loginedEmployeeCode;
    @Getter
    private int floor;
    @Getter
    private int leftAmount;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;

    public Rq(HttpServletRequest request, HttpServletResponse response, MemberService memberService) {
        HttpSession session = request.getSession();
        this.request = request;
        this.response = response;
        this.session = session;


        String businessDate = "";
        if (session.getAttribute("businessDate") != null) {
            businessDate = (String) session.getAttribute("businessDate");
        }

        int loginedMemberId = 0;
        Members loginedMember = null;
        if (session.getAttribute("loginedMemberId") != null) {
            loginedMemberId = (int) session.getAttribute("loginedMemberId");
            loginedMember = memberService.getMemberById(loginedMemberId);
        }

        int floor = 0;
        int leftAmount = 0;
        if (session.getAttribute("floor") != null) {
            floor = (int) session.getAttribute("floor");
        }

        if (session.getAttribute("leftAmount") != null) {
            leftAmount = (int) session.getAttribute("leftAmount");
        }

        int loginedEmployeeCode = 0;
        Employee loginedEmployee = null;
        if (session.getAttribute("loginedEmployee") != null) {
            loginedEmployeeCode = (int) session.getAttribute("loginedEmployee");
            loginedEmployee = memberService.getEmployee(loginedEmployeeCode);
        }


        this.businessDate = businessDate;
        this.loginedEmployeeCode = loginedEmployeeCode;
        this.loginedEmployee = loginedEmployee;
        this.loginedMemberId = loginedMemberId;
        this.loginedMember = loginedMember;
        this.request.setAttribute("rq", this);
        this.leftAmount = leftAmount;
        this.floor = floor;
        this.request.setAttribute("rq", this);
    }

    public void jsPrintHistoryBack(String msg) {
        this.response.setContentType("text/html; charset=UTF-8;");

        try {
            this.response.getWriter().append(Util.jsHistoryBack(msg));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void jsPrintReplace(String msg, String url) {
        this.response.setContentType("text/html; charset=UTF-8;");

        try {
            this.response.getWriter().append(Util.jsReplace(msg, url));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public String jsReturnOnView(String msg) {
        this.request.setAttribute("msg", msg);
        return "usr/common/errorPage";
    }

    public String jsReturnOnView2(String msg, String url) {
        this.request.setAttribute("msg", msg);
        this.request.setAttribute("url", url);
        return "usr/common/needEmployeeLoginErrorPage";
    }

    public void login(Members member) {
        this.session.setAttribute("loginedMemberId", member.getId());
    }

    public void loginEmployee(Employee employee) {
        this.session.setAttribute("loginedEmployee", employee.getEmployeeCode());
    }

    public void logout() {
        this.session.removeAttribute("loginedMemberId");
    }

    public void logoutToEmployee() {
        this.session.removeAttribute("loginedEmployee");
    }

    public void floor(int floor) {
        this.session.setAttribute("floor", floor);
    }


    public void leftAmount(int amount) {
        this.session.setAttribute("leftAmount", amount);
    }

    public void init() {

    }

    public void setBusinessDate(String businessDate) {
        session.setAttribute("businessDate", businessDate);
    }
}
