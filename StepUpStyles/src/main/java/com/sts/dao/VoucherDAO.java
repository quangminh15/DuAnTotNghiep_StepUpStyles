package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Voucher;

public interface VoucherDAO extends JpaRepository<Voucher, Long> {
    List<Voucher> findByDeletedFalse();

	List<Voucher> findByDeletedTrue();

    List<Voucher> findByDeletedFalseAndDateEndGreaterThan(String currentDate);
}