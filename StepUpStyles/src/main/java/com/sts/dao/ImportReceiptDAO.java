package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.ImportReceipt;

public interface ImportReceiptDAO extends JpaRepository<ImportReceipt, Long> {
    
}
