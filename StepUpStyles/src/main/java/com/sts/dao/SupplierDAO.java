package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Supplier;

public interface SupplierDAO extends JpaRepository<Supplier, Long> {
    List<Supplier> findByDeletedFalse();

    List<Supplier> findByDeletedTrue();

    List<Supplier> findByDisplayTrueAndDeletedFalse();

    @Query("SELECT s FROM Supplier s WHERE s.supplierName LIKE %:keyword% OR s.email LIKE %:keyword% OR s.addresss LIKE %:keyword% OR s.phone LIKE %:keyword%")
    List<Supplier> findBySupplierNameContaining(@Param("keyword") String keyword);

}
