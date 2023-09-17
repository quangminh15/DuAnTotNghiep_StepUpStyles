package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.ProductImage;

public interface ProductImageDAO extends JpaRepository<ProductImage, Integer>{
	@Query("SELECT c FROM ProductImage c WHERE c.product.productName LIKE %:keyword%")
	List<ProductImage> findByProductImageName(@Param("keyword") String keyword);
	
	@Query("SELECT c FROM ProductImage c WHERE c.product.productID = :productId")
	List<ProductImage> findByProduct_ProductID(@Param("productId") Integer productId);
}
