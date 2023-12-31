package com.sts.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.sts.model.Category;
import com.sts.model.Product;
import com.sts.model.DTO.BrandProductCountDTO;
import com.sts.model.DTO.CategoryProductCountDTO;

public interface ProductService {
	Product findById(Integer productID);

	List<Product> findAll();

	List<Product> loadAllDeleted();

	List<Product> loadAllNoDeleted();

	List<Product> loadAllNoDeletedAndActivitiesTrue();

	Product create(Product product);

	Product update(Product product);

	void delete(Integer productID);

	List<Product> searchByName(String keyword);

	List<CategoryProductCountDTO> getCategoryProductCount();
	
	List<BrandProductCountDTO> getBrandProductCount();

//	List<Product> loadAllNoDeletedAndActivitiesTrue();

	Long countProductsByCategory(Category category);

	// Đếm số lượng sản phẩm để hiển thị lên danh mục người dùng
	Long countProductsByCategoryWithConditions(Category category, Boolean activities, Boolean deleted);

	List<Product> findByCategory(Category category);
	
	// sản phẩm nỏi bật
	List<Product> findFeaturedProducts();

	// Sản phẩm tương tự
	List<Product> findSimilarProductsByCategory(Integer categoryID);

	Product getProductById(Integer productId);
	// Lọc sản phẩm theo brand
	List<Product> getProductsByBrandID(Integer brandID);

	// Lọc sản phẩm theo category
	List<Product> getProductsByCategoryID(Integer categoryID);

	List<Product> loadDiscountedProducts();
}
