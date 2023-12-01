package com.sts.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.OrderDetailDAO;
import com.sts.model.OrderDetail;
import com.sts.service.OrderDetailService;

@Service
public class OrderDetailServiceImpl implements OrderDetailService{
    @Autowired
    OrderDetailDAO orderDetailDao;

    @Override
    public OrderDetail findById(Integer orderDetailId) {
        return orderDetailDao.findById(orderDetailId).get();
    }
    
}
