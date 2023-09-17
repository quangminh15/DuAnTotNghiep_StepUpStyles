package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.ProductDetail;

public interface ProductDetailDAO extends JpaRepository<ProductDetail, Integer> {
	@Query("SELECT c FROM ProductDetail c WHERE c.product.productName LIKE %:keyword%")
	List<ProductDetail> findByProductDetailName(@Param("keyword") String keyword);

	@Query("SELECT c FROM ProductDetail c WHERE c.product.productID = :productId")
	List<ProductDetail> findByProduct_ProductID(@Param("productId") Integer productId);

	@Query("SELECT c FROM ProductDetail c WHERE c.deleted = true")
	List<ProductDetail> loadAllDeleted();

	@Query("SELECT c FROM ProductDetail c WHERE c.deleted = false")
	List<ProductDetail> loadAllNoDeleted();
}
