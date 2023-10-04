package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sts.model.Color;
import com.sts.model.Product;
import com.sts.model.Size;

public interface SizeDAO extends JpaRepository<Size, Integer>{
	@Query("SELECT c FROM Size c WHERE c.sizeNumber LIKE ?1")
	List<Size> findBySizeNumber(Float keyword);
	
	@Query("SELECT c FROM Size c WHERE c.deleted = true")
	List<Size> loadAllDeleted();
	
	@Query("SELECT c FROM Size c WHERE c.deleted = false")
	List<Size> loadAllNoDeleted();
	
	@Query("SELECT c FROM Size c WHERE c.deleted = false and c.activities = true")
	List<Size> loadAllNoDeletedAndActivitiesTrue();

	// Hai
	
	List<Size> findByProductDetails_ProductAndProductDetails_Color(Product product,Color color);
	// ------
	
}
