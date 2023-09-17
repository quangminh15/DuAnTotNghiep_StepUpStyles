package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ProductDetailDAO;
import com.sts.model.ProductDetail;
import com.sts.service.ProductDetailService;

@Service
public class ProductDetailServiceImpl implements ProductDetailService {
	@Autowired
	ProductDetailDAO productDetailDAO;

	@Override
	public ProductDetail findById(Integer productDetailID) {
		return productDetailDAO.findById(productDetailID).get();
	}

	@Override
	public List<ProductDetail> findAll() {
		return productDetailDAO.findAll();
	}

	@Override
	public ProductDetail create(ProductDetail productDetail) {
		return productDetailDAO.save(productDetail);
	}

	@Override
	public ProductDetail update(ProductDetail productDetail) {
		return productDetailDAO.save(productDetail);
	}

	@Override
	public void delete(Integer productDetailID) {
		productDetailDAO.deleteById(productDetailID);
	}

	@Override
	public List<ProductDetail> searchByName(String keyword) {
		return productDetailDAO.findByProductDetailName(keyword);
	}

	@Override
	public List<ProductDetail> getProductDetailByProduct(Integer productId) {
		return productDetailDAO.findByProduct_ProductID(productId);
	}

}
