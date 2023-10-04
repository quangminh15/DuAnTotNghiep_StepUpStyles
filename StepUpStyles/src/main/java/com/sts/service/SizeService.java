package com.sts.service;

import java.util.List;

import com.sts.model.Size;

public interface SizeService {
	Size findById(Integer sizeID);

	List<Size> findAll();
	
	List<Size> loadAllDeleted();
	
	List<Size> loadAllNoDeleted();

	Size create(Size size);

	Size update(Size size);

	void delete(Integer sizeID);
	
	List<Size> searchByName(Float keyword);

	List<Size> loadAllNoDeletedAndActivitiesTrue();

	

	
}
