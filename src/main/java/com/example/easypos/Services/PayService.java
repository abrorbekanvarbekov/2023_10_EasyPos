package com.example.easypos.Services;

import com.example.easypos.DAO.PayDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PayService {
    private PayDao payDao;
    @Autowired
    public PayService(PayDao payDao) {
        this.payDao = payDao;
    }
}
