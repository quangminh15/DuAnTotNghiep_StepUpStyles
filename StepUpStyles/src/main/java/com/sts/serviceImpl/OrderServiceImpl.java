package com.sts.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.OrderDAO;
import com.sts.dao.OrderDetailDAO;

@Service
public class OrderServiceImpl {
    @Autowired
    OrderDAO orderDao;
    @Autowired
    OrderDetailDAO orderDetailDao;

    
}
