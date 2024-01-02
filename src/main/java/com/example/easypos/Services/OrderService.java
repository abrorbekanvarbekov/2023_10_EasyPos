package com.example.easypos.Services;

import com.example.easypos.DAO.OrderDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService {
    private OrderDao orderDao;
    @Autowired
    public OrderService(OrderDao orderDao) {
        this.orderDao = orderDao;
    }
}
