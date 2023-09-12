package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.BrandDAO;
import com.sts.model.Brand;
import com.sts.service.BrandService;

@Service
public class BrandServiceImpl implements BrandService {
	@Autowired
	BrandDAO brandDAO;

	@Override
	public Brand findById(Integer brandID) {
		return brandDAO.findById(brandID).get();
	}

	@Override
	public List<Brand> findAll() {
		return brandDAO.findAll();
	}

	@Override
	public Brand create(Brand brand) {
		return brandDAO.save(brand);
	}

	@Override
	public Brand update(Brand brand) {
		return brandDAO.save(brand);
	}

	@Override
	public void delete(Integer brandID) {
		brandDAO.deleteById(brandID);
	}

	@Override
	public List<Brand> searchByName(String keyword) {
		return brandDAO.findByBrandNameContaining(keyword);
	}

}
