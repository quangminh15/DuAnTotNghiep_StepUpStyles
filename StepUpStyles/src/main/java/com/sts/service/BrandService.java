package com.sts.service;

import java.util.List;

import com.sts.model.Brand;

public interface BrandService {
	Brand findById(Integer brandID);

	List<Brand> findAll();

	List<Brand> loadAllDeleted();

	List<Brand> loadAllNoDeleted();

	Brand create(Brand brand);

	Brand update(Brand brand);

	void delete(Integer brandID);

	List<Brand> searchByName(String keyword);
}
