package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Voucher;

public interface VoucherDAO extends JpaRepository<Voucher, Long> {
    List<Voucher> findByDeletedFalse();

	List<Voucher> findByDeletedTrue();

    List<Voucher> findByDeletedFalseAndDateEndGreaterThan(String currentDate);

     @Query("SELECT v FROM Voucher v WHERE v.total LIKE %:keyword% OR v.description LIKE %:keyword% OR v.discountAmount LIKE %:keyword%")
    List<Voucher> findByVoucherContaining(@Param("keyword") String keyword);
}