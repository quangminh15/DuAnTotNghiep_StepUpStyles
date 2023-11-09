package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Order;
import com.sts.model.OrderDetail;

public interface OrderDetailDAO extends JpaRepository<OrderDetail,Integer>{
    List<OrderDetail> findByOrder(Order order);
}
