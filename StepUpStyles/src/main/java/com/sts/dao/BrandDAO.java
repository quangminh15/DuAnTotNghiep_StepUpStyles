package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Brand;

public interface BrandDAO extends JpaRepository<Brand, Integer> {
	@Query("SELECT c FROM Brand c WHERE c.brandName LIKE %:keyword%")
	List<Brand> findByBrandNameContaining(@Param("keyword") String keyword);

	@Query("SELECT c FROM Brand c WHERE c.deleted = true")
	List<Brand> loadAllDeleted();

	@Query("SELECT c FROM Brand c WHERE c.deleted = false")
	List<Brand> loadAllNoDeleted();
}
