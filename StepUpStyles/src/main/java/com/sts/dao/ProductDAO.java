package com.sts.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Category;
import com.sts.model.Product;

public interface ProductDAO extends JpaRepository<Product, Integer>{
	@Query("SELECT c FROM Product c WHERE c.productName LIKE %:keyword%")
	List<Product> findByProductNameContaining(@Param("keyword") String keyword);
	
	@Query("SELECT c FROM Product c WHERE c.deleted = true")
	List<Product> loadAllDeleted();

	@Query("SELECT c FROM Product c WHERE c.deleted = false")
	List<Product> loadAllNoDeleted();
	
	@Query("SELECT c FROM Product c WHERE c.deleted = false and c.activities = true")
	List<Product> loadAllNoDeletedAndActivitiesTrue();

	Long countByCategory(Category category);
	
	//Đếm số lượng sản phẩm để hiển thị lên danh mục người dùng
	@Query("SELECT COUNT(p) FROM Product p WHERE p.category = :category AND p.activities = :activities AND p.deleted = :deleted")
	Long countProductsByCategoryWithConditions(@Param("category") Category category, @Param("activities") Boolean activities, @Param("deleted") Boolean deleted);

	
	// Truy vấn tùy chỉnh để đếm sản phẩm theo danh mục
    @Query("SELECT COUNT(p) FROM Product p WHERE p.category = :category")
    Long countProductsByCategory(@Param("category") Category category);

	 List<Product> findByCategory(Category category);
}
