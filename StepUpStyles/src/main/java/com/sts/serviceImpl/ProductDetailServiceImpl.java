package com.sts.serviceImpl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ColorDAO;
import com.sts.dao.ProductDAO;
import com.sts.dao.ProductDetailDAO;
import com.sts.dao.SizeDAO;
import com.sts.model.Color;
import com.sts.model.Product;
import com.sts.model.ProductDetail;
import com.sts.model.Size;
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
	public List<ProductDetail> loadAllDeleted() {
		return productDetailDAO.loadAllDeleted();
	}

	@Override
	public List<ProductDetail> loadAllNoDeleted() {
		return productDetailDAO.loadAllNoDeleted();
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

	// test

	@Override
	public List<ProductDetail> getProductDetailsByCategory(Integer categoryId) {
		// Thực hiện truy vấn danh sách ProductDetail theo categoryId
		List<ProductDetail> allProductDetails = productDetailDAO.findAll(); // Lấy tất cả sản phẩm
		List<ProductDetail> productDetailsByCategory = new ArrayList<>();

		for (ProductDetail productDetail : allProductDetails) {
			if (productDetail.getProduct().getCategory().getCategoryID().equals(categoryId)) {
				productDetailsByCategory.add(productDetail);
			}
		}

		return productDetailsByCategory;
	}
	
	@Override
	public List<ProductDetail> getProductDetailsByBrand(Integer brandId) {
		// Thực hiện truy vấn danh sách ProductDetail theo categoryId
		List<ProductDetail> allProductDetails = productDetailDAO.findAll(); // Lấy tất cả sản phẩm
		List<ProductDetail> productDetailsByBrand = new ArrayList<>();

		for (ProductDetail productDetail : allProductDetails) {
			if (productDetail.getProduct().getBrand().getBrandID().equals(brandId)) {
				productDetailsByBrand.add(productDetail);
			}
		}

		return productDetailsByBrand;
	}

	// Hai
	@Autowired
	ProductDAO prodDao;
	@Autowired
	ColorDAO colorDao;
	@Autowired
	SizeDAO sizeDao;

	@Override
	public ProductDetail findProdDetail(Integer prodId, Integer sizeId, Integer colorId) {
		Product prod = prodDao.findById(prodId).get();
		Size size = sizeDao.findById(sizeId).get();
		Color color = colorDao.findById(colorId).get();
		return productDetailDAO.findProductDetail(prod, size, color);
	}

}
