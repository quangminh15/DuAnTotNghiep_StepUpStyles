package com.sts.service;

import java.util.List;

import com.sts.model.Supplier;

public interface SupplierService {

    List<Supplier> findAll();

    Supplier create(Supplier supplier);

    Supplier update(Supplier supplier);

    void deleteById(Long supplierId);

    Supplier findById(Long supplierId);

    boolean markSupplierAsDeleted(Long supplierId);

    List<Supplier> getDeletedSuppliers();

    List<Supplier> findBySupplierNameContaining(String keyword);

    List<Supplier> getHistorySuppliers();

    boolean markSupplierAsHistory(Long supplierId);
}
