package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.SizeDAO;
import com.sts.model.Size;
import com.sts.service.SizeService;

@Service
public class SizeServiceImpl implements SizeService {
	@Autowired
	SizeDAO sizeDAO;

	@Override
	public Size findById(Integer sizeID) {
		return sizeDAO.findById(sizeID).get();
	}

	@Override
	public List<Size> findAll() {
		return sizeDAO.findAll();
	}

	@Override
	public Size create(Size size) {
		return sizeDAO.save(size);
	}

	@Override
	public Size update(Size size) {
		return sizeDAO.save(size);
	}

	@Override
	public void delete(Integer sizeID) {
		sizeDAO.deleteById(sizeID);
	}

	@Override
	public List<Size> searchByName(String keyword) {
		return sizeDAO.findBySizeNumberContaining(keyword);
	}

}
