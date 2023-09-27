package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.DirectDiscount;

public interface DirectDiscountDAO extends JpaRepository<DirectDiscount, Long> {
    List<DirectDiscount> findByDeletedFalse();

    List<DirectDiscount> findByDeletedTrue();

    @Query("SELECT d FROM DirectDiscount d WHERE d.product.productName LIKE %:keyword%")
    List<DirectDiscount> findByDiscountProduct(@Param("keyword") String keyword);
}
