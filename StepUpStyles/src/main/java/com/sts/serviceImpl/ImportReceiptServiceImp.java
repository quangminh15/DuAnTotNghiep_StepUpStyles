package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ImportReceiptDAO;
import com.sts.model.ImportReceipt;
import com.sts.service.ImportReceiptService;

@Service
public class ImportReceiptServiceImp implements ImportReceiptService{

    @Autowired
    ImportReceiptDAO importDao;

    @Override
    public List<ImportReceipt> findAll() {
        return importDao.findAll();
    }

    @Override
    public ImportReceipt create(ImportReceipt importReceipt) {
        return importDao.save(importReceipt);
    }

    @Override
    public ImportReceipt update(ImportReceipt importReceipt) {
        return importDao.save(importReceipt);
    }

    @Override
    public ImportReceipt findById(Long importReceiptId) {
        return importDao.findById(importReceiptId).get();
    }

    @Override
    public void deleteById(Long importReceiptId) {
        importDao.deleteById(importReceiptId);
    }

    @Override
    public ImportReceipt updateTotalAmount(Long importReceiptId, ImportReceipt importReceipt) {
        ImportReceipt ktImportReceiptId = importDao.findById(importReceiptId).orElse(null);
        if (ktImportReceiptId != null) {
            ktImportReceiptId.setTotalAmount(importReceipt.getTotalAmount());
            return importDao.save(ktImportReceiptId);
        } else {
            return null;
        }
    }
    
}
