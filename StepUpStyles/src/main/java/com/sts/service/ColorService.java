package com.sts.service;

import java.util.List;

import com.sts.model.Color;

public interface ColorService {

	Color findById(Integer colorID);

	List<Color> findAll();

	Color create(Color color);

	Color update(Color color);

	void delete(Integer colorID);
	
	List<Color> searchByName(String keyword);
}
