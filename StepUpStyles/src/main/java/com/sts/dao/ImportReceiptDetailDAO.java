package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.ImportReceipt;
import com.sts.model.ImportReceiptDetail;

public interface ImportReceiptDetailDAO extends JpaRepository<ImportReceiptDetail, Long> {
    List<ImportReceiptDetail> findByImportReceipt(ImportReceipt importReceipt);
}
