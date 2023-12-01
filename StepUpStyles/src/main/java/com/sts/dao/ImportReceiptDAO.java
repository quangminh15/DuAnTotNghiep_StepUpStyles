package com.sts.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.ImportReceipt;

public interface ImportReceiptDAO extends JpaRepository<ImportReceipt, Long> {

    Optional<ImportReceipt> findByImportReceiptId(Long importReceiptId);

   @Query(value = "EXEC GetProductQuantityByMonthAndYear :month, :year", nativeQuery = true)
    List<Object[]> getProductQuantityByMonthAndYear(@Param("month") Integer month, @Param("year") Integer year);

    @Query("SELECT i FROM ImportReceipt i WHERE i.user.fullName LIKE %:keyword% OR i.supplier.supplierName LIKE %:keyword% OR i.importReceiptId LIKE %:keyword% OR i.totalAmount LIKE %:keyword%")
    List<ImportReceipt> findByImportReceiptContaining(@Param("keyword") String keyword);
}
