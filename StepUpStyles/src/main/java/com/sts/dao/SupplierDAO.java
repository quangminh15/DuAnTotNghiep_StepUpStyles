package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Supplier;

public interface SupplierDAO extends JpaRepository<Supplier, Long> {
    List<Supplier> findByDeletedFalse();
}
