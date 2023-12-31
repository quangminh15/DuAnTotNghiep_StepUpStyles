package com.sts.service;

import java.util.List;

import com.sts.model.DirectDiscount;

public interface DiscountService {

	List<DirectDiscount> findAll();

	List<DirectDiscount> getNodeletedDiscount();

	List<DirectDiscount> getDeletedDiscount();

	DirectDiscount create(DirectDiscount directDis);

	DirectDiscount update(DirectDiscount directDis);

	void delete(Long ddid);

	void saveStatus(DirectDiscount directDis);

	void updateDiscountStatus();

	List<DirectDiscount> findByDiscountProduct(String keyword);

	// Lọc danh sách giảm giá theo sản phẩm
	List<DirectDiscount> getdiscountsByProduct(Integer productId);

    List<DirectDiscount> getDiscountsByStatusAndDeleted(String status, boolean deleted);

}
