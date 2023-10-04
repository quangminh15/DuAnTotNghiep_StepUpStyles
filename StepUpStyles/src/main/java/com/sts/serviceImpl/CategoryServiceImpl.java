package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.CategoryDAO;
import com.sts.model.Category;
import com.sts.service.CategoryService;
import com.sts.service.ProductService;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	CategoryDAO cateDAO;

	@Autowired
	private ProductService productService;

	@Override
	public Category findById(Integer categoryID) {
		return cateDAO.findById(categoryID).get();
	}

	@Override
	public List<Category> findAll() {
		return cateDAO.findAll();
	}

	@Override
	public List<Category> loadAllDeleted() {
		return cateDAO.loadAllDeleted();
	}

	@Override
	public List<Category> loadAllNoDeleted() {
		return cateDAO.loadAllNoDeleted();
	}

	@Override
	public List<Category> loadAllNoDeletedAndActivitiesTrue() {
		return cateDAO.loadAllNoDeletedAndActivitiesTrue();
	}

	@Override
	public Category create(Category category) {
		return cateDAO.save(category);
	}

	@Override
	public Category update(Category category) {
		return cateDAO.save(category);
	}

	@Override
	public void delete(Integer categoryID) {
		cateDAO.deleteById(categoryID);
	}

	@Override
	public List<Category> searchByName(String keyword) {
		return cateDAO.findByCateNameContaining(keyword);
	}
	
	// Đếm số lượng sản phẩm trong mỗi danh mục dựa trên ProductService
    @Override
    public Long countProductsByCategory(Category category) {
        return productService.countProductsByCategory(category);
    }
}
