package com.sts.service;

import java.util.List;

import com.sts.model.ImportReceipt;
import com.sts.model.ImportReceiptDetail;
import com.sts.model.DTO.ProductQuantityDTO;
import com.sts.model.DTO.ProductQuantityDetailDTO;

public interface ImportReceiptService {

    List<ImportReceipt> findAll();

    ImportReceipt update(ImportReceipt importReceipt);

    ImportReceipt findById(Long importReceiptId);

    void deleteById(Long importReceiptId);

    ImportReceipt updateTotalAmount(Long importReceiptId, ImportReceipt importReceipt);

    ImportReceipt findImportReceiptById(Long importReceiptID);

    List<ImportReceiptDetail> getByImport(Long importReceiptId);

    ImportReceipt create(ImportReceipt importReceipt);

    List<ProductQuantityDTO> getProductQuantityByMonthAndYear(Integer month, Integer year);

    List<ImportReceipt> findByImportNameContaining(String keyword);

    List<ProductQuantityDetailDTO> getProductQuantityByMonthAndYearDetails(Integer month, Integer year);
    
}
