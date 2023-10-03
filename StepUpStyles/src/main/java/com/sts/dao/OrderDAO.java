package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Order;

public interface OrderDAO extends JpaRepository<Order,Integer>{
    
}
