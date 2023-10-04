package com.sts.service;

import java.util.List;

import com.sts.model.Category;

public interface CategoryService {
	Category findById(Integer categoryID);

	List<Category> findAll();

	List<Category> loadAllDeleted();

	List<Category> loadAllNoDeleted();

	Category create(Category category);

	Category update(Category category);

	void delete(Integer categoryID);

	List<Category> searchByName(String keyword);

	List<Category> loadAllNoDeletedAndActivitiesTrue();
	
	Long countProductsByCategory(Category category);
}
