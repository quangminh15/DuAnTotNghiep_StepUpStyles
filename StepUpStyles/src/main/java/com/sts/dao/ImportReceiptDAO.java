package com.sts.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.ImportReceipt;

public interface ImportReceiptDAO extends JpaRepository<ImportReceipt, Long> {

    Optional<ImportReceipt> findByImportReceiptId(Long importReceiptId);
    
}
