package com.sts.serviceImpl;

import java.util.List;
import java.util.Optional;

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
    public boolean markSupplierAsDeleted(Long supplierId) {
        Optional<Supplier> optionalSupplier = supDao.findById(supplierId);

        if (optionalSupplier.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            supplier.setDeleted(true);
            supDao.save(supplier);
            return true;
        }
        return false;
    }

    @Override
    public List<Supplier> getDeletedSuppliers() {
        return supDao.findByDeletedFalse();
    }

    @Override
    public List<Supplier> findBySupplierNameContaining(String keyword) {
        return supDao.findBySupplierNameContaining(keyword);
    }
}
