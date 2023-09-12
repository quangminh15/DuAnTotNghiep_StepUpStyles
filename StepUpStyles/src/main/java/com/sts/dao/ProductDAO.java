package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Product;

public interface ProductDAO extends JpaRepository<Product, Integer>{
	@Query("SELECT c FROM Product c WHERE c.productName LIKE %:keyword%")
	List<Product> findByProductNameContaining(@Param("keyword") String keyword);
}
