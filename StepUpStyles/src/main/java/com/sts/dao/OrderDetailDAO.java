package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.OrderDetail;

public interface OrderDetailDAO extends JpaRepository<OrderDetail,Integer>{
    
}
