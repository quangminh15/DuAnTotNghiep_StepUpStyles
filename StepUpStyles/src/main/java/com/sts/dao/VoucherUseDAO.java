package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.VoucherUse;

public interface VoucherUseDAO extends JpaRepository<VoucherUse, Long>{
    
}
