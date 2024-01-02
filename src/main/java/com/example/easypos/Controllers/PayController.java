package com.example.easypos.Controllers;

import com.example.easypos.Services.PayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class PayController {
    private PayService payService;

    @Autowired
    public PayController(PayService payService) {
        this.payService = payService;
    }
}
