package com.example.easypos.interceptor;

import com.example.easypos.Vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor {

    private Rq rq;

    @Autowired
    public NeedLoginInterceptor(Rq rq) {
        this.rq = rq;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (rq.getLoginedMember() == null) {
            rq.jsPrintReplace("로그인후 이용해주세요", "/usr/member/loginPage");
            return false;
        }

        return HandlerInterceptor.super.preHandle(request, response, handler);
    }
}
