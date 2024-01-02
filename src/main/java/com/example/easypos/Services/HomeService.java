package com.example.easypos.Services;

import com.example.easypos.DAO.HomeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HomeService {
    private HomeDao homeDao;
    @Autowired
    public HomeService(HomeDao homeDao) {
        this.homeDao = homeDao;
    }
}
