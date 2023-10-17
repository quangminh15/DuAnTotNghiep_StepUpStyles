package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ProductImageDAO;
import com.sts.model.ProductImage;
import com.sts.service.ProductImageService;

@Service
public class ProductImageServiceImpl implements ProductImageService {
	@Autowired
	ProductImageDAO ProductImageDAO;

	@Override
	public ProductImage findById(Integer productImageID) {
		return ProductImageDAO.findById(productImageID).get();
	}

	@Override
	public List<ProductImage> findAll() {
		return ProductImageDAO.findAll();
	}

	@Override
	public ProductImage create(ProductImage productImage) {
		return ProductImageDAO.save(productImage);
	}

	@Override
	public ProductImage update(ProductImage productImage) {
		return ProductImageDAO.save(productImage);
	}

	@Override
	public void delete(Integer productImageID) {
		ProductImageDAO.deleteById(productImageID);
	}

	@Override
	public List<ProductImage> getImagesByProduct(Integer productId) {
		return ProductImageDAO.findByProduct_ProductID(productId);
	}

	@Override
	public List<ProductImage> searchByName(String keyword) {
		return ProductImageDAO.findByProductImageName(keyword);
	}
}
