package com.sts.service;

import java.util.List;

import com.sts.model.ImportReceiptDetail;

public interface ImportReceiptDetailService {

    ImportReceiptDetail findById(Long id);

    List<ImportReceiptDetail> findAll();

    ImportReceiptDetail create(ImportReceiptDetail importReceiptDetail);
    
}
