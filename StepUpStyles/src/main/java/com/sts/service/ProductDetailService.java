package com.sts.service;

import java.util.List;

import com.sts.model.ProductDetail;

public interface ProductDetailService {
	ProductDetail findById(Integer productDetailID);

	List<ProductDetail> findAll();

	ProductDetail create(ProductDetail productDetail);

	ProductDetail update(ProductDetail productDetail);

	void delete(Integer productDetailID);
	
	List<ProductDetail> searchByName(String keyword);

	List<ProductDetail> getProductDetailByProduct(Integer productId);
}
