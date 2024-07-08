package com.example.easypos.config;

import com.example.easypos.interceptor.BeforeActionInterceptor;
import com.example.easypos.interceptor.NeedEmployeeLoginInterceptor;
import com.example.easypos.interceptor.NeedLoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
    private BeforeActionInterceptor beforeActionInterceptor;
    private NeedLoginInterceptor needLoginInterceptor;
    private NeedEmployeeLoginInterceptor needEmployeeLoginInterceptor;

    @Autowired
    public MyWebMvcConfigurer(BeforeActionInterceptor beforeActionInterceptor
            ,NeedLoginInterceptor needLoginInterceptor
            ,NeedEmployeeLoginInterceptor needEmployeeLoginInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
        this.needLoginInterceptor = needLoginInterceptor;
        this.needEmployeeLoginInterceptor = needEmployeeLoginInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(beforeActionInterceptor)
                .addPathPatterns("/**")
                .addPathPatterns("/favicon.ico")
                .excludePathPatterns("/resource/**");
        registry.addInterceptor(needLoginInterceptor)
//                .addPathPatterns("/")
                .addPathPatterns("/usr/main/salesSummary")
                .addPathPatterns("/usr/member/employeeListPage")
                .addPathPatterns("/usr/tables/detail")
                .addPathPatterns("/usr/home/homeMainPage")
                .addPathPatterns("/usr/home-main/receiptReturn")
                .addPathPatterns("/usr/home-main/salesHistory")
                .addPathPatterns("/usr/tables/orderPage/payByCreditCart")
                .addPathPatterns("/usr/tables/orderPage/payByCash")
                .addPathPatterns("/usr/home-main/deadlineSettlement");
        registry.addInterceptor(needEmployeeLoginInterceptor)
                .addPathPatterns("/")
                .addPathPatterns("/usr/main/salesSummary")
                .addPathPatterns("/usr/tables/detail")
                .addPathPatterns("/usr/home/homeMainPage")
                .addPathPatterns("/usr/home-main/receiptReturn")
                .addPathPatterns("/usr/home-main/salesHistory")
                .addPathPatterns("/usr/tables/orderPage/payByCreditCart")
                .addPathPatterns("/usr/tables/orderPage/payByCash")
                .addPathPatterns("/usr/home-main/deadlineSettlement");
    }

}
