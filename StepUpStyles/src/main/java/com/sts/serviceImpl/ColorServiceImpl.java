package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ColorDAO;
import com.sts.model.Color;
import com.sts.service.ColorService;

@Service
public class ColorServiceImpl implements ColorService  {
	@Autowired
	ColorDAO ColorDAO;

	@Override
	public Color findById(Integer colorID) {
		return ColorDAO.findById(colorID).get();
	}

	@Override
	public List<Color> findAll() {
		return ColorDAO.findAll();
	}
	
	@Override
	public List<Color> loadAllDeleted() {
		return ColorDAO.loadAllDeleted();
	}

	@Override
	public List<Color> loadAllNoDeleted() {
		return ColorDAO.loadAllNoDeleted();
	}
	
	@Override
	public List<Color> loadAllNoDeletedAndActivitiesTrue() {
		return ColorDAO.loadAllNoDeletedAndActivitiesTrue();
	}

	@Override
	public Color create(Color color) {
		return ColorDAO.save(color);
	}

	@Override
	public Color update(Color color) {
		return ColorDAO.save(color);
	}

	@Override
	public void delete(Integer colorID) {
		ColorDAO.deleteById(colorID);

	}

	@Override
	public List<Color> searchByName(String keyword) {
		return ColorDAO.findByColorNameContaining(keyword);
	}
}
