package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Color;
import com.sts.model.Product;
import com.sts.model.Size;
import com.sts.model.ProductDetail;


public interface ColorDAO extends JpaRepository<Color, Integer>{
	@Query("SELECT c FROM Color c WHERE c.colorName LIKE %:keyword%")
	List<Color> findByColorNameContaining(@Param("keyword") String keyword);

	// Hai
	List<Color> findByProductDetails_ProductAndProductDetails_Size(Product product,Size size);
	
	 
	// ------
}
