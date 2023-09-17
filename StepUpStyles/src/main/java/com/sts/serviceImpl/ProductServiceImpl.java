package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ProductDAO;
import com.sts.model.Product;
import com.sts.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductDAO productDAO;

	@Override
	public Product findById(Integer productID) {
		return productDAO.findById(productID).get();
	}

	@Override
	public List<Product> findAll() {
		return productDAO.findAll();
	}
	
	@Override
	public List<Product> loadAllDeleted() {
		return productDAO.loadAllDeleted();
	}

	@Override
	public List<Product> loadAllNoDeleted() {
		return productDAO.loadAllNoDeleted();
	}

	@Override
	public Product create(Product product) {
		return productDAO.save(product);
	}

	@Override
	public Product update(Product product) {
		return productDAO.save(product);
	}

	@Override
	public void delete(Integer productID) {
		productDAO.deleteById(productID);
	}

	@Override
	public List<Product> searchByName(String keyword) {
		return productDAO.findByProductNameContaining(keyword);
	}
}
