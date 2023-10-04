package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.PaymentMenthod;

public interface PaymentMethodDAO extends JpaRepository<PaymentMenthod,Integer>{
    
}
