package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ImportReceiptDetailDAO;
import com.sts.model.ImportReceiptDetail;
import com.sts.service.ImportReceiptDetailService;

@Service
public class ImportReceiptDetailServiceImp implements ImportReceiptDetailService {
    @Autowired
    ImportReceiptDetailDAO importReceiptDetailDAO;

    @Override
    public ImportReceiptDetail findById(Long id) {
        return importReceiptDetailDAO.findById(id).get();
    }

    @Override
    public List<ImportReceiptDetail> findAll() {
       return importReceiptDetailDAO.findAll();
    }

    @Override
    public ImportReceiptDetail create(ImportReceiptDetail importReceiptDetail) {
        return importReceiptDetailDAO.save(importReceiptDetail);
    }
    
}
