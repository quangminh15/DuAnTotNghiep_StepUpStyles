package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.ImportReceipt;
import com.sts.model.ImportReceiptDetail;
import com.sts.model.DTO.ProductImportStatisticDTO;

public interface ImportReceiptDetailDAO extends JpaRepository<ImportReceiptDetail, Long> {
    List<ImportReceiptDetail> findByImportReceipt(ImportReceipt importReceipt);

    
}
