package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Color;

public interface ColorDAO extends JpaRepository<Color, Integer>{
	@Query("SELECT c FROM Color c WHERE c.colorName LIKE %:keyword%")
	List<Color> findByColorNameContaining(@Param("keyword") String keyword);

	@Query("SELECT c FROM Color c WHERE c.product.productID = :productId")
	List<Color> findByProduct_ProductID(@Param("productId") Integer productId);
}
