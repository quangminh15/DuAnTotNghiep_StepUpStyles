package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.SupplierDAO;
import com.sts.model.Supplier;
import com.sts.service.SupplierService;

@Service
public class SupplierServiceImp implements SupplierService {

    @Autowired
    SupplierDAO supDao;

    @Override
    public List<Supplier> findAll() {
        return supDao.findAll();
    }

    @Override
    public Supplier create(Supplier supplier) {
        return supDao.save(supplier);
    }

    @Override
    public Supplier update(Supplier supplier) {
        return supDao.save(supplier);
    }

    @Override
    public void deleteById(Long supplierId) {
        supDao.deleteById(supplierId);
    }

    @Override
    public Supplier findById(Long supplierId) {
        return supDao.findById(supplierId).get();
    }

    @Override
    public List<Supplier> getDeletedSuppliers() {
        return supDao.findByDeletedFalse();
    }

    @Override
    public List<Supplier> findBySupplierNameContaining(String keyword) {
        return supDao.findBySupplierNameContaining(keyword);
    }

    @Override
    public List<Supplier> getHistorySuppliers() {
        return supDao.findByDeletedTrue();
    }

    @Override
    public List<Supplier> findByDisplay() {
        return supDao.findByDisplayTrueAndDeletedFalse();
    }
}
