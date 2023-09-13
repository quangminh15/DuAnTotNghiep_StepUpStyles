package com.sts.service;

import java.util.List;

import com.sts.model.ProductImage;

public interface ProductImageService {
	ProductImage findById(Integer productImageID);

	List<ProductImage> findAll();

	ProductImage create(ProductImage productImage);

	ProductImage update(ProductImage productImage);

	void delete(Integer productImageID);
	
}
