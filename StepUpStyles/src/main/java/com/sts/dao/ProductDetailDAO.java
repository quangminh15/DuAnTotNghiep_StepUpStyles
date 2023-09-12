package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.ProductDetail;

public interface ProductDetailDAO extends JpaRepository<ProductDetail, Integer>{
	@Query("SELECT c FROM ProductDetail c WHERE c.product.productName LIKE %:keyword%")
	List<ProductDetail> findByProductDetailNameContaining(@Param("keyword") String keyword);
}
