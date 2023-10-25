package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Order;
import com.sts.model.OrderStatus;
import com.sts.model.User;

import java.util.List;


public interface OrderDAO extends JpaRepository<Order,Integer>{
    List<Order> findByUser(User user);

    List<Order> findByOrderStatus(OrderStatus orderStatus);
}
