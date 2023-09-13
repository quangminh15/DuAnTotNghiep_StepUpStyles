package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Cart;
import com.sts.model.User;
import java.util.List;


public interface CartDAO extends JpaRepository<Cart,Integer>{
    Cart findByUser(User user);
}
