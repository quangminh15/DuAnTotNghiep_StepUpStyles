package com.sts.service;

import java.util.List;

import com.sts.model.Product;

public interface ProductService {
	Product findById(Integer productID);

	List<Product> findAll();

	Product create(Product product);

	Product update(Product product);

	void delete(Integer productID);
	
	List<Product> searchByName(String keyword);
}
