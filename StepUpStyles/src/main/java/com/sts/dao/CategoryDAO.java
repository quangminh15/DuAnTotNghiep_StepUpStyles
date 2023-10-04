package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Category;

public interface CategoryDAO extends JpaRepository<Category, Integer> {
	@Query("SELECT c FROM Category c WHERE c.categoryName LIKE %:keyword%")
	List<Category> findByCateNameContaining(@Param("keyword") String keyword);

	@Query("SELECT c FROM Category c WHERE c.deleted = true")
	List<Category> loadAllDeleted();

	@Query("SELECT c FROM Category c WHERE c.deleted = false")
	List<Category> loadAllNoDeleted();
	
	@Query("SELECT c FROM Category c WHERE c.deleted = false and c.activities = true")
	List<Category> loadAllNoDeletedAndActivitiesTrue();
}
