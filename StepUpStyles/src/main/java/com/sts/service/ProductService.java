package com.sts.service;

import java.util.List;

import com.sts.model.Product;
import com.sts.model.DTO.CategoryProductCountDTO;
import com.sts.model.DTO.ProductWithCount;

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
}
