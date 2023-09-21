package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.DirectDiscount;

public interface DirectDiscountDAO extends JpaRepository<DirectDiscount, Long> {
    List<DirectDiscount> findByDeletedFalse();

    List<DirectDiscount> findByDeletedTrue();
}
