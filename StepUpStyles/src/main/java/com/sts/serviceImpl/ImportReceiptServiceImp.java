package com.sts.serviceImpl;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ImportReceiptDAO;
import com.sts.dao.ImportReceiptDetailDAO;
import com.sts.model.ImportReceipt;
import com.sts.model.ImportReceiptDetail;
import com.sts.model.DTO.ProductQuantityDTO;
import com.sts.service.ImportReceiptService;

@Service
public class ImportReceiptServiceImp implements ImportReceiptService{

    @Autowired
    ImportReceiptDAO importDao;

    @Autowired
    ImportReceiptDetailDAO importDetailDao;

    @Override
    public List<ImportReceipt> findAll() {
        return importDao.findAll();
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

    @Override
    public ImportReceipt findImportReceiptById(Long importReceiptID) {
        return importDao.findById(importReceiptID)
        .orElse(null);
    }

    @Override
    public List<ImportReceiptDetail> getByImport(Long importReceiptId) {
        ImportReceipt importReceipt = importDao.findById(importReceiptId).orElse(null);
	    if (importReceipt != null) {
	        List<ImportReceiptDetail> list = importDetailDao.findByImportReceipt(importReceipt);
	        return list;
	    }
	    return Collections.emptyList();
    }

    @Override
    public ImportReceipt create(ImportReceipt importReceipt) {
        return importDao.save(importReceipt);
    }

    @Transactional
    @Override
    public List<ProductQuantityDTO> getProductQuantityByMonthAndYear(Integer month, Integer year) {
        List<Object[]> result = importDao.getProductQuantityByMonthAndYear(month, year);

        return result.stream()
            .map(arr -> new ProductQuantityDTO((String) arr[0], (Integer) arr[1]))
            .collect(Collectors.toList());
    }

    @Override
    public List<ImportReceipt> findByImportNameContaining(String keyword) {
        return importDao.findByImportReceiptContaining(keyword);
    }
}
