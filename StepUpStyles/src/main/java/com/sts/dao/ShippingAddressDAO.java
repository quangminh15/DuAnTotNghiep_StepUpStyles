package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sts.model.ShippingAddress;
import com.sts.model.User;

public interface ShippingAddressDAO extends JpaRepository<ShippingAddress,Integer>{
    
    List<ShippingAddress> findByUser(User user);

    @Query("Select s from ShippingAddress s where s.user.usersId=?1 and s.defaultAddress = true")
    ShippingAddress findByUserAndDefault(Integer userId);
}
