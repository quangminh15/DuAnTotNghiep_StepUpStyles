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
	public List<Size> loadAllDeleted() {
		return sizeDAO.loadAllDeleted();
	}
	
	@Override
	public List<Size> loadAllNoDeleted() {
		return sizeDAO.loadAllNoDeleted();
	}
	
	@Override
	public List<Size> loadAllNoDeletedAndActivitiesTrue() {
		return sizeDAO.loadAllNoDeletedAndActivitiesTrue();
	}
	
	@Override
    public List<Size> searchByName(Float keyword) {
        return sizeDAO.findBySizeNumber(keyword);
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
}
