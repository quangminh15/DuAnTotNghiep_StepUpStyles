package com.sts.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import com.sts.model.Category;
import com.sts.model.Product;
import com.sts.model.DTO.CategoryProductCountDTO;

public interface ProductService {
	Product findById(Integer productID);

	List<Product> findAll();

	List<Product> loadAllDeleted();

	List<Product> loadAllNoDeleted();

	Product create(Product product);

	Product update(Product product);

	void delete(Integer productID);

	List<Product> searchByName(String keyword);

	List<CategoryProductCountDTO> getCategoryProductCount();

	List<Product> loadAllNoDeletedAndActivitiesTrue();

	Long countProductsByCategory(Category category);

	// Đếm số lượng sản phẩm để hiển thị lên danh mục người dùng
	Long countProductsByCategoryWithConditions(Category category, Boolean activities, Boolean deleted);

	List<Product> findByCategory(Category category);
}
