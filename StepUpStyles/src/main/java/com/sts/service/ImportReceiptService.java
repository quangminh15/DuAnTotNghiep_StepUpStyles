package com.sts.service;

import java.util.List;

import com.sts.model.ImportReceipt;
import com.sts.model.ImportReceiptDetail;

public interface ImportReceiptService {

    List<ImportReceipt> findAll();

    ImportReceipt update(ImportReceipt importReceipt);

    ImportReceipt findById(Long importReceiptId);

    void deleteById(Long importReceiptId);

    ImportReceipt updateTotalAmount(Long importReceiptId, ImportReceipt importReceipt);

    ImportReceipt findImportReceiptById(Long importReceiptID);

    List<ImportReceiptDetail> getByImport(Long importReceiptId);

    ImportReceipt create(ImportReceipt importReceipt);
    
}
